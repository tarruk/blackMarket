//
//  BMClient.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 26/12/2022.
//

import Foundation
import RSSwiftNetworking
import RSSwiftNetworkingAlamofire

typealias BMCallback<T: Decodable> = (
  _ result: Result<T?, BMError>,
  _ responseHeaders: [AnyHashable: Any]
) -> Void

public final class BMClient {

  // MARK: - Properties

  private let emptyDataStatusCodes: Set<Int> = [204, 205]

  public private(set) var encodingConfiguration: EncodingConfiguration = .default

  public private(set) var decodingConfiguration: DecodingConfiguration = .default

  private(set) var headersProvider: HeadersProvider = [:]

  private let networkProvider: BMNetworkProvider

  required init(networkProvider: BMNetworkProvider) {
    self.networkProvider = networkProvider
  }

  convenience init(
    networkProvider: BMNetworkProvider,
    headersProvider: HeadersProvider,
    encodingConfiguration: EncodingConfiguration = .default,
    decodingConfiguration: DecodingConfiguration = .default
  ) {
    self.init(networkProvider: networkProvider)
    self.encodingConfiguration = encodingConfiguration
    self.decodingConfiguration = decodingConfiguration
    self.headersProvider = headersProvider
  }

  @discardableResult
  func request<T: Decodable>(
    endpoint: Endpoint,
    completion: @escaping BMCallback<T>
  ) -> Cancellable {
    networkProvider.request(
      endpoint: buildAPIEndpoint(from: endpoint)
    ) { [weak self] result in
      guard let self = self else { return }
      
      self.handle(result, for: endpoint, completion: completion)
    }
  }

  private func handle<T: Decodable>(
    _ result: Result<Network.Response, BMError>,
    for endpoint: Endpoint,
    completion: BMCallback<T>
  ) {
    switch result {
    case .success(let response):
      handle(response, with: endpoint.decodingConfiguration, completion: completion)
    case .failure(let error):
      completion(.failure(error), [:])
    }
  }
  
  private func buildAPIEndpoint(from endpoint: Endpoint) -> APIEndpoint {
    APIEndpoint(endpoint: endpoint, headersProvider: headersProvider)
  }
  
  private func handle<T: Decodable>(
    _ response: Network.Response,
    with configuration: DecodingConfiguration?,
    completion: BMCallback<T>
  ) {
    do {
      guard let data = response.data, !data.isEmpty else {
        guard emptyDataStatusCodes.contains(response.statusCode) else {
          throw APIClientError.invalidEmptyResponse
        }
        
        return completion(.success(.none), response.headers)
      }

      completion(.success(try decode(data, with: configuration)), response.headers)
    } catch {
      completion(
        .failure(handleCustomAPIError(from: response) ?? BMError(code: .badResult)),
        response.headers
      )
    }
  }
  
  private func decode<M: Decodable>(
    _ data: Data,
    with configuration: DecodingConfiguration?
  ) throws -> M {
    let decoder = JSONDecoder(decodingConfig: configuration ?? decodingConfiguration)

    return try decoder.decode(M.self, from: data)
  }
  
  private func handleCustomAPIError(from response: Network.Response) -> BMError? {
    BMError(
      response: response,
      decodingConfiguration: decodingConfiguration
    )
  }
}

extension BMClient {
  @discardableResult
  func request<T: Decodable>(endpoint: Endpoint) async -> BMRequestResponse<T> {
    await withCheckedContinuation { continuation in
        self.request(endpoint: endpoint) { result, responseHeaders in
            continuation.resume(
              returning: (result, responseHeaders)
            )
        }
      }
  }
}

extension BMClient {
  static let shared = BMClient(
    networkProvider: BMNetworkProvider()
  )
}
