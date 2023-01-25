//
//  ProductsServiceMock.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 10/01/2023.
//

import Foundation

// TODO: Replace this mock with the real model of the service
struct ProductsServiceMock: ProductsServiceProtocol {
  func getProducts(categories: [String]?, page: Int?, pageSize: Int?, search: String?, state: String?, maxPrice: Double?, minPrice: Double?) async throws -> [Product] {
    return Self.products
  }
  
  static let products: [Product] = [
    Product(
      id: 1,
      name: "Gamer chair",
      state: .A,
      price: 45.6,
      picture: "product_1",
      favorite: true
    ),
    Product(
      id: 2,
      name: "Living chair",
      state: .U,
      price: 20.4,
      picture: "product_2",
      favorite: false
    ),
    Product(
      id: 3,
      name: "Coffee mug",
      state: .N,
      price: 10.93,
      picture: "product_3",
      favorite: false
    ),
    Product(
      id: 1,
      name: "Gamer chair",
      state: .A,
      price: 45.6,
      picture: "product_1",
      favorite: true
    ),
    Product(
      id: 2,
      name: "Living chair",
      state: .U,
      price: 20.4,
      picture: "product_2",
      favorite: false
    ),
    Product(
      id: 3,
      name: "Coffee mug",
      state: .N,
      price: 10.93,
      picture: "product_3",
      favorite: false
    ),
  ]
}
