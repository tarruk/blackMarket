//
//  Product.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 10/01/2023.
//

import Foundation
import SwiftUI


struct Category: Decodable {
  let id: Int
  let name: String
}

struct Product: Decodable, Equatable {
  
  var id: Int
  var name: String
  var categories: [Category]
  var description: String?
  var state: ProductState?
  var itemsAvaliable: Int?
  var price: Double?
  var picture: String?
  var productPictures: [String]?
  var stateDisplay: String?
  var favorite: Bool?

  enum CodingKeys: String, CodingKey {
    case id
    case name
    case categories
    case description
    case state
    case itemsAvaliable = "num_available_items"
    case price = "unit_price"
    case picture = "product_picture"
    case productPictures = "product_pictures"
    case stateDisplay = "state_display"
    case favorite = "is_favorite"
  }
  
  init(
    id: Int,
    name: String,
    categories: [Category] = [],
    description: String? = nil,
    state: ProductState? = nil,
    itemsAvaliable: Int? = nil,
    price: Double? = nil,
    picture: String? = nil,
    productPictures: [String] = [],
    stateDisplay: String? = nil,
    favorite: Bool? = nil
  ) {
    self.id = id
    self.name = name
    self.categories = categories
    self.description = description
    self.state = state
    self.itemsAvaliable = itemsAvaliable
    self.price = price
    self.picture = picture
    self.productPictures = productPictures
    self.stateDisplay = stateDisplay
    self.favorite = favorite
  }
  
  static func == (lhs: Product, rhs: Product) -> Bool {
    lhs.id == rhs.id
  }
}
