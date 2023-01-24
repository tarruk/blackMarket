//
//  AuthView.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 04/01/2023.
//

import SwiftUI
import ComposableArchitecture

struct AuthView: View {
  let store: StoreOf<AuthDomain>
  
  var body: some View {
    WithViewStore(store) { viewStore in
      GeometryReader { reader in
        ZStack {
          Image.background
            .ignoresSafeArea()
          switch viewStore.currentScene {
          case .login:
            LogInCardView(
              store: store.scope(
                state: \.loginState,
                action: AuthDomain.Action.loginAction
              )
            )
            .frame(
              maxWidth: .infinity,
              maxHeight: reader.size.height * UI.ScaleFactor.large,
              alignment: .center
            )
            .padding(UI.Padding.large)
            .position(
              x: reader.frame(in: .local).midX,
              y: reader.frame(in: .local).midY
            )
            .transition(.opacity)
          case .signup:
            SignUpCardView(
              store: store.scope(
                state: \.signupState,
                action: AuthDomain.Action.signupAction
              )
            )
            .frame(
              maxWidth: .infinity,
              maxHeight: reader.size.height * UI.ScaleFactor.large,
              alignment: .center
            )
            .padding(UI.Padding.large)
            .position(
              x: reader.frame(in: .local).midX,
              y: reader.frame(in: .local).midY
            )
            .transition(.opacity)
          }
        }
        .showLoader(viewStore.isLoading)
        .showPrompt(store: store.scope(state: \.promptState, action: AuthDomain.Action.presentPrompt))
      }
    }
  }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
      AuthView(store: Store(initialState: AuthDomain.State(), reducer: AuthDomain()))
    }
}
