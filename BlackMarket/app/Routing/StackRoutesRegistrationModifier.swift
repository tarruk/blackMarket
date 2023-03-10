//
//  StackRoutesRegistrationModifier.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 17/02/2023.
//

import Foundation
import Combine
import SwiftUI

/// Each view registers its routes via this ViewModifier.
struct StackRoutesRegistrationModifier<R: Router>: ViewModifier {

  private let router: R

  init(router: R) {
    self.router = router
  }

  func body(content: Content) -> some View {
    content
      .navigationDestination(for: R.FlowRoute.self) { route in
        route.routeView
      }
  }
}

extension View {
  func registerStackDestinations<R: Router>(forRouter router: R) -> some View {
    modifier(StackRoutesRegistrationModifier(router: router))
  }
}
