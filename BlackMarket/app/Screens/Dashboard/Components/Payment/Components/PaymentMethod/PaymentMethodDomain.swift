//
//  PaymentMethodDomain.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 11/01/2023.
//

import Foundation
import ComposableArchitecture
import SwiftUI

struct PaymentMethodDomain: ReducerProtocol {
  struct State: Equatable {
    
    static func == (lhs: PaymentMethodDomain.State, rhs: PaymentMethodDomain.State) -> Bool {
      lhs.title == rhs.title
    }
    
    var image: Image
    var title: String

    init(method: PaymentMethod) {
      self.image = method.logo
      self.title = method.title
    }
  }
  
  enum Action {
    case methodTapped
  }
  
  func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
    return .none
  }
}
