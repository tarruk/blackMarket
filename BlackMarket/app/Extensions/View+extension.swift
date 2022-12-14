//
//  View+extension.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 15/12/2022.
//

import Foundation
import SwiftUI

//To manage @FocusedState in TCA 
extension View {
  func synchronize<Value>(
    _ first: Binding<Value>,
    _ second: FocusState<Value>.Binding
  ) -> some View {
    self
      .onChange(of: first.wrappedValue) { second.wrappedValue = $0 }
      .onChange(of: second.wrappedValue) { first.wrappedValue = $0 }
  }
}
