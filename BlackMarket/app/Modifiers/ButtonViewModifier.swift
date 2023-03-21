//
//  ButtonViewModifier.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 07/12/2022.
//

import SwiftUI

enum ButtonStyle {
  case primary
  case secundary
  
  var height: CGFloat {
    switch self {
    case .primary, .secundary:
      return UI.Button.Height.large
    }
  }
  
  var width: CGFloat {
    switch self {
    case .primary, .secundary:
      return .infinity
    }
  }
  
  var backgroundColor: Color {
    switch self {
    case .primary:
      return .black
    case .secundary:
      return .clear
    }
  }
  
  var textColor: Color {
    switch self {
    case .primary:
      return .white
    case .secundary:
      return .blackish
    }
  }
}

struct ButtonViewModifier: ViewModifier {
  
  let style: ButtonStyle
  var disabled: Bool = false
  
  func body(content: Content) -> some View {
    switch style {
    case .primary:
      buildBorderedConfig(toContent: content)
        .disabled(disabled)
    case .secundary:
      buildBorderlessConfig(toContent: content)
    }
  }
  
  func buildBorderedConfig(toContent content: Content) -> some View {
    return content
      .frame(maxWidth: style.width)
      .frame(height: style.height)
      .background(disabled ? .lightGray : style.backgroundColor)
      .foregroundColor(disabled ? .darkGray : style.textColor)
      .font(.headline)
      .fontWeight(.semibold)
      .cornerRadius(UI.CornerRadius.small)
  }
  
  func buildBorderlessConfig(toContent content: Content) -> some View {
    return content
      .font(.headline)
      .fontWeight(.semibold)
      .frame(maxWidth: style.width)
      .frame(height: style.height)
      .foregroundColor(style.textColor)
      .overlay(
        RoundedRectangle(cornerRadius: UI.CornerRadius.small)
          .stroke(lineWidth: 1)
          .background(style.backgroundColor)
          .foregroundColor(style.textColor)
      )
  }
}

extension Text {
  func withButtonStyle(_ style: ButtonStyle, disabled: Bool) -> some View {
    modifier(ButtonViewModifier(style: style, disabled: disabled))
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
