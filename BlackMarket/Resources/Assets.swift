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
  
  static func eye(slashed: Bool) -> Image {
    return slashed ? Self.eyeSlash : Self.eye
  }
}