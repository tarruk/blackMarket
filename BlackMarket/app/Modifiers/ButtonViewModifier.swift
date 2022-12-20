//
//  ButtonViewModifier.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 07/12/2022.
//

import SwiftUI

enum ButtonStyle {
  case primary
  
  var height: CGFloat {
    switch self {
    case .primary:
      return UI.Button.Height.large
    }
  }
  
  var width: CGFloat {
    switch self {
    case .primary:
      return .infinity
    }
  }
  
  var backgroundColor: Color {
    switch self {
    case .primary:
      return .black
    }
  }
  
  var textColor: Color {
    switch self {
    case .primary:
      return .white
    }
  }
}

struct ButtonViewModifier: ViewModifier {
  
  let style: ButtonStyle
  
  func body(content: Content) -> some View {
    content
      .frame(maxWidth: style.width)
      .frame(height: style.height)
      .background(style.backgroundColor)
      .foregroundColor(style.textColor)
      .font(.headline)
      .fontWeight(.semibold)
      .cornerRadius(5)
  }
}

extension Text {
  func withButtonStyle(_ style: ButtonStyle) -> some View {
    modifier(ButtonViewModifier(style: style))
  }
}

extension UI {
  struct Button {
    enum Width {
      static let large: CGFloat = 250
      static let medium: CGFloat = 200
      static let small: CGFloat = 180
      static let verySmall: CGFloat = 100
    }
    enum Height {
      static let large: CGFloat = 50
      static let medium: CGFloat = 45
      static let small: CGFloat = 40
      static let verySmall: CGFloat = 30
    }
  }
}
