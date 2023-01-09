//
//  UIConstants.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 07/12/2022.
//

import Foundation
import SwiftUI

struct UI {
  
  enum CornerRadius {
    static let verySmall: CGFloat = 2
    static let small: CGFloat = 5
    static let medium: CGFloat = 10
    static let large: CGFloat = 20
  }
  
  enum Border {
    static let thick: CGFloat = 2
    static let thin: CGFloat = 1
  }
  
  enum Padding {
    static let huge: CGFloat = 42
    static let large: CGFloat = 32
    static let medium: CGFloat = 22
    static let small: CGFloat = 12
    static let verySmall: CGFloat = 4
  }
  
  enum ScaleFactor {
    static let huge: CGFloat = 0.8
    static let large: CGFloat = 0.7
    static let medium: CGFloat = 0.6
    static let small: CGFloat = 0.5
  }
  
  enum IconSize {
    static let huge: CGFloat = 16
    static let large: CGFloat = 14
    static let medium: CGFloat = 12
    static let small: CGFloat = 10
  }
  
  enum ViewAnimations {
    static let prompt: Animation = .spring(response: 0.4, dampingFraction: 0.6)
  }
}
