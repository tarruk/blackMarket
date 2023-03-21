//
//  PurchasesView.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 08/03/2023.
//

import SwiftUI
import ComposableArchitecture

struct PurchasesView: View {
  let store: StoreOf<PurchasesDomain>
  
  var body: some View {
    WithViewStore(store) { viewStore in
      VStack {
        DashboardBarView()
        Text(LocalizedString.PurchasesView.title)
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding()
        List {
          ForEach(viewStore.purchasedItems, id: \.id) { item in
            PurchasedItemView(store: Store(initialState: PurchasedItemDomain.State(product: item), reducer: PurchasedItemDomain())
            )
          }
        }.listStyle(PlainListStyle())
      }
    }
  }
}

extension LocalizedString {
  enum PurchasesView {
    static let title: String = "PURCHASES_TITLE".localized
  }
}
struct PurchasesView_Previews: PreviewProvider {
  static var previews: some View {
    PurchasesView(
      store: Store(
        initialState: PurchasesDomain.State(
          purchasedItems: PurchasedProductsMock.products
        ),
        reducer: PurchasesDomain()
      )
    )
  }
}
