//
//  PurchasedProduct.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 09/03/2023.
//

import Foundation

struct PurchasedProduct: Decodable, Equatable {
  let id: Int
  let quantity: Int
  let unitPrice: String
  let totalPrice: String
  let name: String
  let picture: String?
  let dateBought: Date
  let orderId: Int
  
  enum CodingKeys: String, CodingKey {
    case id
    case quantity
    case unitPrice = "unit_price"
    case totalPrice = "total_product_price"
    case name = "product_name"
    case picture = "product_picture"
    case dateBought = "product_date_bought"
    case orderId = "order_id"
  }
}
