//
//  BMTextFieldDomain.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 19/12/2022.
//

import Foundation
import ComposableArchitecture

struct BMTextFieldDomain: ReducerProtocol {
  struct State: Equatable {
    @BindableState var text: String
    var secureTextFieldState: SecureToggleTextFieldDomain.State
    var validations: [ValidationType]
    var placeholder: String?
    var errorMessage: String?
    var title: String
    var isSecure: Bool
    var isValid: Bool
    var shouldShowError: Bool = false
    
    static func == (lhs: BMTextFieldDomain.State, rhs: BMTextFieldDomain.State) -> Bool {
      lhs.title == rhs.title && rhs.text == lhs.text
    }
    
    init(
      text: String = "",
      validations: [ValidationType] = [],
      placeholder: String? = nil,
      errorMessage: String? = nil,
      title: String = "",
      isSecure: Bool = false
    ) {
      self.isValid = false
      self.text = text
      self.validations = validations
      self.placeholder = placeholder
      self.errorMessage = errorMessage
      self.title = title
      self.isSecure = isSecure
      
      self.secureTextFieldState = SecureToggleTextFieldDomain.State(
        title: title,
        placeholder: placeholder
      )
    }
  }
  
  enum Action: BindableAction {
    case binding(BindingAction<State>)
    case secureTextFieldValueChanged(SecureToggleTextFieldDomain.Action)
  }
  
  var body: some ReducerProtocol<State, Action> {
    
    BindingReducer()
    
    Scope(state: \.secureTextFieldState, action: /Action.secureTextFieldValueChanged) {
      SecureToggleTextFieldDomain()
    }
    
    Reduce { state, action in
      switch action {
      case .binding:
        state.isValid = state.text.validates(state.validations)
        state.shouldShowError = !state.isValid
        return .none
      case .secureTextFieldValueChanged:
        state.text = state.secureTextFieldState.text
        state.isValid = state.text.validates(state.validations)
        state.shouldShowError = !state.isValid
        return .none
      }
    }
   
  }
}
