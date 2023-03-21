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

public typealias BMRequestResponse<T: Decodable> = (
  result: Result<T?, BMError>,
  responseHeaders: [AnyHashable: Any]
)
public extension BMClient {
  
  func requestWithoutCookies<T: Decodable>(endpoint: Endpoint) async -> BMRequestResponse<T> {
    await withCheckedContinuation { continuation in
      
      AF.sessionConfiguration.httpCookieStorage?.removeCookies(since: .distantPast)
      self.request(endpoint: endpoint) { result, responseHeaders in
          continuation.resume(returning: (result, responseHeaders))
      }
    }
  }
}
