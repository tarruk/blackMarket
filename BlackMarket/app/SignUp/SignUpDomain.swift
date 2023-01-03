//
//  SignUpCardDomain.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 19/12/2022.
//

import Foundation
import ComposableArchitecture

struct SignUpDomain: ReducerProtocol {
  
  struct State: Equatable {
    var promptState = PromptModifierDomain.State(
      message: "",
      style: .warning,
      showPrompt: false
    )
    var isLoading: Bool = false
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
    var policyText: AttributedString {
      let rawString = String(
        format: LocalizedString.SignUpCardDomain.policyDisclaimer,
        "\(LocalizedString.SignUpCardDomain.dataPolicy)(\(Constants.Path.dataPolicy))",
        "\(LocalizedString.SignUpCardDomain.cookiesPolicy)(\(Constants.Path.cookiesPolicy))"
      )
      do {
        return try AttributedString(markdown: rawString)
      } catch {
        return ""
      }
    }

    var canSignUp: Bool {
      return emailState.isValid
      && nameState.isValid
      && passwordState.isValid
    }
  }

  @Dependency(\.authService) var authService
  
  enum Action {
    case binding(BindingAction<State>)
    case nameChanged(BMTextFieldDomain.Action)
    case emailChanged(BMTextFieldDomain.Action)
    case passwordChanged(BMTextFieldDomain.Action)
    case registerUser
    case showPolicy
    case presentLogIn
    case showCookies
    case presentPrompt(PromptModifierDomain.Action)
    case receiveAuthResult(AuthResult)
    case signUp(email: String, password: String, confirmedPassword: String)
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
    
    Scope(state: \.promptState, action: /Action.presentPrompt) {
      PromptModifierDomain()
    }
    
    Reduce { state, action in
      switch action {
      case .signUp(let email, let password, let confirmPassword):
        state.isLoading = true
        return .task {
          return await .receiveAuthResult(.signUp(TaskResult { try await
            authService.signUp(
               username: "",
               email: email,
               password: password,
               passwordConfirmation: confirmPassword
            )
          }))
        }
      case .presentPrompt(let promptAction):
        state.isLoading = false
        switch promptAction {
        case .showPrompt(let message, let style, let show):
          state.promptState = PromptModifierDomain.State(
            message: message,
            style: style,
            showPrompt: show
          )
          return .none
        default: return .none
        }
      case .receiveAuthResult(let result):
        state.isLoading = false
        switch result {
        case .signUp(.success(let message)):
          return .task {
            Action.presentPrompt(.showPrompt(message: message, style: .success, show: true))
          }
        case .signUp(.failure(let error)):
          return .task {
            // TODO: Add Error handling
            Action.presentPrompt(.showPrompt(message: error.localizedDescription, style: .error, show: true))
          }
        }
      default:
        return .none
      }
    }
  }
}

private extension LocalizedString {
  enum SignUpCardDomain {
    static let dataPolicy = "DATA_POLICY".localized
    static let cookiesPolicy = "COOKIES_POLICY".localized
    static let policyDisclaimer = "POLICY_DISCLAIMER".localized
    static let alreadyHaveAccountTitle = "ALREADY_HAVE_ACCOUNT_TITLE".localized
  }
}
