//
//  BMTextFieldView.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 06/12/2022.
//

import SwiftUI
import ComposableArchitecture

struct BMTextFieldView: View {
  let store: StoreOf<BMTextFieldDomain>
  
  var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      VStack(alignment: .leading, spacing: 2) {
        Text(viewStore.title)
          .foregroundColor(.blackish)
        if viewStore.isSecure {
          HStack {
            SecureToggleTextFieldView(
              store: store.scope(
                state: \.secureTextFieldState,
                action: BMTextFieldDomain.Action.secureTextFieldBinding
              )
            )
            .autocorrectionDisabled()
            .padding()
            .modifier(TextFieldLoginModifier())
          }
        } else {
          TextField(
            viewStore.placeholder ?? "",
            text: viewStore.binding(\.$text)
          )
          .autocorrectionDisabled()
          .padding()
          .modifier(TextFieldLoginModifier())
        }
        Text(viewStore.errorMessage ?? "")
          .font(.caption)
          .opacity(viewStore.shouldShowError ? 1 : 0)
          .frame(height: viewStore.shouldShowError ? 10 : 0)
          .foregroundColor(.red)
      }
    }
  }
}

