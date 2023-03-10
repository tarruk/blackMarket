//
//  MenuRouter.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 03/03/2023.
//

import Foundation
import Combine

final class MenuRouter: Router {
  
  typealias FlowRoute = MenuRoute

  @Published var stack: [MenuRoute] = []

  @Published var sheetPresented: MenuRoute?

  init() {}
}
