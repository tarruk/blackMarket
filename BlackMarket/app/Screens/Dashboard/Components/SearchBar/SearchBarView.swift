//
//  SearchBarView.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 09/01/2023.
//

import SwiftUI
import ComposableArchitecture

struct SearchBarView: View {
  let store: StoreOf<SearchBarDomain>
  
  var body: some View {
    WithViewStore(store) { viewStore in
      Rectangle()
        .foregroundColor(.lightGray)
        .overlay {
          HStack(alignment: .center) {
            TextField(
              viewStore.placeholder,
              text: viewStore.binding(\.$text)
            )
            .foregroundColor(.blackish)
            Button {
              viewStore.send(.search)
            } label: {
              Image.search
                .tint(.blackish)
            }
          }
          .padding(.vertical, UI.Padding.small)
          .padding(.horizontal, UI.Padding.medium)
          .background(.white)
          .cornerRadius(UI.CornerRadius.medium)
          .padding()
        }
        .frame(
          maxWidth: .infinity,
          maxHeight: UI.SearchBarView.height
        )
    }
  }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
      SearchBarView(store: Store(
        initialState: SearchBarDomain.State(text: "Chair"),
        reducer: SearchBarDomain()
      ))
    }
}

private extension UI {
  enum SearchBarView {
    static let height: CGFloat = 60
  }
}
