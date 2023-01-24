//
//  FooterBarButtonView.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 16/01/2023.
//

import SwiftUI
import ComposableArchitecture

struct FooterBarButtonView: View {
  let store: StoreOf<DashboardButtonDomain>

  var body: some View {
    WithViewStore(store) { viewStore in
      Button {
        viewStore.send(.buttonTapped)
      } label: {
        viewStore.image
      }
    }
  }
}

struct FooterBarButtonView_Previews: PreviewProvider {
  static var previews: some View {
    FooterBarButtonView(store: Store(
      initialState: DashboardButtonDomain.State(image: .facebook),
      reducer: DashboardButtonDomain()
    ))
  }
}
