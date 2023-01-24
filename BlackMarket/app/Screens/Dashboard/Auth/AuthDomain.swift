//
//  AuthDomain.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 04/01/2023.
//

import Foundation
import ComposableArchitecture

enum AuthScene: Hashable {
  case signup
  case login
}

struct AuthDomain: ReducerProtocol {
  struct State: Equatable {
    var currentScene: AuthScene = .login
    var signupState = SignUpDomain.State()
    var loginState = LogInDomain.State()
    var isLoading = false
    var promptState = PromptModifierDomain.State(
      message: "",
      style: .warning,
      showPrompt: false
    )
  }
  
  @Dependency(\.authService) var authService
  
  enum Action {
    case changeScene
    case loginAction(LogInDomain.Action)
    case signupAction(SignUpDomain.Action)
    case presentPrompt(PromptModifierDomain.Action)
    case receiveAuthResult(TaskResult<String>)
    case signUp(email: String, password: String, confirmPassword: String)
    case login(email: String, password: String)
  }
  
  var body: some ReducerProtocol<State, Action> {


    Scope(state: \.loginState, action: /Action.loginAction) {
      LogInDomain()
    }
    
    Scope(state: \.signupState, action: /Action.signupAction) {
      SignUpDomain()
    }
    
    Scope(state: \.promptState, action: /Action.presentPrompt) {
      PromptModifierDomain()
    }
    
    Reduce { state, action in
      switch action {
      case .presentPrompt(.showPrompt(let message, let style, let show)):
        state.promptState = PromptModifierDomain.State(
          message: message,
          style: style,
          showPrompt: show
        )
        return .none
      case .changeScene:
        if state.currentScene == .signup{
          state.currentScene = .login
        } else {
          state.currentScene = .signup
        }
        return .none
      case let .loginAction(loginAction):
        switch loginAction {
        case .signupButtonTapped:
          state.loginState = LogInDomain.State()
          state.currentScene = .signup
          return .none
        case .logIn(let email, let password):
          state.isLoading = true
          return .task {
            return await .receiveAuthResult(TaskResult { try await
              authService.logIn(email: email, password: password)
            })
          }
        default: return .none
        }
      case let .signupAction(signupAction):
        switch signupAction {
        case .loginButtonTapped:
          state.signupState = SignUpDomain.State()
          state.currentScene = .login
          return .none
        case .signUp(let email, let password, let confirmPassword):
          state.isLoading = true
          return .task {
            return await .receiveAuthResult(TaskResult { try await
              authService.signUp(
                 username: "",
                 email: email,
                 password: password,
                 passwordConfirmation: confirmPassword
              )
            })
          }
        default: return .none
        }
      case let .receiveAuthResult(result):
        state.isLoading = false
        switch result {
        case .failure(let error):
          return .task {
            // TODO: Add Error handling
            Action.presentPrompt(.showPrompt(message: error.localizedDescription, style: .error, show: true))
          }
        default: return .none
        }
      default: return .none
      }
    }
  }
}
