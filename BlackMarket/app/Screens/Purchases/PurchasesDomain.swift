//
//  PurchasesDomain.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 08/03/2023.
//

import Foundation
import ComposableArchitecture

struct PurchasesDomain: ReducerProtocol {
  struct State: Equatable {
    // TODO: Replace for real service
    var purchasedItems: [PurchasedProduct] = PurchasedProductsMock.products
  }
  
  enum Action {}
  
  func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
    return .none
  }
}
