//
//  SignUpView.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 06/12/2022.
//

import SwiftUI
import ComposableArchitecture

struct SignUpView: View {
  
  var body: some View {
    GeometryReader { reader in
      ZStack {
        Image.background
          .ignoresSafeArea()
        SignUpCardView(
          store: Store(
            initialState: SignUpCardDomain.State(),
            reducer: SignUpCardDomain()
          )
        )
        .frame(maxWidth: .infinity, maxHeight: reader.size.height * 0.8, alignment: .center)
        .padding(UI.Padding.large)
      }.position(x: reader.frame(in: .local).midX, y: reader.frame(in: .local).midY)
    }
  }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
      SignUpView()
    }
}
