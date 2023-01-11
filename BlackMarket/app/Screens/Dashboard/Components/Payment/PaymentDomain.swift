//
//  PaymentDomain.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 11/01/2023.
//

import Foundation
import ComposableArchitecture
import SwiftUI

struct PaymentDomain: ReducerProtocol {
  struct State: Equatable {
    var creditCardState = PaymentMethodDomain.State(method: .creditCard)
    var payPalState = PaymentMethodDomain.State(method: .payPal)
    var cryptoState = PaymentMethodDomain.State(method: .crypto)
  }
  
  enum Action {
    case creditCard(PaymentMethodDomain.Action)
    case payPal(PaymentMethodDomain.Action)
    case crypto(PaymentMethodDomain.Action)
  }
  
  var body: some ReducerProtocol<State, Action> {
    
    Scope(state: \.creditCardState, action: /Action.creditCard) {
      PaymentMethodDomain()
    }
    Scope(state: \.payPalState, action: /Action.payPal) {
      PaymentMethodDomain()
    }
    Scope(state: \.cryptoState, action: /Action.crypto) {
      PaymentMethodDomain()
    }
    
    Reduce { state, action in
      return .none
    }
  }
}
