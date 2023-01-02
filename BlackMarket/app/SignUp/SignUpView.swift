//
//  SignUpView.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 06/12/2022.
//

import SwiftUI
import ComposableArchitecture

struct SignUpView: View {
  
  let store: StoreOf<SignUpDomain>

  var body: some View {
    WithViewStore(store) { viewStore in
      GeometryReader { reader in
        ZStack {
          Image.background
            .ignoresSafeArea()
          SignUpCardView(store: store)
            .frame(
              maxWidth: .infinity,
              maxHeight: reader.size.height * UI.ScaleFactor.large,
              alignment: .center
            )
            .padding(UI.Padding.large)
        }.position(
          x: reader.frame(in: .local).midX,
          y: reader.frame(in: .local).midY
        ).showPrompt(store:
          store.scope(
            state: \.promptState,
            action: SignUpDomain.Action.presentPrompt
          )
        )
        .showLoader(viewStore.isLoading)
      }
    }
  }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
      SignUpView(store: Store(initialState: SignUpDomain.State(), reducer: SignUpDomain()))
    }
}
