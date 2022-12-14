//
//  BMTextFieldView.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 06/12/2022.
//

import SwiftUI
import ComposableArchitecture

struct BMTextFieldDomain: ReducerProtocol {
  struct State: Equatable {
    @BindableState var text: String = ""
    var validations = [ValidationType]()
    var placeholder: String?
    var errorMessage: String?
    var title: String = ""
    var isSecure: Bool = false
    var isValid: Bool {
      text.validates(validations)
    }
    var shouldShowError: Bool {
      !isValid && !text.isEmpty
    }
    
    static func == (lhs: BMTextFieldDomain.State, rhs: BMTextFieldDomain.State) -> Bool {
      lhs.title == rhs.title
      && rhs.text == lhs.text
    }
  }
  
  enum Action: BindableAction {
    case binding(BindingAction<State>)
  }
  
  var body: some ReducerProtocol<State, Action> {
    BindingReducer()
    Reduce { state, action in
      switch action {
      case .binding:
        return .none
      }
    }
  }
}

struct BMTextFieldView: View {
  let store: StoreOf<BMTextFieldDomain>
  
  var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      VStack(alignment: .leading, spacing: 2) {
        Text(viewStore.title)
          .foregroundColor(.blackish)
        if viewStore.isSecure {
          HStack {
            SecureTextFieldWithReveal(store: Store(
              initialState: SecureTextFieldDomain.State(title: viewStore.title),
              reducer: SecureTextFieldDomain()
            ))
            .autocorrectionDisabled()
            .padding()
            .modifier(LoginModifier())
          }
        } else {
          TextField(
            viewStore.placeholder ?? "",
            text: viewStore.binding(\.$text)
          )
          .autocorrectionDisabled()
          .padding()
          .modifier(LoginModifier(borderColor: .blackish))
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

