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
  }
  
  enum Action {
    case dashboardBarAction(DashboardBarDomain.Action)
    case searchBarAction(SearchBarDomain.Action)
  }
  
  var body: some ReducerProtocol<State, Action> {
    
    Scope(state: \.dashboardBarState, action: /Action.dashboardBarAction) {
      DashboardBarDomain()
    }
    Scope(state: \.searchBarState, action: /Action.searchBarAction) {
      SearchBarDomain()
    }
    
    Reduce { state, action in
      return .none
    }
  }
  
  
}
