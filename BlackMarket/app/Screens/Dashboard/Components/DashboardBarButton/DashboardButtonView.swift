//
//  DashboardButtonView.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 09/01/2023.
//

import SwiftUI
import ComposableArchitecture

struct DashboardButtonView: View {
  let store: StoreOf<DashboardButtonDomain>
  
  var body: some View {
    WithViewStore(store) { viewStore in
      Button {
        viewStore.send(.buttonTapped)
      } label: {
        viewStore.image
          .resizable()
          .frame(
            width: UI.IconSize.huge,
            height: UI.IconSize.huge
          )
          .padding(.vertical, UI.Padding.DashboardButton.vertical)
          .padding(.horizontal, UI.Padding.DashboardButton.horizontal)
          .overlay {
            RoundedRectangle(cornerRadius: UI.CornerRadius.verySmall)
              .stroke(lineWidth: UI.Border.thin)
              .foregroundColor(.white)
          }
      }
    }
  }
}

struct DashboardButtonView_Previews: PreviewProvider {
    static var previews: some View {
      DashboardButtonView(store: Store(
        initialState: DashboardButtonDomain.State(image: Image.shoppingCart),
        reducer: DashboardButtonDomain()
      ))
    }
}

private extension UI.Padding {
  enum DashboardButton {
    static let vertical: CGFloat = 10
    static let horizontal: CGFloat = 20
  }
}
