//
//  ProductCardView.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 10/01/2023.
//

import SwiftUI
import ComposableArchitecture

struct ProductCardView: View {
  let store: StoreOf<ProductCardDomain>
  
  var body: some View {
    WithViewStore(store) { viewStore in
      VStack(spacing: UI.Border.thin) {
        viewStore.image
          .resizable()
          .frame(maxWidth: .infinity, maxHeight: .infinity)
        VStack {
          HStack {
            Text(viewStore.formattedPrice)
              .lineLimit(1)
              .minimumScaleFactor(UI.ScaleFactor.small)
            Spacer()
            Text(viewStore.productState.title)
              .font(.caption)
              .fontWeight(.semibold)
              .padding(UI.Padding.verySmall)
              .background(viewStore.productState.color)
              .foregroundColor(.white)
              .cornerRadius(UI.CornerRadius.small)
              .lineLimit(1)
              .minimumScaleFactor(UI.ScaleFactor.small)
          }
          HStack {
            Text(viewStore.title)
              .lineLimit(1)
              .minimumScaleFactor(UI.ScaleFactor.small)
            Spacer()
            Button {
              viewStore.send(.likeButtonTapped)
            } label: {
              Image.heart(liked: viewStore.liked)
                .tint(.black)
            }
          }
        }
        .frame(maxWidth: .infinity)
        .padding(UI.Padding.small)
        .background(.white)
        
      }
      .frame(
        width: UI.ProductCardView.width,
        height: UI.ProductCardView.height
      )
      .background(.clear)
      .cornerRadius(UI.CornerRadius.medium)
      .shadow(color: .placeholderGray, radius: UI.CornerRadius.medium)
    }
  }
}

struct ProductCardView_Previews: PreviewProvider {
  static var previews: some View {
    ProductCardView(store: Store(
      initialState: ProductCardDomain.State(
        product: Product(
          id: UUID(),
          title: "Gamer chair",
          price: 35.34,
          state: .used,
          liked: true,
          imageURL: "product_3"
        )
      ),
      reducer: ProductCardDomain()
    ))
  }
}

private extension UI {
  enum ProductCardView {
    static let width: CGFloat = 170
    static let height: CGFloat = 240
  }
}
