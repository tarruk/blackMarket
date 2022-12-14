//
//  TextFieldModifiers.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 14/12/2022.
//

import Foundation
import SwiftUI

struct LoginModifier: ViewModifier {

  var borderColor: Color = Color.gray

  func body(content: Content) -> some View {
    content
      .disableAutocorrection(true)
      .autocapitalization(.none)
      .overlay(
        RoundedRectangle(cornerRadius: UI.CornerRadius.medium)
          .strokeBorder(lineWidth: UI.Border.thin)
          .foregroundColor(borderColor)
      )
  }
}
