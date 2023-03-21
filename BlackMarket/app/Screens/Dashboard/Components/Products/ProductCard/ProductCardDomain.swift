//
//  ProductCardDomain.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 10/01/2023.
//

import Foundation
import ComposableArchitecture
import SwiftUI

struct ProductCardDomain: ReducerProtocol {
  struct State: Equatable {
    var id: Int
    var imageURL: URL?
    var title: String
    var formattedPrice: String
    var productState: ProductState
    var liked: Bool
    
    // TODO: remove default values when the product model is complete from backend
    init(product: Product) {
      self.id = product.id
      self.imageURL = URL(string: product.picture?.urlSpacesSensible ?? "")
      self.title = product.name
      self.formattedPrice = "$\(product.price ?? 0)"
      self.productState = product.state ?? .new
      self.liked = product.favorite ?? false
    }
    
    static func == (lhs: ProductCardDomain.State, rhs: ProductCardDomain.State) -> Bool {
      lhs.id == rhs.id
    }
  }
  
  enum Action {
    case likeButtonTapped
  }
  
  func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
    switch action {
    case .likeButtonTapped:
      state.liked.toggle()
      return .none
    }
  }
}
