//
//  TabRoute.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 03/03/2023.
//

import Foundation
import ComposableArchitecture
import SwiftUI

enum TabRoute: Route {
  case home
  case purchases
  case shoppingCart
  case favorites
  case menu

  @ViewBuilder
  var routeView: some View {
    switch self {
    case .home:
      DashboardView(
        store: Store(
          initialState: DashboardDomain.State(),
          reducer: DashboardDomain()
        ))
    case .purchases:
     PurcharsesDetailView()
    case .shoppingCart:
      Text("Shopping Cart")
    case .favorites:
      Text("Favorites")
    case .menu:
      Text("Menu")
    }
  }
  
  var image: Image {
    switch self {
    case .home:
      return Image.homeTab
    case .purchases:
      return Image.purchasesTab
    case .shoppingCart:
      return Image.shoppingCartTab
    case .favorites:
      return Image.favoritesTab
    case .menu:
      return Image.menuTab
    }
  }
}

