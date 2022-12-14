//
//  SecureTextFieldWithReveal.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 07/12/2022.
//

import SwiftUI
import ComposableArchitecture

struct SecureTextFieldDomain: ReducerProtocol {
  struct State: Equatable {
    var title: String
    
    @BindableState var focusedField: Field?
    @BindableState var text: String = ""
    
    enum Field: String, Hashable {
      case secure, notSecure
    }
    
    var showPassword: Bool = false {
      didSet {
        if showPassword {
          focusedField = .notSecure
        } else {
          focusedField = .secure
        }
      }
    }
   
    static func == (lhs: SecureTextFieldDomain.State, rhs: SecureTextFieldDomain.State) -> Bool {
      lhs.text == rhs.text &&
      lhs.showPassword == rhs.showPassword &&
      lhs.focusedField == rhs.focusedField
    }
  }
  
  enum Action: BindableAction {
    case binding(BindingAction<State>)
    case showPassword
  }
  
  var body: some ReducerProtocol<State, Action> {
    BindingReducer()
    Reduce { state, action in
      switch action {
      case .showPassword:
        state.showPassword.toggle()
        return .none
      case .binding:
        return .none
      }
    }
  }
}

struct SecureTextFieldWithReveal: View {
  let store: StoreOf<SecureTextFieldDomain>
  @FocusState var focusedField: SecureTextFieldDomain.State.Field?
  
  var body: some View {
    WithViewStore(store) { viewStore in
      HStack {
        ZStack(alignment: .trailing) {
          TextField(viewStore.title, text: viewStore.binding(\.$text))
            .focused($focusedField, equals: .notSecure)
            .opacity(viewStore.showPassword ? 1 : 0)
          SecureField(viewStore.title, text: viewStore.binding(\.$text))
            .focused($focusedField, equals: .secure)
            .opacity(viewStore.showPassword ? 0 : 1)
        }
        Spacer()
        Button(action: {
          viewStore.send(.showPassword)
        }, label: {
          Image(systemName: viewStore.showPassword ? "eye.slash.fill" : "eye.fill")
            .font(.system(size: 16, weight: .regular))
            .foregroundColor(.black)
        })
      }.synchronize(viewStore.binding(\.$focusedField), self.$focusedField)
    }
  }
}
