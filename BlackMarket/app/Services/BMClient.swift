//
//  BMClient.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 26/12/2022.
//

import Foundation
import RSSwiftNetworking
import RSSwiftNetworkingAlamofire

class BMClient {
  
  static let shared = BMClient()
  let apiClient: APIClient

  init(apiClient: APIClient = BaseAPIClient(
    networkProvider: AlamofireNetworkProvider(),
    headersProvider: BMAPIHeadersProvider(sessionProvider: SessionHeadersProvider())
  )) {
    self.apiClient = apiClient
  }
}

open class BMAPIHeadersProvider: HeadersProvider {

  private let sessionProvider: BMSessionProvider
  private let contentTypeJSON = "application/json"
  private var contentTypeHeaders: [String: String] {
    [
      BMHTTPHeader.accept.rawValue: contentTypeJSON,
      BMHTTPHeader.contentType.rawValue: contentTypeJSON
    ]
  }

  public var requestHeaders: [String: String] {
    contentTypeHeaders.merging(sessionProvider.headers) { current, _ in current }
  }

  public init(sessionProvider: BMSessionProvider) {
    self.sessionProvider = sessionProvider
  }

}
extension BMSessionProvider {
  var headers: [String: String] {
    var headers: [String: String] = [:]

    if let token = accessToken {
      headers[BMHTTPHeader.accessToken.rawValue] = token
    }

    return headers
  }
}
