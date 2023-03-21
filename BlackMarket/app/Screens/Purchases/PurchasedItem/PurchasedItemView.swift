//
//  PurchasedItemView.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 08/03/2023.
//

import SwiftUI
import ComposableArchitecture

struct PurchasedItemView: View {
  let store: StoreOf<PurchasedItemDomain>
  
  var body: some View {
    WithViewStore(store) { viewStore in
      HStack {
        if let image = viewStore.playImage {
          Image(image)
            .resizable()
            .scaledToFit()
            .frame(width: UI.PurchasedItemView.imageWidth)
        } else {
          AsyncImage(url: viewStore.imageURL) { image in
            image
              .resizable()
            } placeholder: {
              Image.picturePlaceholder
            }
            .scaledToFit()
            .frame(width: UI.PurchasedItemView.imageWidth)
            .padding()
        }
        VStack {
          HStack {
            Text(viewStore.title)
              .font(.title3)
              .fontWeight(.semibold)
              .fontDesign(.rounded)
            Spacer()
            Text(viewStore.formattedPrice)
              .fontWeight(.bold)
          }.padding(.trailing)
          HStack {
            ProductStateView(state: viewStore.productState)
            Spacer()
            Text(String(
              format: "FORMATTED_BOUGHT_DATE".localized,
              viewStore.boughtDate
            ))
              .lineLimit(1)
              .minimumScaleFactor(UI.ScaleFactor.small)
          }.padding(.trailing)
          Text(viewStore.numberOfItems)
            .frame(maxWidth: .infinity, alignment: .leading)
            .fontWeight(.bold)
        }.padding(.vertical)
      }
      .frame(maxWidth: .infinity, maxHeight: UI.PurchasedItemView.maxHeight)
      .background(.white)
      .cornerRadius(UI.CornerRadius.medium)
      .shadow(color: .gray, radius: UI.CornerRadius.medium)
      .padding(.top)
    }
  }
}

private extension UI {
  enum PurchasedItemView {
    static let maxHeight: CGFloat = 120
    static let imageWidth: CGFloat = 100
  }
}

struct PurchasedItemView_Previews: PreviewProvider {
  static var previews: some View {
    PurchasedItemView(
      store: Store(
        initialState: PurchasedItemDomain.State(
          product: PurchasedProductsMock.products.first!
        ),
        reducer: PurchasedItemDomain()
      )
    )
  }
}


