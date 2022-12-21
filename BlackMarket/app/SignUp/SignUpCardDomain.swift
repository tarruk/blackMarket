//
//  SignUpCardDomain.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 19/12/2022.
//

import Foundation
import ComposableArchitecture

struct SignUpCardDomain: ReducerProtocol {
  
  struct State: Equatable {
    
    var nameState = BMTextFieldDomain.State(
      validations: [.nonEmpty],
      placeholder: LocalizedString.Auth.nameTextfieldPlaceholder,
      errorMessage: LocalizedString.Auth.nameTextfieldError,
      title: LocalizedString.Auth.nameTextfieldTitle
    )
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
    
    var dataPolicyLink: AttributedString = LocalizedString.SignUpCardDomain.dataPolicy.transformToLink(
      withURL: Constants.Path.dataPolicy
    ) ?? ""
    var cookiesPolicyLink: AttributedString =  LocalizedString.SignUpCardDomain.cookiesPolicy.transformToLink(
      withURL: Constants.Path.cookiesPolicy
    ) ?? ""
    
    var canSignUp: Bool {
      return emailState.isValid
      && nameState.isValid
      && passwordState.isValid
    }
  }
  
  enum Action {
    case nameChanged(BMTextFieldDomain.Action)
    case emailChanged(BMTextFieldDomain.Action)
    case passwordChanged(BMTextFieldDomain.Action)
    case registerUser
    case showPolicy
    case presentLogIn
    case showCookiesPolicy
  }
  
  var body: some ReducerProtocol<State, Action> {
    
    Scope(state: \.nameState, action: /Action.nameChanged) {
      BMTextFieldDomain()
    }
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

private extension LocalizedString {
  enum SignUpCardDomain {
    static let dataPolicy = "DATA_POLICY".localized
    static let cookiesPolicy = "COOKIES_POLICY".localized
    static let policyDisclaimerFirstPart = "POLICY_DISCLAIMER_1".localized
    static let policyDisclaimerSecondPart = "POLICY_DISCLAIMER_2".localized
    static let alreadyHaveAccountTitle = "ALREADY_HAVE_ACCOUNT_TITLE".localized
  }
}
