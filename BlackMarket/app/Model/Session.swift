//
//  Session.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 23/12/2022.
//

import Foundation
import RSSwiftNetworking

class Session: NSObject, Codable {
  @objc dynamic var accessToken: String?
  @objc dynamic var refreshToken: String?
  
  var isValid: Bool {
    if
      let accessToken = accessToken {
      return !accessToken.isEmpty
    }
    return false
  }
  
  private enum CodingKeys: String, CodingKey {
    case accessToken = "access_token"
    case refreshToken = "refresh_token"
  }
  
  init(
    accessToken: String? = nil,
    refreshToken: String? = nil
  ) {
    self.accessToken = accessToken
    self.refreshToken = refreshToken
  }
}
