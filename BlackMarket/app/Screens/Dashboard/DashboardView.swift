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
  
  @EnvironmentObject var mainRouter: MainRouter
  
  var body: some View {
    WithViewStore(store) { viewStore in
      NavigationStack(path: mainRouter.bindingStack) {
        VStack(spacing: .zero) {
          DashboardBarView()
          SearchBarView(
            store: store.scope(
              state: \.searchBarState,
              action: DashboardDomain.Action.searchBar
            )
          )
          ScrollView(.vertical, showsIndicators: false) {
            ProductsView(
              store: store.scope(
                state: \.productsState,
                action: DashboardDomain.Action.products
              )
            )
            .environmentObject(mainRouter)
            
            if !viewStore.productsState.products.isEmpty {
              Button {
                viewStore.send(.seeAllButtonTapped)
              } label: {
                Text(LocalizedString.DashboardView.seeAllButtonTitle)
                  .fontWeight(.bold)
              }.padding()
            }
            
            PromoCardView(
              store: store.scope(
                state: \.promoCardState,
                action: DashboardDomain.Action.promoCard
              )
            ).padding()
            PaymentView(
              store: store.scope(
                state: \.paymentState,
                action: DashboardDomain.Action.payment
              )
            ).padding()
            Spacer()
          }.ignoresSafeArea()
        }.registerStackDestinations(forRouter: mainRouter)
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

private extension LocalizedString {
  enum DashboardView {
    static let seeAllButtonTitle = "SEE_ALL_BUTTON_TITLE".localized
  }
}
