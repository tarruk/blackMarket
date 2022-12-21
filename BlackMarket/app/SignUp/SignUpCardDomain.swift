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
      placeholder: LocalizedString.SignUpCardDomain.nameTextfieldPlaceholder,
      errorMessage: LocalizedString.SignUpCardDomain.nameTextfieldError,
      title: LocalizedString.SignUpCardDomain.nameTextfieldTitle
    )
    var emailState = BMTextFieldDomain.State(
      validations: [.email, .nonEmpty],
      placeholder: LocalizedString.SignUpCardDomain.emailTextfieldPlaceholder,
      errorMessage: LocalizedString.SignUpCardDomain.emailTextfieldError,
      title: LocalizedString.SignUpCardDomain.emailTextfieldTitle
    )
    var passwordState = BMTextFieldDomain.State(
      validations: [
        .custom(isValid: { value in
          value.count >= Constants.Value.minimumPasswordLength
        })
        , .nonEmpty
      ],
      placeholder: LocalizedString.SignUpCardDomain.passwordTextfieldPlaceholder,
      errorMessage: LocalizedString.SignUpCardDomain.passwordTextfieldError,
      title: LocalizedString.SignUpCardDomain.passwordTextfieldTitle,
      isSecure: true
    )
    
    var dataPolicyLink: AttributedString = LocalizedString.SignUpCardDomain.dataPolicy.transformToLink(
      withURL: Constants.Path.dataPolicy
    ) ?? ""
    var cookiesPolicyLink: AttributedString =  LocalizedString.SignUpCardDomain.cookiesPolicy.transformToLink(
      withURL: Constants.Path.cookiesPolicy
    ) ?? ""
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
    static let emailTextfieldTitle = "EMAIL_TEXTFIELD_TITLE".localized
    static let nameTextfieldTitle = "NAME_TEXTFIELD_TITLE".localized
    static let passwordTextfieldTitle = "PASSWORD_TEXTFIELD_TITLE".localized
    static let emailTextfieldError = "EMAIL_TEXTFIELD_ERROR".localized
    static let nameTextfieldError = "NAME_TEXTFIELD_ERROR".localized
    static let passwordTextfieldError = "PASSWORD_TEXTFIELD_ERROR".localized
    static let emailTextfieldPlaceholder = "EMAIL_TEXTFIELD_PLACEHOLDER".localized
    static let nameTextfieldPlaceholder = "NAME_TEXTFIELD_PLACEHOLDER".localized
    static let passwordTextfieldPlaceholder = "PASSWORD_TEXTFIELD_PLACEHOLDER".localized
    static let signupButtonTitle = "SIGNUP_BUTTON_TITLE".localized
    static let policyDisclaimerFirstPart = "POLICY_DISCLAIMER_1".localized
    static let policyDisclaimerSecondPart = "POLICY_DISCLAIMER_2".localized
    static let loginButtonTitle = "LOGIN_BUTTON_TITLE".localized
    static let alreadyHaveAccountTitle = "ALREADY_HAVE_ACCOUNT_TITLE".localized
  }
}

private extension Constants {
  enum Value {
    static let minimumPasswordLength: Int = 8
  }
}
