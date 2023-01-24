//
//  FooterView.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 16/01/2023.
//

import SwiftUI
import ComposableArchitecture

struct FooterView: View {
  let store: StoreOf<FooterDomain>
  
  var body: some View {
    WithViewStore(store) { viewStore in
      VStack {
        FooterBarView(store: store.scope(
          state: \.footerBarState,
          action: FooterDomain.Action.footerBar
        ))
        Text(viewStore.subscribeSectionTitle)
          .font(.title)
          .foregroundColor(.white)
          .fontWeight(.semibold)
          .lineLimit(1)
          .minimumScaleFactor(0.5)
          .padding()
        VStack(alignment: .leading) {
          Text(viewStore.emailTitle)
            .foregroundColor(.white)
          TextField(
            viewStore.textfieldPlaceholder,
            text: viewStore.binding(\.$email)
          ).modifier(FooterTextfieldModifier())
          BMButton(
            title: "Subscribe",
            style: .footer
          ) {
            //
          }
          .padding(.top, UI.Padding.small)
        }.padding()
      }
      .padding(.bottom)
      .background(.black)
    }
  }
}

struct FooterView_Previews: PreviewProvider {
  static var previews: some View {
    FooterView(store: Store(
      initialState: FooterDomain.State(email: ""),
      reducer: FooterDomain()
    ))
  }
}
