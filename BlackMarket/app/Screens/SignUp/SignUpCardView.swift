//
//  SignUpCardView.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 30/12/2022.
//

import SwiftUI
import ComposableArchitecture

struct SignUpCardView: View {
  let store: StoreOf<SignUpDomain>
  
  var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      VStack(alignment: .center) {
        Image.logo
          .padding()
        VStack(spacing: UI.Padding.verySmall) {
          BMTextFieldView(
            store: store.scope(
              state: \.emailState,
              action: SignUpDomain.Action.emailChanged
            )
          )
          BMTextFieldView(
            store: store.scope(
              state: \.nameState,
              action: SignUpDomain.Action.nameChanged
            )
          )
          BMTextFieldView(
            store: store.scope(
              state: \.passwordState,
              action: SignUpDomain.Action.passwordChanged
            )
          )
          BMButton(
            title: LocalizedString.SignUpCardView.signupButtonTitle,
            style: .primary,
            disabled: !viewStore.canSignUp
          ) {
            viewStore.send(.signUp(
              email: viewStore.emailState.text,
              password: viewStore.passwordState.text,
              confirmedPassword: viewStore.passwordState.text
            ))
          }
          .padding(.top)
          Spacer()
          HStack {
            Text(viewStore.policyText)
          }
          .frame(maxWidth: .infinity, alignment: .center)
          .multilineTextAlignment(.center)
          .font(.subheadline)
          .foregroundColor(.blackish)
          .minimumScaleFactor(UI.ScaleFactor.large)
          HStack {
            Text(LocalizedString.SignUpCardView.alreadyHaveAccountTitle)
            Button {
              viewStore.send(.loginButtonTapped, animation: .easeIn)
            } label: {
              Text(LocalizedString.SignUpCardView.loginButtonTitle)
                .foregroundColor(.blue)
                .font(.subheadline)
            }
          }
          .minimumScaleFactor(UI.ScaleFactor.large)
          .padding(.top, UI.Padding.small)
        }.padding()
      }
      .background(.white)
      .cornerRadius(UI.CornerRadius.medium)
    }
  }
}

private extension LocalizedString {
  enum SignUpCardView {
    static let signupButtonTitle = "SIGNUP_BUTTON_TITLE".localized
    static let policyDisclaimer = "POLICY_DISCLAIMER".localized
    static let loginButtonTitle = "LOGIN_BUTTON_TITLE".localized
    static let alreadyHaveAccountTitle = "ALREADY_HAVE_ACCOUNT_TITLE".localized
  }
}

struct SignUpCardView_Previews: PreviewProvider {
    static var previews: some View {
      SignUpCardView(
        store: Store(
          initialState: SignUpDomain.State(),
          reducer: SignUpDomain()
        )
      )
    }
}
