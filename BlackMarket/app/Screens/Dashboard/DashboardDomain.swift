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
    var promoCardState = PromoCardDomain.State()
    var paymentState = PaymentDomain.State()

  }
  
  enum Action {
    case dashboardBar(DashboardBarDomain.Action)
    case searchBar(SearchBarDomain.Action)
    case products(ProductsDomain.Action)
    case promoCard(PromoCardDomain.Action)
    case payment(PaymentDomain.Action)
    case seeAllButtonTapped
  }
  
  var body: some ReducerProtocol<State, Action> {
    
    Scope(state: \.dashboardBarState, action: /Action.dashboardBar) {
      DashboardBarDomain()
    }
    Scope(state: \.searchBarState, action: /Action.searchBar) {
      SearchBarDomain()
    }
    Scope(state: \.productsState, action: /Action.products) {
      ProductsDomain()
    }
    Scope(state: \.promoCardState, action: /Action.promoCard) {
      PromoCardDomain()
    }
    Scope(state: \.paymentState, action: /Action.payment) {
      PaymentDomain()
    }
    
    Reduce { state, action in
      switch action {
      case let .searchBar(searchBarAction):
        switch searchBarAction {
        case .binding:
          let text = state.searchBarState.text
          return .task {
            Action.products(.filterProductsByKeyword(text))
          }
        default: return .none
        }
      default: return .none
      }
    }
  }
}
