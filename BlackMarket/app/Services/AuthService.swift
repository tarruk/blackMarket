//
//  AuthService.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 23/12/2022.
//

import Foundation
import RSSwiftNetworking
import ComposableArchitecture

enum AuthResult {
  case signUp(TaskResult<String>)
}

protocol AuthServiceProtocol {
  func signUp(
    username: String,
    email: String,
    password: String,
    passwordConfirmation: String
  ) async throws -> String
}

final class AuthService: BMClient, AuthServiceProtocol {
  
  enum AuthError: Error {
    case userSessionInvalid
  }
  
  private let sessionManager: SessionDataManager
  private let userDataManager: UserDataManager
  
  init(
    sessionManager: SessionDataManager = SessionDataManager.shared,
    userDataManager: UserDataManager = UserDataManager.shared
  ) {
    self.sessionManager = sessionManager
    self.userDataManager = userDataManager
  }
  
  func signUp(
    username: String,
    email: String,
    password: String,
    passwordConfirmation: String
  ) async throws -> String {
    let response: RequestResponse<GenericResponse> = await apiClient.request(
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
  
  private func saveUserSession(
    _ user: User?,
    headers: [AnyHashable: Any]
  ) -> Bool {
    userDataManager.currentUser = user
    sessionManager.currentSession = Session(headers: headers)
    
    return userDataManager.currentUser != nil && sessionManager.isValidSession
  }
}
