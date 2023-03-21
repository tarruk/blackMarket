//
//  AuthService.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 23/12/2022.
//

import Foundation
import RSSwiftNetworking

protocol AuthServiceProtocol {
  func signUp(
    username: String,
    email: String,
    password: String,
    passwordConfirmation: String
  ) async throws -> String
  
  func logIn(email: String, password: String) async throws -> String
}

final class AuthService: AuthServiceProtocol {
  
  enum AuthError: Error {
    case userSessionInvalid
  }
  
  private let sessionManager: SessionManager
  private let userDataManager: UserDataManager
  private let apiClient: BMClient
  
  init(
    apiClient: BMClient = BMClient.shared,
    sessionManager: SessionManager = SessionManager.shared,
    userDataManager: UserDataManager = UserDataManager.shared
  ) {
    self.apiClient = apiClient
    self.sessionManager = sessionManager
    self.userDataManager = userDataManager
  }
  
  func signUp(
    username: String,
    email: String,
    password: String,
    passwordConfirmation: String
  ) async throws -> String {
    let response: BMRequestResponse<GenericResponse> = await apiClient.request(
      endpoint: AuthEndpoint.signIn(
        email: email,
        password: password,
        passwordConfirmation: passwordConfirmation
      )
    )
    
    switch response.result {
    case .success(let response):
      guard let detail = response?.detail else {
        throw AuthError.userSessionInvalid
      }
      return detail
    case .failure(let error):
      throw error
    }
  }
  
  func logIn(email: String, password: String) async throws -> String {
    let response: BMRequestResponse<UserResponse> = await apiClient.requestWithoutCookies(
      endpoint: AuthEndpoint.logIn(
        email: email,
        password: password
      )
    )
  
    switch response.result {
    case .success(let userResponse):
      guard
        let user = userResponse?.user,
        let accessToken = userResponse?.accessToken,
        let refreshToken = userResponse?.refreshToken,
        await saveUserSession(
          user,
          accessToken: accessToken,
          refreshToken: refreshToken
        ) else {
        throw AuthError.userSessionInvalid
      }
      
      return ""
    case .failure(let error):
      throw error
    }
  }
  
  
  @MainActor
  private func saveUserSession(
    _ user: User?,
    accessToken: String,
    refreshToken: String
  ) -> Bool {
    userDataManager.currentUser = user
    sessionManager.saveSession(accessToken: accessToken, refreshToken: refreshToken)
    return userDataManager.currentUser != nil && sessionManager.isValidSession
  }
}
