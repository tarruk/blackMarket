//
//  LogInCardView.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 21/12/2022.
//

import SwiftUI
import ComposableArchitecture

struct LogInCardView: View {
  let store: StoreOf<LogInCardDomain>

    var body: some View {
      WithViewStore(store, observe: { $0 }) { viewStore in
        VStack(spacing: UI.Padding.medium){
          VStack {
            Image.logo
              .padding()
            VStack {
              BMTextFieldView(
                store: store.scope(
                  state: \.emailState,
                  action: LogInCardDomain.Action.emailChanged
                )
              )
              BMTextFieldView(
                store: store.scope(
                  state: \.passwordState,
                  action: LogInCardDomain.Action.passwordChanged
                )
              )
              BMButton(
                title: LocalizedString.Auth.loginButtonTitle,
                style: .primary,
                disabled: !viewStore.canLogin
              ) {
                  // Log in
                }
              Button {
                // Forgot my password action
              } label: {
                Text(LocalizedString.LogInCardView.forgotPasswordButtonTitle)
                  .fontWeight(.bold)
              }.padding()

            }
          }
          .padding()
          .background(.white)
          .cornerRadius(UI.CornerRadius.medium)
          
          VStack {
            Text(LocalizedString.LogInCardView.dontHaveAccountTitle)
            BMButton(
              title: LocalizedString.Auth.signupButtonTitle,
              style: .secundary
            ) {
                // Go to sign up screen
              }
          }
          .padding()
          .background(.white)
          .cornerRadius(UI.CornerRadius.medium)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
      }
    }
}

struct LogInCardView_Previews: PreviewProvider {
    static var previews: some View {
      LogInCardView(store: Store(
        initialState: LogInCardDomain.State(),
        reducer: LogInCardDomain()
      ))
    }
}


extension LocalizedString {
  enum LogInCardView {
    static let forgotPasswordButtonTitle = "FORGOT_PASWORD_BUTTON_TITLE".localized
    static let dontHaveAccountTitle = "DONT_HAVE_ACCOUNT_TITLE".localized
  }
}
