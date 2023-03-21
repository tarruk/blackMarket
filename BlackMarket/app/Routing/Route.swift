//
//  Route.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 17/02/2023.
//

import Foundation
import SwiftUI

protocol Route: Hashable, Identifiable {
  associatedtype Screen: View
  var routeView: Screen { get }
}

extension Route {
  var id: Self { self }
}
