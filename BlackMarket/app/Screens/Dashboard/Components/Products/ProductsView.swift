//
//  ProductsView.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 10/01/2023.
//

import SwiftUI
import ComposableArchitecture

struct ProductsView: View {
  let store: StoreOf<ProductsDomain>
  
  var body: some View {
    WithViewStore(store) { viewStore in
      ScrollView(.horizontal) {
        HStack {
          ForEach(viewStore.products, id: \.id) {
            ProductCardView(
              store: Store(
                initialState: ProductCardDomain.State(product: $0),
                reducer: ProductCardDomain()
              )
            )
          }
        }
        .padding()
      }.scrollIndicators(.hidden)
    }
  }
}

struct ProductsView_Previews: PreviewProvider {
    static var previews: some View {
      ProductsView(store: Store(
        initialState: ProductsDomain.State(),
        reducer: ProductsDomain()
      ))
    }
}
