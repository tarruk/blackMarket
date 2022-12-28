//
//  DependencyValues+extension.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 28/12/2022.
//

import Foundation
import ComposableArchitecture

extension DependencyValues {
  
  var authService: any AuthServiceProtocol {
    get { self[AuthServiceKey.self] }
    set { self[AuthServiceKey.self] = newValue }
  }

  private enum AuthServiceKey: DependencyKey {
    static let liveValue: any AuthServiceProtocol = AuthService()
    static let testValue: any AuthServiceProtocol = AuthServiceMock()
  }
}

