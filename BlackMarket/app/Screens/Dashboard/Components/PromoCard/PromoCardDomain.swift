//
//  PromoCardDomain.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 11/01/2023.
//

import Foundation
import ComposableArchitecture
import SwiftUI

struct PromoCardDomain: ReducerProtocol {
  struct State: Equatable {
    var image: Image = Image("product_4")
    var title: String = "Check out our new and restored furniture"
    var description: String = "Shop today and get a 10% discount!"
  }
  
  enum Action {
    case promoTapped
  }
  
  func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
    return .none
  }
}
