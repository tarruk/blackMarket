//
//  PaymentMethodView.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 11/01/2023.
//

import SwiftUI
import ComposableArchitecture

struct PaymentMethodView: View {
  let store: StoreOf<PaymentMethodDomain>
  
  var body: some View {
    WithViewStore(store) { viewStore in
      Button {
        viewStore.send(.methodTapped)
      } label: {
        VStack(alignment: .center) {
          viewStore.image
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .scaledToFit()
          Spacer()
          Text(viewStore.title)
        }
      }.buttonStyle(ScaleButtonStyle())
    }
  }
}


struct PaymentMethodView_Previews: PreviewProvider {
    static var previews: some View {
      PaymentMethodView(
        store: Store(
          initialState: PaymentMethodDomain.State(method: .creditCard),
          reducer: PaymentMethodDomain()
        )
      )
    }
}
