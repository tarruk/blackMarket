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
  @State private var isLogged: Bool = SessionManager.shared.isValidSession
  
  var body: some Scene {
    WindowGroup {
      Group {
        if isLogged {
          DashboardView(
            store: Store(
              initialState: DashboardDomain.State(),
              reducer: DashboardDomain()
            )
          )
        } else {
          AuthView(
            store: Store(
              initialState: AuthDomain.State(),
              reducer: AuthDomain()
            )
          )
        }
      }.onReceive(SessionManager.shared.isSessionValidPublisher) { isValid in
        isLogged = isValid
      }
    }
  }
}
