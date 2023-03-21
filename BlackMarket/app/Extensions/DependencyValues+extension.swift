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
  
  var productsService: any ProductsServiceProtocol {
    get { self[ProductServiceKey.self] }
    set { self[ProductServiceKey.self] = newValue }
  }

  private enum ProductServiceKey: DependencyKey {
    static let liveValue: any ProductsServiceProtocol = ProductsService()
    static let testValue: any ProductsServiceProtocol = ProductsServiceMock()
  }
}

