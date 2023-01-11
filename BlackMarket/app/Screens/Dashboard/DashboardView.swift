//
//  DashboardView.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 09/01/2023.
//

import SwiftUI
import ComposableArchitecture

struct DashboardView: View {
  let store: StoreOf<DashboardDomain>
  
  var body: some View {
    WithViewStore(store) { viewStore in
      VStack(spacing: .zero) {
        DashboardBarView(
          store: store.scope(
            state: \.dashboardBarState,
            action: DashboardDomain.Action.dashboardBarAction
          )
        )
        SearchBarView(
          store: store.scope(
            state: \.searchBarState,
            action: DashboardDomain.Action.searchBarAction
          )
        )
        ProductsView(
          store: store.scope(
            state: \.productsState,
            action: DashboardDomain.Action.productsAction
          )
        )
        Spacer()
      }
    }
  }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
      DashboardView(
        store: Store(
          initialState: DashboardDomain.State(),
          reducer: DashboardDomain()
        )
      )
    }
}
