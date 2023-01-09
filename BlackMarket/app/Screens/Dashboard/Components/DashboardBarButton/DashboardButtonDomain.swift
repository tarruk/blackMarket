//
//  DashboardButtonDomain.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 09/01/2023.
//

import Foundation
import ComposableArchitecture
import SwiftUI

struct DashboardButtonDomain: ReducerProtocol {
  struct State: Equatable {
    var image: Image
  }
  enum Action: BindableAction {
    case binding(BindingAction<State>)
    case buttonTapped
  }
  
  func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
    return .none
  }
}
