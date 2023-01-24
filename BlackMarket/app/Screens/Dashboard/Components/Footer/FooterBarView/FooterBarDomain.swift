//
//  FooterBarDomain.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 16/01/2023.
//

import Foundation
import ComposableArchitecture

struct FooterBarDomain: ReducerProtocol {
  struct State: Equatable {
    var instagramState = DashboardButtonDomain.State(image: .instagram)
    var facebookState = DashboardButtonDomain.State(image: .facebook)
    var twitterState = DashboardButtonDomain.State(image: .twitter)
    var linkedinState = DashboardButtonDomain.State(image: .linkedin)
  }
  
  enum Action {
    case instagramButton(DashboardButtonDomain.Action)
    case facebookButton(DashboardButtonDomain.Action)
    case twitterButton(DashboardButtonDomain.Action)
    case linkedinButton(DashboardButtonDomain.Action)
  }
  
  func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
    return .none
  }
}
