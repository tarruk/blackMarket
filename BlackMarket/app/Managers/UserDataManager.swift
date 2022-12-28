//
//  UserDataManager.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 23/12/2022.
//

import Foundation

final class UserDataManager: NSObject {
  static let shared = UserDataManager()
  
  private let userkey = "bm-user"
  
  var currentUser: User? {
    get {
      if
        let data = UserDefaults.standard.data(forKey: userkey),
        let user = try? JSONDecoder().decode(User.self, from: data) {
        return user
      } else {
        return nil
      }
    }
    set {
      let json = try? JSONEncoder().encode(newValue)
      UserDefaults.standard.set(json, forKey: userkey)
    }
  }
  
  func deleteUser() {
    UserDefaults.standard.removeObject(forKey: userkey)
  }
  
  var isUserLogged: Bool {
    currentUser != nil
  }
}
