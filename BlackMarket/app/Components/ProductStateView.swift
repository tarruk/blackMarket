//
//  ProductStateView.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 09/03/2023.
//

import SwiftUI

struct ProductStateView: View {
  
  let state: ProductState

  var body: some View {
    Text(state.title)
      .font(.caption)
      .fontWeight(.semibold)
      .padding(UI.Padding.verySmall)
      .background(state.color)
      .foregroundColor(.white)
      .cornerRadius(UI.CornerRadius.small)
      .lineLimit(1)
      .minimumScaleFactor(UI.ScaleFactor.small)
  }
}

struct ProductStateView_Previews: PreviewProvider {
  static var previews: some View {
    ProductStateView(state: .new)
  }
}
