//
//  TabBarRouter.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 03/03/2023.
//

import Foundation
import SwiftUI

/// A protocol defining a router for a tab bar view.
protocol TabBarRouter: ObservableObject {
  
  /// The associated type of route. It should conform to the `Route` protocol.
  associatedtype FlowRoute: Route
  associatedtype Screen: View
  /// An array of all possible routes (tabs) of the tab bar.
  var routes: [FlowRoute] { get }
  
  /// The current tab selected in the tab bar
  var currentTab: Binding<FlowRoute> { get }

  func switchTab(to tab: FlowRoute)
  
  var currentView: Screen { get }

  /// Initializes the tab bar router with the given routes.
  /// - Parameter routes: An array of all possible routes of the tab bar.
  init(routes: [FlowRoute])
}

/// Implementation example for `TabBarRouter`

final class TabBarManager: TabBarRouter, ObservableObject {

  typealias FlowRoute = TabRoute
  
  @Published private(set) var selectedTab: TabRoute = .home
  
  /// Returns the current view (associated with the selected tab), this is made from here because each view has to receive its specific router as environmentObject
  @ViewBuilder
  var currentView: some View {
    switch selectedTab {
    case .home:
      selectedTab.routeView
        .environmentObject(mainRouter)
    case .purchases:
      selectedTab.routeView
        .environmentObject(purchasesRouter)
    case .shoppingCart:
      selectedTab.routeView
        .environmentObject(shoppingCartRouter)
    case .favorites:
      selectedTab.routeView
        .environmentObject(favoritesRouter)
    case .menu:
      selectedTab.routeView
        .environmentObject(menuRouter)
    }
  }
  
  /// Routers have to be declared inside the TabBarManager to maintain the reference
  private let mainRouter = MainRouter()
  private let purchasesRouter = PurchasesRouter()
  private let favoritesRouter = FavoritesRouter()
  private let shoppingCartRouter = ShoppingCartRouter()
  private let menuRouter = MenuRouter()
  
  var currentTab: Binding<TabRoute> {
    Binding {
      self.selectedTab
    } set: { newValue in
      self.selectedTab = newValue
    }
  }
  
  private(set) var routes: [TabRoute] = []
  
  init(routes: [TabRoute]) {
    self.routes = routes
  }

  func switchTab(to tab: TabRoute) {
    selectedTab = tab
  }
}
