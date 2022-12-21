//
//  LogInCardDomain.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 20/12/2022.
//

import Foundation
import ComposableArchitecture

struct LogInCardDomain: ReducerProtocol {
  
  struct State: Equatable {
    
    var emailState = BMTextFieldDomain.State(
      validations: [.email, .nonEmpty],
      placeholder: LocalizedString.Auth.emailTextfieldPlaceholder,
      errorMessage: LocalizedString.Auth.emailTextfieldError,
      title: LocalizedString.Auth.emailTextfieldTitle
    )
    var passwordState = BMTextFieldDomain.State(
      validations: [
        .custom(isValid: { value in
          value.count >= Constants.Auth.minimumPasswordLength
        })
        , .nonEmpty
      ],
      placeholder: LocalizedString.Auth.passwordTextfieldPlaceholder,
      errorMessage: LocalizedString.Auth.passwordTextfieldError,
      title: LocalizedString.Auth.passwordTextfieldTitle,
      isSecure: true
    )
    
    var canLogin: Bool {
      return emailState.isValid && passwordState.isValid
    }
  }
  
  enum Action {
    case emailChanged(BMTextFieldDomain.Action)
    case passwordChanged(BMTextFieldDomain.Action)
    case logIn
    case presentSignUp
    case forgotMyPasswordTapped
  }
  
  var body: some ReducerProtocol<State, Action> {
    
    Scope(state: \.emailState, action: /Action.emailChanged) {
      BMTextFieldDomain()
    }
    Scope(state: \.passwordState, action: /Action.passwordChanged) {
      BMTextFieldDomain()
    }
    
    Reduce { state, action in
      return .none
    }
  }
}
