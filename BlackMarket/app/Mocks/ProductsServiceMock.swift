//
//  ProductsServiceMock.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 10/01/2023.
//

import Foundation

// TODO: Replace this mock with the real model of the service
struct ProductsServiceMock {
  static let products: [Product] = [
    Product(
      id: UUID(),
      title: "Gamer chair",
      price: 45.6,
      state: .restored,
      liked: true,
      imageURL: "product_1"
    ),
    Product(
      id: UUID(),
      title: "Living chair",
      price: 20.4,
      state: .used,
      liked: false,
      imageURL: "product_2"
    ),
    Product(
      id: UUID(),
      title: "Coffee mug",
      price: 10.93,
      state: .new,
      liked: false,
      imageURL: "product_3"
    ),
    Product(
      id: UUID(),
      title: "Gamer chair",
      price: 45.6,
      state: .restored,
      liked: false,
      imageURL: "product_1"
    ),
    Product(
      id: UUID(),
      title: "Living chair",
      price: 20.4,
      state: .used,
      liked: false,
      imageURL: "product_2"
    ),
    Product(
      id: UUID(),
      title: "Coffee mug",
      price: 10.93,
      state: .new,
      liked: true,
      imageURL: "product_3"
    ),
  ]
}
