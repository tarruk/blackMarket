//
//  PurchasesRoute.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 03/03/2023.
//

import Foundation
import SwiftUI

enum PurchasesRoute: Route {
  case productDetail
  
  @ViewBuilder
  var routeView: some View {
    switch self {
    case .productDetail:
      Text("Product Detail")
    }
  }
}

