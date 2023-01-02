//
//  PromptView.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 29/12/2022.
//

import Foundation
import SwiftUI

enum PromptStyle: Equatable {
  case error
  case warning
  case success
  case custom(image: Image, color: Color)
  
  var icon: Image {
    switch self {
    case .error:
      return Image.error
    case .warning:
      return Image.warning
    case .success:
      return Image.success
    case .custom(let image, _):
      return image
    }
  }
  
  var color: Color {
    switch self {
    case .error:
      return .error
    case .warning:
      return .warning
    case .success:
      return .success
    case .custom(_, let color):
      return color
    }
  }
}

struct PromptView: View {
  
  let message: String
  let style: PromptStyle
  
  var body: some View {
    HStack {
      HStack(alignment: .center) {
        Text(message)
          .font(.caption)
          .minimumScaleFactor(UI.ScaleFactor.huge)
        style.icon
          .foregroundColor(style.color)
      }
      .padding(UI.Padding.small)
    }
    .background(
      .ultraThinMaterial,
      in: RoundedRectangle(
        cornerRadius: UI.CornerRadius.medium,
        style: .continuous
      )
      
    )
    .shadow(radius: UI.CornerRadius.medium)
    .frame(maxWidth: .infinity, maxHeight: UI.PromptView.height)
    .padding(.horizontal)
  }
}

struct PromptView_Previews: PreviewProvider {
    static var previews: some View {
      PromptView(
        message: "Hello, this is a test message to see how it looks in the prompt",
        style: .success
      )
    }
}

extension UI {
  enum PromptView {
    static let height: CGFloat = 60
  }
}
