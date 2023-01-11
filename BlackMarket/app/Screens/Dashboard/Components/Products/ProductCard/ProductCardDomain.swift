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
    var image: Image
    var title: String
    var formattedPrice: String
    var productState: ProductState
    var liked: Bool
    
    init(product: Product) {
      self.image = Image(product.imageURL)
      self.title = product.title
      self.formattedPrice = "$\(product.price)"
      self.productState = product.state
      self.liked = product.liked
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
