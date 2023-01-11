//
//  ProductsDomain.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 10/01/2023.
//

import Foundation
import ComposableArchitecture

struct ProductsDomain: ReducerProtocol {
  struct State: Equatable {
    static func == (lhs: ProductsDomain.State, rhs: ProductsDomain.State) -> Bool {
      lhs.products == rhs.products
    }
    // TODO: Replace mock products with real service
    var products: [Product] = ProductsServiceMock.products
  }
  
  enum Action {
   case filterProductsByKeyword(String)
  }
  
  var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      switch action {
      case let .filterProductsByKeyword(text):
        // TODO: Replace mock products with real service
        state.products = text.isEmpty ? ProductsServiceMock.products : ProductsServiceMock.products.filter({$0.title.localizedCaseInsensitiveContains(text)})
        return .none
      }
    }
  }
}
