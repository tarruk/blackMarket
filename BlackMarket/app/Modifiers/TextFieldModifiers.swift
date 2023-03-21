//
//  TextFieldLoginModifier.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 14/12/2022.
//

import Foundation
import SwiftUI

struct TextFieldLoginModifier: ViewModifier {

  var borderColor: Color = .gray

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

struct FooterTextfieldModifier: ViewModifier {

  func body(content: Content) -> some View {
    RoundedRectangle(cornerRadius: UI.CornerRadius.medium)
      .foregroundColor(.white)
      .overlay {
        content
          .disableAutocorrection(true)
          .autocapitalization(.none)
          .padding()
      }
      .frame(maxWidth: .infinity)
      .frame(height: 50)
  }
}
