//
//  APIClient+extension.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 06/01/2023.
//

import Foundation
import RSSwiftNetworkingAlamofire
import Alamofire
import RSSwiftNetworking

public extension APIClient {
  
  func requestWithoutCookies<T: Decodable>(endpoint: Endpoint) async -> RequestResponse<T> {
    await withCheckedContinuation { continuation in
      
      AF.sessionConfiguration.httpCookieStorage?.removeCookies(since: .distantPast)
      self.request(endpoint: endpoint) { result, responseHeaders in
          continuation.resume(returning: (result, responseHeaders))
      }
    }
  }
}
