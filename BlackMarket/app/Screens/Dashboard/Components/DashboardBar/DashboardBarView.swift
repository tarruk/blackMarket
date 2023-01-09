//
//  DashboardBarView.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 09/01/2023.
//

import SwiftUI
import ComposableArchitecture

struct DashboardBarView: View {
  let store: StoreOf<DashboardBarDomain>
  
  var body: some View {
    WithViewStore(store) { viewStore in
      HStack {
        Image.logo
          .resizable()
          .renderingMode(.template)
          .foregroundColor(.white)
          .frame(
            width: UI.DashboardBarView.logoWidth,
            height: UI.DashboardBarView.logoHeight
          )
          .padding(.leading)
        Spacer()
        DashboardButtonView(
          store: store.scope(
            state: \.cartButtonState,
            action: DashboardBarDomain.Action.cartButtonTapped
          )
        )
        DashboardButtonView(
          store: store.scope(
            state: \.menuButtonState,
            action: DashboardBarDomain.Action.menuButtonTapped
          )
        )
        .padding(.trailing)
        
      }
      .frame(
        maxWidth: UI.DashboardBarView.width,
        maxHeight: UI.DashboardBarView.height
      )
      .background(.black)
    }
  }
}

struct DashboardBarView_Previews: PreviewProvider {
  static var previews: some View {
    DashboardBarView(store: Store(
      initialState: DashboardBarDomain.State(),
      reducer: DashboardBarDomain()
    ))
  }
}

private extension UI {
  enum DashboardBarView {
    static let height: CGFloat = 60
    static let width: CGFloat = .infinity
    static let logoHeight: CGFloat = 25
    static let logoWidth: CGFloat = 125
  }
}
