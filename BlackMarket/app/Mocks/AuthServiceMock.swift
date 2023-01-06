//
//  AuthServiceMock.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 28/12/2022.
//

import Foundation
import RSSwiftNetworking

// TODO: Improve it with fake NetworkProvider
final class AuthServiceMock: BMClient, AuthServiceProtocol {
  
  enum AuthError: Error {
    case userSessionInvalid
  }
  
  init() { }
  
  func signUp(
    username: String,
    email: String,
    password: String,
    passwordConfirmation: String
  ) async throws -> String {
    return ""
  }
  
  func logIn(email: String, password: String) async throws -> String {
    return ""
  }
}

