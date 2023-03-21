//
//  ProductsResponse.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 25/01/2023.
//

import Foundation

struct ProductsResponse: Decodable {
  let count: Int
  let next: Int?
  let previous: Int?
  let results: [Product]
}
