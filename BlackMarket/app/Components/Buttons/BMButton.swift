//
//  BMButton.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 20/12/2022.
//

import SwiftUI

struct BMButton: View {
  
  let title: String
  let style: ButtonStyle
  var disabled: Bool = false
  let action: () -> Void
  
  var body: some View {
    Button(
      action: action,
      label: {
        Text(title)
          .withButtonStyle(style, disabled: disabled)
      }).disabled(disabled)
  }
}

struct BMButton_Previews: PreviewProvider {
  static var previews: some View {
    BMButton(
      title: "Log in",
      style: .primary,
      disabled: true) {
        // Action
      }
  }
}
