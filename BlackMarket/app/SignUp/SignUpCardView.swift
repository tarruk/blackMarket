//
//  SignUpCardView.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 06/12/2022.
//

import SwiftUI
import ComposableArchitecture

struct SignUpCardDomain: ReducerProtocol {
  
  struct State: Equatable {
    static func == (lhs: SignUpCardDomain.State, rhs: SignUpCardDomain.State) -> Bool {
      return true
    }
   
    var nameState = BMTextFieldDomain.State(
      validations: [.nonEmpty],
      placeholder: LocalizedString.SignUpCardView.nameTextfieldPlaceholder,
      errorMessage: LocalizedString.SignUpCardView.nameTextfieldError,
      title: LocalizedString.SignUpCardView.nameTextfieldTitle
    )
    var emailState = BMTextFieldDomain.State(
      validations: [.email, .nonEmpty],
      placeholder: LocalizedString.SignUpCardView.emailTextfieldPlaceholder,
      errorMessage: LocalizedString.SignUpCardView.emailTextfieldError,
      title: LocalizedString.SignUpCardView.emailTextfieldTitle
    )
    var passwordState = BMTextFieldDomain.State(
      validations: [
        .custom(isValid: { value in
          value.count >= Constants.Value.minimumPasswordLength
        })
      ],
      placeholder: LocalizedString.SignUpCardView.passwordTextfieldPlaceholder,
      errorMessage: LocalizedString.SignUpCardView.passwordTextfieldError,
      title: LocalizedString.SignUpCardView.passwordTextfieldTitle,
      isSecure: true
    )
    
    var dataPolicyLink: AttributedString {
      LocalizedString.SignUpCardView.dataPolicy.transformToLink(
        withURL: Constants.Path.dataPolicy
      ) ?? ""
    }
    var cookiesPolicyLink: AttributedString {
      LocalizedString.SignUpCardView.cookiesPolicy.transformToLink(
        withURL: Constants.Path.cookiesPolicy
      ) ?? ""
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
    Reduce { state, action in
      switch action {
      case .registerUser:
        return .none
      case .showPolicy:
        return .none
      case .presentLogIn:
        return .none
      case .showCookiesPolicy:
        return .none
      default:
        return .none
      }
    }

    Scope(state: \.nameState, action: /Action.nameChanged) {
      BMTextFieldDomain()
    }
    Scope(state: \.emailState, action: /Action.emailChanged) {
      BMTextFieldDomain()
    }
    Scope(state: \.passwordState, action: /Action.passwordChanged) {
      BMTextFieldDomain()
    }
  }
}

struct SignUpCardView: View {
  
  let store: StoreOf<SignUpCardDomain>
  
  var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      Spacer()
      ZStack {
        RoundedRectangle(cornerRadius: UI.CornerRadius.medium)
          .foregroundColor(.white)
        VStack {
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
              BMButton(
                backgroundColor: .black,
                textColor: .white,
                title: LocalizedString.SignUpCardView.signupButtonTitle,
                cornerRadius: UI.CornerRadius.small
              ).withStyle(.primary)
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
      }.frame(maxWidth: .infinity, maxHeight: UI.SignUpCardView.height)
    }
  }
}

private extension UI {
  struct SignUpCardView {
    static let height: CGFloat = 550
  }
}

private extension Constants {
  enum Path {
    static let dataPolicy = "https://google.com"
    static let cookiesPolicy = "https://google.com"
  }
  
  enum Value {
    static let minimumPasswordLength: Int = 8
  }
}

private extension LocalizedString {
  enum SignUpCardView {
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
