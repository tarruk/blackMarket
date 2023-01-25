//
//  ProductState.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 10/01/2023.
//

import Foundation
import SwiftUI

enum ProductState: Decodable {
  case A
  case N
  case U
  
  var title: String {
    switch self {
    case .A:
      return "Restored"
    case .N:
      return "New"
    case .U:
      return "Used"
    }
  }
  
  var color: Color {
    switch self {
    case .A:
      return .green
    case .N:
      return .blue
    case .U:
      return .orange
    }
  }
}
