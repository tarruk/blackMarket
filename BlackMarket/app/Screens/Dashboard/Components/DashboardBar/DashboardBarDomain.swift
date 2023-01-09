//
//  DashboardBarDomain.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 09/01/2023.
//

import Foundation
import ComposableArchitecture

struct DashboardBarDomain: ReducerProtocol {
  struct State: Equatable {
    var cartButtonState = DashboardButtonDomain.State(image: .shoppingCart)
    var menuButtonState = DashboardButtonDomain.State(image: .menu)
  }
  
  enum Action {
    case cartButtonTapped(DashboardButtonDomain.Action)
    case menuButtonTapped(DashboardButtonDomain.Action)
  }
  
  var body: some ReducerProtocol<State, Action> {
    
    Scope(state: \.cartButtonState, action: /Action.cartButtonTapped) {
      DashboardButtonDomain()
    }
    Scope(state: \.menuButtonState, action: /Action.menuButtonTapped) {
      DashboardButtonDomain()
    }
    
    Reduce { state, action in
      switch action {
      case .cartButtonTapped:
        // TODO: Cart button action
        return .none
      case .menuButtonTapped:
        // TODO: Menu button action
        return .none
      }
    }
  }
}
