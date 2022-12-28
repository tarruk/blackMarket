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
    headersProvider: RailsAPIHeadersProvider(sessionProvider: SessionHeadersProvider())
  )) {
    self.apiClient = apiClient
  }
}
