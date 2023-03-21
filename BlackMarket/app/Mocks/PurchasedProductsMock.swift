//
//  PurchasedProductsMock.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 09/03/2023.
//

import Foundation

final class PurchasedProductsMock {
  static let products: [PurchasedProduct] = [
    PurchasedProduct(
      id: 1,
      quantity: 1,
      unitPrice: "45",
      totalPrice: "45",
      name: "Gamer chair",
      picture: "product_1",
      dateBought: Date(),
      orderId: 1
    ),
    PurchasedProduct(
      id: 2,
      quantity: 3,
      unitPrice: "40",
      totalPrice: "120",
      name: "Living chair",
      picture: "product_2",
      dateBought: Date(),
      orderId: 2
    ),
    PurchasedProduct(
      id: 3,
      quantity: 4,
      unitPrice: "20",
      totalPrice: "80",
      name: "Coffee mug",
      picture: "product_3",
      dateBought: Date(),
      orderId: 3
    ),
    PurchasedProduct(
      id: 1,
      quantity: 3,
      unitPrice: "45",
      totalPrice: "135",
      name: "Gamer chair",
      picture: "product_1",
      dateBought: Date(),
      orderId: 1
    ),
    PurchasedProduct(
      id: 2,
      quantity: 3,
      unitPrice: "40",
      totalPrice: "120",
      name: "Living chair",
      picture: "product_2",
      dateBought: Date(),
      orderId: 2
    ),
    PurchasedProduct(
      id: 3,
      quantity: 4,
      unitPrice: "20",
      totalPrice: "80",
      name: "Coffee mug",
      picture: "product_3",
      dateBought: Date(),
      orderId: 3
    )
  ]
}
