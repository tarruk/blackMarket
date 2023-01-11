//
//  PromoCardView.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 11/01/2023.
//

import SwiftUI
import ComposableArchitecture

struct PromoCardView: View {
  let store: StoreOf<PromoCardDomain>
  
  var body: some View {
    WithViewStore(store) { viewStore in
      Button {
        viewStore.send(.promoTapped)
      } label: {
        HStack(spacing: 1) {
          viewStore.image
            .resizable()
            .scaledToFill()
          VStack {
            Text(viewStore.title)
              .fontWeight(.bold)
              .font(.title2)
              .foregroundColor(.white)
              .minimumScaleFactor(UI.ScaleFactor.small)
              .lineLimit(3)
              .padding(.bottom, UI.Padding.verySmall)
            Text(viewStore.description)
              .font(.title3)
              .lineLimit(2)
              .minimumScaleFactor(UI.ScaleFactor.small)
              .foregroundColor(.white)
          }
          .padding()
          
        }
        .background(.black)
        .frame(
          maxWidth: .infinity,
          maxHeight: UI.PromoCardView.height
        )
        .cornerRadius(UI.CornerRadius.medium)
        .shadow(radius: UI.CornerRadius.medium)
      }.buttonStyle(ScaleButtonStyle())
    }
  }
}

struct PromoCardView_Previews: PreviewProvider {
  static var previews: some View {
    PromoCardView(store: Store(
      initialState: PromoCardDomain.State(),
      reducer: PromoCardDomain()
    ))
  }
}

private extension UI {
  enum PromoCardView {
    static let height: CGFloat = 150
  }
}
