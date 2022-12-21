//
//  String+extension.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 07/12/2022.
//

import Foundation
import SwiftUI

extension String {
  
  var localized: String {
    NSLocalizedString(self, comment: "")
  }
  
  func localized(comment: String) -> String {
    NSLocalizedString(self, comment: comment)
  }
  
  func transformToLink(withURL url: String) -> AttributedString? {
    guard let attributedText = try? AttributedString(markdown: "\(self)(\(url))") else {
      return ""
    }
    return attributedText
  }
  
}
