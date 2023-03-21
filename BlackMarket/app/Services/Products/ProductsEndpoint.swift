//
//  ProductsEndpoint.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 25/01/2023.
//

import Foundation
import RSSwiftNetworking

enum ProductsEndpoint: RailsAPIEndpoint {
  case getProducts(
    categories: [String]?,
    page: Int?,
    pageSize: Int?,
    search: String?,
    state: String?,
    maxPrice: Double?,
    minPrice: Double?
  )
  
  var path: String {
    switch self {
    case .getProducts:
      return "/api/products/"
    }
  }
  
  var parameters: [String : Any] {
    switch self {
    case .getProducts(
      let categories,
      let page,
      let pageSize,
      let search,
      let state,
      let maxPrice,
      let minPrice
    ):
      var params: [String: Any] = [:]
      if let categories = categories {
        params["categories"] = categories
      }
      if let page = page {
        params["page"] = page
      }
      if let pageSize = pageSize {
        params["pageSize"] = pageSize
      }
      if let search = search {
        params["search"] = search
      }
      if let state = state {
        params["state"] = state
      }
      if let maxPrice = maxPrice {
        params["unit_price_max"] = maxPrice
      }
      if let minPrice = minPrice {
        params["unit_price_min"] = minPrice
      }
      return params
    }
  }
  
  var headers: [String : String] {
    return SessionManager.shared.sessionHeaders
  }
  var parameterEncoding: ParameterEncoding {
    switch self {
    case .getProducts:
      return .urlQuery
    }
  }
  var method: Network.HTTPMethod {
    switch self {
    case .getProducts:
      return .get
    }
  }
  
}
