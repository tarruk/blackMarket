//
//  AuthEndpoint.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 23/12/2022.
//

import Foundation
import RSSwiftNetworking

enum AuthEndpoint: RailsAPIEndpoint {
  case signIn(email: String, password: String, passwordConfirmation: String)
  case logIn
  
  var path: String {
    switch self {
    case .signIn:
      return "/dj-rest-auth/registration/"
    case .logIn:
      return ""
    }
  }
  
  var parameters: [String : Any] {
    switch self {
    case .signIn(let email, let password, let passwordConfirmation):
      return [
        "email": email,
        "password1": password,
        "password2": passwordConfirmation
      ]
    case .logIn:
      return [:]
    }
  }
  
  var headers: [String : String] {
    return [
      HTTPHeader.accept.rawValue: "*/*",
      HTTPHeader.contentType.rawValue: "application/json"
    ]
  }
  var parameterEncoding: ParameterEncoding {
    switch self {
    case .signIn, .logIn:
      return .httpBody(.json)
    }
  }
  var method: Network.HTTPMethod {
    switch self {
    case .signIn:
      return .post
    case .logIn:
      return .post
    }
  }
}
