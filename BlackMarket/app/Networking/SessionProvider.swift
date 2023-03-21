//
//  SessionProvider.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 23/12/2022.
//

import Foundation
import RSSwiftNetworking

public protocol BMSessionProvider {
  var accessToken: String? { get }
}

internal protocol CurrentUserSessionProvider {
  var currentSession: Session? { get }
}

internal class SessionHeadersProvider: BMSessionProvider {

  // MARK: - Properties
  var accessToken: String? {
    session?.accessToken
  }

  private let currentSessionProvider: CurrentUserSessionProvider

  private var session: Session? {
    currentSessionProvider.currentSession
  }
  
  init(currentSessionProvider: CurrentUserSessionProvider = SessionManager()) {
    self.currentSessionProvider = currentSessionProvider
  }
}
