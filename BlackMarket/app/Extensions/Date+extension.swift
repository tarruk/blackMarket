//
//  Date+extension.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 09/03/2023.
//

import Foundation

extension Date {
  
  var bmFormatter: String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd.MM.yy"
    return dateFormatter.string(from: self)
  }
}
