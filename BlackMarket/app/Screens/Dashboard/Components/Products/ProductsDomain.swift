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
    var products: [Product] = []
  }
  
  @Dependency(\.productsService) var productsService
  
  enum Action {
   case filterProductsByKeyword(String)
   case receiveProducts(TaskResult<[Product]>)
   case fetchProducts(
    categories: [String]? = nil,
    page: Int? = nil,
    pageSize: Int? = nil,
    search: String? = nil,
    state: String? = nil,
    maxPrice: Double? = nil,
    minPrice: Double? = nil
   )
  }
  
  var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      switch action {
      case let .filterProductsByKeyword(text):
        return .task {
          .fetchProducts(search: text)
        }
      case .fetchProducts(
        let categories,
        let page,
        let pageSize,
        let search,
        let state,
        let maxPrice,
        let minPrice
      ):
        return .task {
          return await .receiveProducts(TaskResult { try await
            productsService.getProducts(
              categories: categories,
              page: page,
              pageSize: pageSize,
              search: search,
              state: state,
              maxPrice: maxPrice,
              minPrice: minPrice
            )
          })
        }
      case .receiveProducts(let products):
        do {
          state.products = try products.value
        } catch {
          return .none
        }
        return .none
      }
    }
  }
}
