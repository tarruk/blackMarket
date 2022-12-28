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
      let client = session.client,
      let accessToken = session.accessToken,
      let uid = session.uid else {
        return [:]
    }
    return [
      HTTPHeader.client.rawValue: client,
      HTTPHeader.token.rawValue: accessToken,
      HTTPHeader.uid.rawValue: uid,
      HTTPHeader.contentType.rawValue: "application/json"
    ]
  }
  
  var isValidSession: Bool {
    if
      let session = currentSession,
      let uid = session.uid,
      let accessToken = session.accessToken,
      let client = session.client {
      return !uid.isEmpty && !accessToken.isEmpty && !client.isEmpty
    }
    return false
  }
  
  func deleteSession() {
    UserDefaults.standard.removeObject(forKey: sessionKey)
  }
}
