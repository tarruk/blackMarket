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
    ZStack {
      Image.backgroundImage
      SignUpCardView(
        store: Store(
          initialState: SignUpCardDomain.State(),
          reducer: SignUpCardDomain()
        )
      ).padding(UI.Padding.large)
    }
  }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
     SignUpView()
    }
}
