//
//  SecureToggleTextFieldDomain.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 20/12/2022.
//

import ComposableArchitecture

struct SecureToggleTextFieldDomain: ReducerProtocol {
  struct State: Equatable {
    var title: String = ""
    var placeholder: String? = ""
    @BindableState var text: String = ""
    @BindableState var focusedField: Field?
    @BindableState var showPassword: Bool = false
    
    // This is the way to manage focusState switching (Hashable)
    enum Field: String, Hashable {
      case secure, notSecure
    }
   
    static func == (lhs: SecureToggleTextFieldDomain.State, rhs: SecureToggleTextFieldDomain.State) -> Bool {
      lhs.text == rhs.text
      && lhs.showPassword == rhs.showPassword
      && lhs.focusedField == rhs.focusedField
    }
  }
  
  enum Action: BindableAction {
    case binding(BindingAction<State>)
    case showPassword
  }
  
  var body: some ReducerProtocol<State, Action> {
    BindingReducer()
    Reduce { state, action in
      switch action {
      case .showPassword:
        state.showPassword.toggle()
        if state.showPassword {
          state.focusedField = .notSecure
        } else {
          state.focusedField = .secure
        }
        return .none
      case .binding(\.$text):
        return .none
      default: return .none
      }
    }
  }
}
