//
//  BMButton.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 07/12/2022.
//

import SwiftUI

struct BMButton: View {
  
  let backgroundColor: Color
  let textColor: Color
  let title: String
  let cornerRadius: CGFloat
  
  var body: some View {
    ZStack {
      backgroundColor
      Text(title)
        .foregroundColor(textColor)
    }
    .contentShape(RoundedRectangle(cornerRadius: 5))
    .cornerRadius(cornerRadius)
  }
}

struct BMButton_Previews: PreviewProvider {
    static var previews: some View {
      BMButton(
        backgroundColor: .black,
        textColor: .white,
        title: "Sign up",
        cornerRadius: 5
      )
    }
}
