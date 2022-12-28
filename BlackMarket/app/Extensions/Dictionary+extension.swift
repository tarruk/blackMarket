//
//  Dictionary+extension.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 23/12/2022.
//

import Foundation

extension Dictionary where Key: ExpressibleByStringLiteral {
  
  mutating func lowercaseKeys() {
    for key in self.keys {
      if let loweredKey = String(describing: key).lowercased() as? Key {
        self[loweredKey] = self.removeValue(forKey: key)
      }
    }
  }
}
