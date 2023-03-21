//
//  MenuRoute.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 03/03/2023.
//

import Foundation
import SwiftUI

enum MenuRoute: Route {
  case settings
  case profile
  
  @ViewBuilder
  var routeView: some View {
    switch self {
    case .settings:
      Text("Settings")
    case .profile:
      Text("Profile")
    }
  }
}
