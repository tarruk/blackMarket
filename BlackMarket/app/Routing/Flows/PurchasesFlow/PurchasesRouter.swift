//
//  PurchasesRouter.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 03/03/2023.
//

import Foundation
import Combine

final class PurchasesRouter: Router {
  typealias FlowRoute = PurchasesRoute
  
  /// The navigation stack, declared as a `Published` property, which means it will trigger an update whenever its value changes.
  @Published var stack: [PurchasesRoute] = []

  @Published var sheetPresented: PurchasesRoute?

  private var cancellableBag = Set<AnyCancellable>()
  
  init() {}
}
