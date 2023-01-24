//
//  FooterDomain.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 16/01/2023.
//

import Foundation
import ComposableArchitecture

struct FooterDomain: ReducerProtocol {
  struct State: Equatable {
    var subscribeSectionTitle: String = "Subscribe to our weekly newsletter!"
    var textfieldPlaceholder: String = "Type your email"
    var emailTitle: String = LocalizedString.Auth.emailTextfieldTitle
    var footerBarState = FooterBarDomain.State()
    @BindableState var email: String
  }
  
  enum Action: BindableAction {
    case footerBar(FooterBarDomain.Action)
    case subscribeButtonTapped
    case binding(BindingAction<State>)
  }
  
  var body: some ReducerProtocol<State, Action> {
    
    BindingReducer()
    
    Scope(state: \.footerBarState, action: /Action.footerBar) {
      FooterBarDomain()
    }
    
    Reduce { state, action in
      return .none
    }
  }
}
