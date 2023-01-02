//
//  LoaderPresenterModifier.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 30/12/2022.
//

import Foundation
import SwiftUI

struct LoaderPresenterModifier: ViewModifier {
  
  let isLoading: Bool
  
  func body(content: Content) -> some View {
    ZStack {
      content
      if isLoading {
        LoaderView()
          .frame(maxWidth: .infinity, maxHeight: .infinity)
      }
    }
  }
}

struct LoaderPresenterModifier_Previews: PreviewProvider {
  static var previews: some View {
    Text("Hello, world!")
      .modifier(LoaderPresenterModifier(isLoading: true))
  }
}

extension View {
  func showLoader(_ isLoading: Bool) -> some View {
    modifier(LoaderPresenterModifier(isLoading: isLoading))
  }
}
