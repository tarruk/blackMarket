//
//  DashboardBarView.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 09/01/2023.
//

import SwiftUI
import ComposableArchitecture

struct DashboardBarView: View {

  var body: some View {
    HStack(alignment: .center) {
      Image.logo
        .resizable()
        .renderingMode(.template)
        .foregroundColor(.white)
        .frame(
          width: UI.DashboardBarView.logoWidth,
          height: UI.DashboardBarView.logoHeight
        )
    }
    .frame(
      maxWidth: UI.DashboardBarView.width,
      maxHeight: UI.DashboardBarView.height
    )
    .background(.black)
  }
}

struct DashboardBarView_Previews: PreviewProvider {
  static var previews: some View {
    DashboardBarView()
  }
}

private extension UI {
  enum DashboardBarView {
    static let height: CGFloat = 60
    static let width: CGFloat = .infinity
    static let logoHeight: CGFloat = 25
    static let logoWidth: CGFloat = 125
  }
}
