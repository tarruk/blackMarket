//
//  PromptModifierDomain.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 29/12/2022.
//

import Foundation
import ComposableArchitecture

struct PromptModifierDomain: ReducerProtocol {
  struct State: Equatable {
    static func == (lhs: PromptModifierDomain.State, rhs: PromptModifierDomain.State) -> Bool {
      lhs.showPrompt == rhs.showPrompt
      && lhs.message == rhs.message
      && lhs.style == rhs.style
      && lhs.offset == rhs.offset
    }
    
    var message: String
    var style: PromptStyle
    var showPrompt: Bool
    var offset = CGSize.zero
  }
  
  enum Action: BindableAction {
    case binding(BindingAction<State>)
    case offsetChanged(_ value: CGSize)
    case showPrompt(message: String, style: PromptStyle, show: Bool)
  }
  
  func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
    switch action {
    case .offsetChanged(let value):
      state.offset = value
      return .none
    case .showPrompt(let message, let style, let show):
      state.message = message
      state.style = style
      state.showPrompt = show
      return .none
    default:
      return .none
    }
  }
}

