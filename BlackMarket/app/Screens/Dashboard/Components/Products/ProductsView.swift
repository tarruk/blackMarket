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
      Group {
        if viewStore.products.isEmpty {
          VStack {
            Image.productsNotFound
              .resizable()
              .renderingMode(.template)
              .foregroundColor(Color.placeholderGray)
              .frame(width: UI.ImageSize.medium, height: UI.ImageSize.medium)
            Text(LocalizedString.ProductsView.notProductsMessage)
              .foregroundColor(Color.placeholderGray)
              .font(.headline)
              .fontWeight(.medium)
          }.frame(height: UI.ProductCardView.height)
        } else {
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
            }.padding()
          }.scrollIndicators(.hidden)
        }
      }
      .onAppear {
        viewStore.send(.fetchProducts())
      }
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

private extension LocalizedString {
  enum ProductsView {
    static let notProductsMessage = "NO_PRODUCTS_FOUND".localized
  }
}
