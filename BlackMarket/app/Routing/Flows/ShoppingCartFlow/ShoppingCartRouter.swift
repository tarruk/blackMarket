//
//  ShoppingCartRouter.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 03/03/2023.
//

import Foundation
import Combine

final class ShoppingCartRouter: Router {
  
  typealias FlowRoute = ShoppingCartRoute

  @Published var stack: [ShoppingCartRoute] = []

  @Published var sheetPresented: ShoppingCartRoute?

  init() {}
}

