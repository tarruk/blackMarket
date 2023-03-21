//
//  SessionManager.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 23/12/2022.
//

import Foundation
import RSSwiftNetworking
import Combine

internal final class SessionManager: NSObject, CurrentUserSessionProvider {
  
  var isSessionValidPublisher: AnyPublisher<Bool, Never> {
    currentSessionPublisher
      .map { $0?.isValid ?? false }
      .eraseToAnyPublisher()
  }

  private var currentSessionPublisher: AnyPublisher<Session?, Never> {
    userDefaults.publisher(for: \.currentSession).eraseToAnyPublisher()
  }
  
  private var subscriptions = Set<AnyCancellable>()
  
  static let shared = SessionManager()

  private let userDefaults: UserDefaults

  init(userDefaults: UserDefaults = .standard) {
    self.userDefaults = userDefaults
  }

  private(set) var currentSession: Session? {
    get {
      userDefaults.currentSession
    }
    set {
      userDefaults.currentSession = newValue
    }
  }
  
  @MainActor
  func saveSession(accessToken: String?, refreshToken: String?) {
    currentSession = Session(accessToken: accessToken, refreshToken: refreshToken)
  }
  
  func deleteSession() {
    currentSession = nil
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
    currentSession?.isValid ?? false
  }
}

enum SessionKey {
  static let userSessionKey = "bm-session"
}

fileprivate extension UserDefaults {

  static let SESSION_KEY = SessionKey.userSessionKey

  @objc dynamic var currentSession: Session? {
    get {
      guard
        let data = UserDefaults.standard.data(forKey: SessionKey.userSessionKey),
        let session = try? JSONDecoder().decode(Session.self, from: data)
      else { return nil }
      return session
    }
    set {
      let json = try? JSONEncoder().encode(newValue)
      UserDefaults.standard.set(json, forKey: SessionKey.userSessionKey)
    }
  }
}
