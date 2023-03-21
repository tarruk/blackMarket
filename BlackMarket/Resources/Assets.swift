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
  static let search = Image(systemName: "magnifyingglass")
  static let selectedHeart = Image(systemName: "heart.fill")
  static let unselectedHeart = Image(systemName: "heart")
  static let creditCard = Image("credit_card")
  static let crypto = Image("crypto")
  static let payPal = Image("paypal")
  static let facebook = Image("facebook")
  static let linkedin = Image("linkedin")
  static let instagram = Image("instagram")
  static let twitter = Image("twitter")
  static let picturePlaceholder = Image(systemName: "photo.fill")
  static let productsNotFound = Image("products_not_found")
  static let homeTab = Image(systemName: "house.fill")
  static let purchasesTab = Image("sell_icon")
  static let favoritesTab = Image("favorites_icon")
  static let shoppingCartTab = Image("shopping_cart_icon")
  static let menuTab = Image("menu_icon")
  static func eye(slashed: Bool) -> Image {
    return slashed ? Self.eyeSlash : Self.eye
  }
  
  static func heart(liked: Bool) -> Image {
    return liked ? Self.selectedHeart : Self.unselectedHeart
  }
}
