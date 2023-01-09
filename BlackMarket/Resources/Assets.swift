//
//  Assets.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 06/12/2022.
//

import Foundation
import SwiftUI

extension Image {
  static let background = Image("bm-background-image")
  static let logo = Image("bm-logo")
  static let eyeSlash = Image(systemName: "eye.slash.fill")
  static let eye = Image(systemName: "eye.fill")
  static let error = Image(systemName: "xmark.circle.fill")
  static let warning = Image(systemName: "exclamationmark.circle.fill")
  static let success = Image(systemName: "checkmark.circle.fill")
  static let shoppingCart = Image("shopping-cart")
  static let menu = Image("menu")
  static func eye(slashed: Bool) -> Image {
    return slashed ? Self.eyeSlash : Self.eye
  }
}
