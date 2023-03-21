//
//  PaymentView.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 11/01/2023.
//

import SwiftUI
import ComposableArchitecture

struct PaymentView: View {
  let store: StoreOf<PaymentDomain>
  
  var body: some View {
    WithViewStore(store) { viewStore in
      VStack(spacing: UI.Padding.large) {
        Text(LocalizedString.PaymentView.title)
          .font(.headline)
        HStack(spacing: UI.Padding.medium){
          PaymentMethodView(
            store: store.scope(
              state: \.creditCardState,
              action: PaymentDomain.Action.creditCard
            )
          )
          DividerView(axis: .horizontal)
          PaymentMethodView(
            store: store.scope(
              state: \.payPalState,
              action: PaymentDomain.Action.payPal
            )
          )
          DividerView(axis: .horizontal)
          PaymentMethodView(
            store: store.scope(
              state: \.cryptoState,
              action: PaymentDomain.Action.crypto
            )
          )
        }.frame(
          height: UI.PaymentView.paymentStackHeight,
          alignment: .center
        )
      }.frame(maxWidth: .infinity)
    }
  }
}

struct PaymentView_Previews: PreviewProvider {
  static var previews: some View {
    PaymentView(store: Store(
      initialState: PaymentDomain.State(),
      reducer: PaymentDomain()
    ))
  }
}

private extension UI {
  enum PaymentView {
    static let paymentStackHeight: CGFloat = 80
  }
}

private extension LocalizedString {
  enum PaymentView {
    static let title = "PAYMENT_METHODS_TITLE".localized
  }
}
