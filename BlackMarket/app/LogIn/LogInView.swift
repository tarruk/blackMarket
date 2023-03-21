//
//  LogInView.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 20/12/2022.
//

import SwiftUI
import ComposableArchitecture

struct LogInView: View {
  
  var body: some View {
    GeometryReader { reader in
      ZStack {
        Image.background
          .ignoresSafeArea()
        LogInCardView(store: Store(
          initialState: LogInCardDomain.State(),
          reducer: LogInCardDomain()
        ))
        .frame(
          maxWidth: .infinity,
          maxHeight: reader.size.height * 0.8,
          alignment: .center
        )
        .padding(UI.Padding.large)
      }.position(
        x: reader.frame(in: .local).midX,
        y: reader.frame(in: .local).midY
      )
    }
  }
}

struct LogInView_Previews: PreviewProvider {
  static var previews: some View {
    LogInView()
  }
}
