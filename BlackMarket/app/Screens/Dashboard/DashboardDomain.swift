//
//  DashboardDomain.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 09/01/2023.
//

import Foundation
import ComposableArchitecture

struct DashboardDomain: ReducerProtocol {
  struct State: Equatable {
    var dashboardBarState = DashboardBarDomain.State()
    var searchBarState = SearchBarDomain.State(text: "")
    var productsState = ProductsDomain.State()

  }
  
  enum Action {
    case dashboardBarAction(DashboardBarDomain.Action)
    case searchBarAction(SearchBarDomain.Action)
    case productsAction(ProductsDomain.Action)
  }
  
  var body: some ReducerProtocol<State, Action> {
    
    Scope(state: \.dashboardBarState, action: /Action.dashboardBarAction) {
      DashboardBarDomain()
    }
    Scope(state: \.searchBarState, action: /Action.searchBarAction) {
      SearchBarDomain()
    }
    Scope(state: \.productsState, action: /Action.productsAction) {
      ProductsDomain()
    }
    
    Reduce { state, action in
      switch action {
      case let .searchBarAction(searchBarAction):
        switch searchBarAction {
        case .binding:
          let text = state.searchBarState.text
          return .task {
            Action.productsAction(.filterProductsByKeyword(text))
          }
        default: return .none
        }
      default: return .none
      }
    }
  }
  
  
}
