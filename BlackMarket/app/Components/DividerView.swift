//
//  DividerView.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 11/01/2023.
//

import SwiftUI

struct DividerView: View {
  let axis: Axis
  let color: Color = .black
  
  var body: some View {
      Rectangle()
      .foregroundColor(color)
      .frame(
        maxWidth: axis == .vertical ? .infinity : 1,
        maxHeight: axis == .vertical ? 1 : .infinity
      )
  }
}
