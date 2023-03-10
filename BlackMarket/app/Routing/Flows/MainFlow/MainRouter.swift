//
//  MainRouter.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 03/03/2023.
//

import Foundation
import Combine

final class MainRouter: Router {
  
  typealias FlowRoute = MainRoute

  @Published var stack: [MainRoute] = []

  @Published var sheetPresented: MainRoute?

  init() {}
}
