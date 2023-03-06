//
//  FavoritesRouter.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 03/03/2023.
//

import Foundation
import Combine

final class FavoritesRouter: Router {
  
  typealias FlowRoute = FavoritesRoute

  @Published var stack: [FavoritesRoute] = []

  @Published var sheetPresented: FavoritesRoute?
  
  private var cancellableBag = Set<AnyCancellable>()
  
  init() {}
}
