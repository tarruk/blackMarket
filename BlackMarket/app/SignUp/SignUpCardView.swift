//
//  SignUpCardView.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 06/12/2022.
//

import SwiftUI
import ComposableArchitecture

struct SignUpCardView: View {
  
  let store: StoreOf<SignUpCardDomain>
  
  var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      ZStack {
        RoundedRectangle(cornerRadius: UI.CornerRadius.medium)
          .foregroundColor(.white)
        VStack(alignment: .center) {
          Image.logo
            .padding()
          VStack(spacing: UI.Padding.verySmall) {
            BMTextFieldView(
              store: store.scope(
                state: \.emailState,
                action: SignUpCardDomain.Action.emailChanged
              )
            )
            BMTextFieldView(
              store: store.scope(
                state: \.nameState,
                action: SignUpCardDomain.Action.nameChanged
              )
            )
            BMTextFieldView(
              store: store.scope(
                state: \.passwordState,
                action: SignUpCardDomain.Action.passwordChanged
              )
            )
            Button(action: {
              //
            }, label: {
              Text(LocalizedString.SignUpCardView.signupButtonTitle)
                .withButtonStyle(.primary)
            })
            .padding(.top)
            Spacer()
            HStack {
              Text(LocalizedString.SignUpCardView.policyDisclaimerFirstPart) +
              Text("\(.init(viewStore.dataPolicyLink))") +
              Text(LocalizedString.SignUpCardView.policyDisclaimerSecondPart) +
              Text("\(.init(viewStore.cookiesPolicyLink))")
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .multilineTextAlignment(.center)
            .font(.subheadline)
            .foregroundColor(.blackish)
            HStack {
              Text(LocalizedString.SignUpCardView.alreadyHaveAccountTitle)
              Button {
                // TODO: Go to log in screen
              } label: {
                Text(LocalizedString.SignUpCardView.loginButtonTitle)
                  .foregroundColor(.blue)
                  .font(.subheadline)
              }
            }.padding(.top)
          }.padding()
        }
      }
    }
  }
}

private extension UI {
  struct SignUpCardView {
    static let height: CGFloat = 550
  }
}

private extension LocalizedString {
  enum SignUpCardView {
    static let signupButtonTitle = "SIGNUP_BUTTON_TITLE".localized
    static let policyDisclaimerFirstPart = "POLICY_DISCLAIMER_1".localized
    static let policyDisclaimerSecondPart = "POLICY_DISCLAIMER_2".localized
    static let loginButtonTitle = "LOGIN_BUTTON_TITLE".localized
    static let alreadyHaveAccountTitle = "ALREADY_HAVE_ACCOUNT_TITLE".localized
  }
}

struct SignUpCardView_Previews: PreviewProvider {
    static var previews: some View {
      
      SignUpCardView(
        store: StoreOf<SignUpCardDomain>(
          initialState: SignUpCardDomain.State(),
          reducer: SignUpCardDomain()
        )
      )
    }
}
