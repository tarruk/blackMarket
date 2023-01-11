//
//  Product.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 10/01/2023.
//

import Foundation
import SwiftUI

struct Product: Decodable, Equatable {
  let id: UUID
  let title: String
  let price: Double
  let state: ProductState
  let liked: Bool
  let imageURL: String
}
