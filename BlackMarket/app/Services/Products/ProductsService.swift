//
//  ProductsService.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 25/01/2023.
//

import Foundation
import RSSwiftNetworking

protocol ProductsServiceProtocol {
  func getProducts(
    categories: [String]?,
    page: Int?,
    pageSize: Int?,
    search: String?,
    state: String?,
    maxPrice: Double?,
    minPrice: Double?
  ) async throws -> [Product]
}

final class ProductsService: ProductsServiceProtocol {
  
  private let apiClient: BMClient
  
  init(apiClient: BMClient = .shared) {
    self.apiClient = apiClient
  }
  
  func getProducts(
    categories: [String]? = nil,
    page: Int? = nil,
    pageSize: Int? = nil,
    search: String? = nil,
    state: String? = nil,
    maxPrice: Double? = nil,
    minPrice: Double? = nil
  ) async throws -> [Product] {
    let response: BMRequestResponse<ProductsResponse> = await apiClient.request(
      endpoint: ProductsEndpoint.getProducts(
        categories: categories,
        page: page,
        pageSize: pageSize,
        search: search,
        state: state,
        maxPrice: maxPrice,
        minPrice: minPrice
      )
    )
    
    switch response.result {
    case .success(let productsResponse):
      if let products = productsResponse?.results {
        return products
      } else {
        throw BMError(code: .badResult)
      }
    case .failure(let error):
      throw error
    }
  }
}
