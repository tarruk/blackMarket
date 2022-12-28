//
//  SessionProvider.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 23/12/2022.
//

import Foundation
import RSSwiftNetworking

internal protocol CurrentUserSessionProvider {
  var currentSession: Session? { get }
}

internal class SessionHeadersProvider: SessionProvider {

  // MARK: - Properties

  var uid: String? {
    session?.uid
  }

  var client: String? {
    session?.client
  }

  var accessToken: String? {
    session?.accessToken
  }

  private let currentSessionProvider: CurrentUserSessionProvider

  private var session: Session? {
    currentSessionProvider.currentSession
  }
  
  init(currentSessionProvider: CurrentUserSessionProvider = SessionDataManager()) {
    self.currentSessionProvider = currentSessionProvider
  }
}
