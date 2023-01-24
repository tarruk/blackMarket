//
//  FooterBarView.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 16/01/2023.
//

import SwiftUI
import ComposableArchitecture

struct FooterBarView: View {
  let store: StoreOf<FooterBarDomain>
  
  var body: some View {
    WithViewStore(store) { viewStore in
      HStack(spacing: 20) {
        Image.logo
          .resizable()
          .renderingMode(.template)
          .foregroundColor(.white)
          .frame(
            width: 125,
            height: 25
          )
        Spacer()
        FooterBarButtonView(
          store: store.scope(
            state: \.instagramState,
            action: FooterBarDomain.Action.instagramButton
        ))
        FooterBarButtonView(
          store: store.scope(
            state: \.facebookState,
            action: FooterBarDomain.Action.facebookButton
        ))
        FooterBarButtonView(
          store: store.scope(
            state: \.twitterState,
            action: FooterBarDomain.Action.twitterButton
        ))
        FooterBarButtonView(
          store: store.scope(
            state: \.linkedinState,
            action: FooterBarDomain.Action.linkedinButton
        ))
      }.padding()
    }
  }
}

struct FooterBarView_Previews: PreviewProvider {
  static var previews: some View {
    FooterBarView(store: Store(
      initialState: FooterBarDomain.State(),
      reducer: FooterBarDomain()
    ))
  }
}
