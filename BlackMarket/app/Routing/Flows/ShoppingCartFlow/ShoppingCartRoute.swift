//
//  ShoppingCartRoute.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 03/03/2023.
//

import Foundation
import SwiftUI

enum ShoppingCartRoute: Route {
  case selectedProductDetail
  
  @ViewBuilder
  var routeView: some View {
    switch self {
    case .selectedProductDetail:
      Text("Selected Product Detail")
    }
  }
}
