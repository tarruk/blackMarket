//
//  PaymentMethod.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 11/01/2023.
//

import Foundation
import SwiftUI

enum PaymentMethod {
  case creditCard
  case crypto
  case payPal
  
  var title: String {
    switch self {
    case .creditCard:
      return "Credit"
    case .crypto:
      return "Crypto"
    case .payPal:
      return "Paypal"
    }
  }
  
  var logo: Image {
    switch self {
    case .creditCard:
      return Image.creditCard
    case .crypto:
      return Image.crypto
    case .payPal:
      return Image.payPal
    }
  }
}
