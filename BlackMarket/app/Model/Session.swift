//
//  Session.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 23/12/2022.
//

import Foundation
import RSSwiftNetworking

struct Session: Codable {
  var accessToken: String?
  var refreshToken: String?
  
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
