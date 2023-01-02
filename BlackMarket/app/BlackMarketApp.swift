//
//  BlackMarketApp.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 06/12/2022.
//

import SwiftUI
import ComposableArchitecture

@main
struct BlackMarketApp: App {
    var body: some Scene {
      WindowGroup {
        SignUpView(store: Store(initialState: SignUpDomain.State(), reducer: SignUpDomain()))
      }
    }
}
