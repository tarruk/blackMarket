//
//  Session.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 23/12/2022.
//

import Foundation
import RSSwiftNetworking

struct Session: Codable {
  var uid: String?
  var client: String?
  var accessToken: String?
  var expiry: Date?
  
  private enum CodingKeys: String, CodingKey {
    case uid
    case client
    case accessToken = "access-token"
    case expiry
  }

  init(
    uid: String? = nil, client: String? = nil,
    token: String? = nil, expires: Date? = nil
  ) {
    self.uid = uid
    self.client = client
    self.accessToken = token
    self.expiry = expires
  }
  
  init?(headers: [AnyHashable: Any]) {
    guard var stringHeaders = headers as? [String: String] else {
      return nil
    }

    stringHeaders.lowercaseKeys()
    
    if let expiryString = stringHeaders[HTTPHeader.expiry.rawValue],
      let expiryNumber = Double(expiryString) {
      expiry = Date(timeIntervalSince1970: expiryNumber)
    }
    uid = stringHeaders[HTTPHeader.uid.rawValue]
    client = stringHeaders[HTTPHeader.client.rawValue]
    accessToken = stringHeaders[HTTPHeader.token.rawValue]
  }
}
