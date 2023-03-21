//
//  FavoritesRoute.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 03/03/2023.
//

import Foundation
import SwiftUI

enum FavoritesRoute: Route {
  case favoriteDetail
  
  @ViewBuilder
  var routeView: some View {
    switch self {
    case .favoriteDetail:
      Text("Favorite Detail")
    }
  }
}

