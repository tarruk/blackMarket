//
//  Router.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 17/02/2023.
//

import Foundation
import SwiftUI
import Combine

/// The RouterProtocol defines the interface for a navigation manager.

protocol Router: ObservableObject {
  associatedtype FlowRoute: Route

  /// The navigation stack, contains a list of routes.
  var stack: [FlowRoute] { get set }

  var sheetPresented: FlowRoute? { get set }

  var modalBinding: Binding<FlowRoute?> { get }

  var bindingStack: Binding<[FlowRoute]> { get }

  /// Adds a new route to the end of the stack.
  ///
  /// - Parameter route: The route to be added.
  func push(toRoute route: FlowRoute)
  /// Removes the last route from the stack.
  func pop()
  /// Removes all routes from the stack, leaving it empty.
  func popToRoot()
  /// Adds multiple routes to the end of the stack.
  ///
  /// - Parameter routes: The routes to be added.
  func deepPush(toRoutes routes: [FlowRoute])
  /// Replaces the current stack with the given routes.
  ///
  /// - Parameter routes: The new stack of routes
  func beginNavigation(withRoutes routes: [FlowRoute])

  func present(_ route: FlowRoute)

  func dismiss()
}

//Convenience helpers

extension Router {
  var bindingStack: Binding<[FlowRoute]> {
    Binding {
      self.stack
    }
    set: { newValue in
      self.stack = newValue
    }
  }
  
  var modalBinding: Binding<FlowRoute?> {
    Binding {
      self.sheetPresented
    } set: { newValue in
      self.sheetPresented = newValue
    }
  }

  
   // MARK: - Stack Navigation
   func push(toRoute route: FlowRoute) {
     stack.append(route)
   }
   
   func pop() {
     if !stack.isEmpty {
       stack.removeLast()
     } else {
       debugPrint("Can't go back because the navigation stack is empty")
     }
   }
   
   func popToRoot() {
     stack = []
   }
   
   func deepPush(toRoutes routes: [FlowRoute]) {
     stack.append(contentsOf: routes)
   }
   
   func beginNavigation(withRoutes routes: [FlowRoute]) {
     stack = routes
   }

   // MARK: - Modal Navigations
   func present(_ route: FlowRoute) {
     sheetPresented = route
   }

   func dismiss() {
     sheetPresented = nil
   }
}
