//
//  ProductState.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 10/01/2023.
//

import Foundation
import SwiftUI

enum ProductState: String, Decodable {
  case restored = "A"
  case new = "N"
  case used = "U"
  
  var title: String {
    switch self {
    case .restored:
      return "Restored"
    case .new:
      return "New"
    case .used:
      return "Used"
    }
  }
  
  var color: Color {
    switch self {
    case .restored:
      return .green
    case .new:
      return .blue
    case .used:
      return .orange
    }
  }
}
