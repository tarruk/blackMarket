//
//  SecureToggleTextFieldDomain.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 07/12/2022.
//

import SwiftUI
import ComposableArchitecture

struct SecureToggleTextFieldView: View {
  let store: StoreOf<SecureToggleTextFieldDomain>
  @FocusState var focusedField: SecureToggleTextFieldDomain.State.Field?
  
  var body: some View {
    WithViewStore(store) { viewStore in
      HStack {
        if viewStore.showPassword {
          TextField(viewStore.title, text: viewStore.binding(\.$text))
            .focused($focusedField, equals: .notSecure)
            .opacity(viewStore.showPassword ? 1 : 0)
        } else {
          SecureField(viewStore.title, text: viewStore.binding(\.$text))
            .focused($focusedField, equals: .secure)
            .opacity(viewStore.showPassword ? 0 : 1)
        }
        Spacer()
        Button(action: {
          viewStore.send(.showPassword)
        }, label: {
          Image.eye(slashed: viewStore.showPassword)
            .font(.system(size: 16, weight: .regular))
            .foregroundColor(.black)
        })
      }.synchronize(viewStore.binding(\.$focusedField), self.$focusedField)
    }
  }
}
