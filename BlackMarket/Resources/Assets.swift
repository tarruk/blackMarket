//
//  Assets.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 06/12/2022.
//

import Foundation
import SwiftUI

extension Image {
  static let background = Image("bm_background_image")
  static let logo = Image("bm_logo")
  static let eyeSlash = Image(systemName: "eye.slash.fill")
  static let eye = Image(systemName: "eye.fill")
  static let error = Image(systemName: "xmark.circle.fill")
  static let warning = Image(systemName: "exclamationmark.circle.fill")
  static let success = Image(systemName: "checkmark.circle.fill")
  static let shoppingCart = Image("shopping_cart")
  static let menu = Image("menu")
  static let search = Image(systemName: "magnifyingglass")
  static let selectedHeart = Image(systemName: "heart.fill")
  static let unselectedHeart = Image(systemName: "heart")
  static let creditCard = Image("credit_card")
  static let crypto = Image("crypto")
  static let payPal = Image("paypal")
  
  static func eye(slashed: Bool) -> Image {
    return slashed ? Self.eyeSlash : Self.eye
  }
  
  static func heart(liked: Bool) -> Image {
    return liked ? Self.selectedHeart : Self.unselectedHeart
  }
}
