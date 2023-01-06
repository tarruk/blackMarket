//
//  SessionManager.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 23/12/2022.
//

import Foundation
import RSSwiftNetworking

final class SessionDataManager: CurrentUserSessionProvider {
  static let shared = SessionDataManager()
  
  private let sessionKey = "bm-session"
  
  var currentSession: Session? {
    get {
      guard
        let data = UserDefaults.standard.data(forKey: sessionKey),
        let session = try? JSONDecoder().decode(Session.self, from: data)
      else { return nil }
      return session
    }
    set {
      let json = try? JSONEncoder().encode(newValue)
      UserDefaults.standard.set(json, forKey: sessionKey)
    }
  }
  
  var sessionHeaders: [String: String] {
    guard
      let session = currentSession,
      let accessToken = session.accessToken
    else {
      return [:]
    }
    return [
      BMHTTPHeader.contentType.rawValue: "application/json",
      BMHTTPHeader.authorization.rawValue: "Bearer \(accessToken)"
    ]
  }
  
  var isValidSession: Bool {
    if
      let session = currentSession,
      let accessToken = session.accessToken {
      return !accessToken.isEmpty
    }
    return false
  }
  
  func deleteSession() {
    UserDefaults.standard.removeObject(forKey: sessionKey)
  }
}
