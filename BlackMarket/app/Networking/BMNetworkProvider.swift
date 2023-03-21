//
//  BMNetworkProvider.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 16/02/2023.
//

import Foundation
import RSSwiftNetworking
import Alamofire

/// This should be the only place where the `Alamofire` dependency is imported
final class BMNetworkProvider {
  
  init() {}
  
  func request(
    endpoint: Endpoint,
    completion: @escaping (Result<Network.Response, BMError>) -> Void
  ) -> Cancellable {
    let headers = HTTPHeaders(endpoint.headers)
    
    return AF.request(
      endpoint.requestURL,
      method: endpoint.method.alamofireMethod,
      parameters: endpoint.parameters,
      encoding: endpoint.parameterEncoding.alamofireEncoding,
      headers: headers
    )
    .response { [weak self] afResponse in
      switch afResponse.result {
      case.success:
        self?.handleAlamofireResponse(afResponse, completion: completion)
      case .failure(let error):
        completion(.failure(BMError(error)))
      }
    }
  }
  
  private func handleAlamofireResponse(
    _ afResponse: AFDataResponse<Data?>,
    completion: @escaping (Result<Network.Response, BMError>) -> Void
  ) {
    
    guard let response = afResponse.response else {
      completion(.failure(BMError(Network.ProviderError.noResponse)))
      return
    }
    
    completion(.success(Network.Response(
      statusCode: response.statusCode,
      data: afResponse.data,
      headers: response.headers.dictionary
    )))
  }
}

extension Network.HTTPMethod {
  var alamofireMethod: Alamofire.HTTPMethod {
    switch self {
    case .get:
      return .get
    case .post:
      return .post
    case .put:
      return .put
    case .delete:
      return .delete
    case .patch:
      return .patch
    }
  }
}

fileprivate extension RSSwiftNetworking.ParameterEncoding {
    var alamofireEncoding: Alamofire.ParameterEncoding {
        switch self {
        case .httpBody(let format):
            if format == .json {
                return JSONEncoding.default
            }
            return URLEncoding(destination: .httpBody)
        case .urlQuery:
            return URLEncoding(destination: .queryString)
        }
    }
}
