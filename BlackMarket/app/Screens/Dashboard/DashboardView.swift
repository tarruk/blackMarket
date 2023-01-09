//
//  DashboardView.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 09/01/2023.
//

import SwiftUI
import ComposableArchitecture

struct DashboardView: View {
    var body: some View {
      VStack {
        DashboardBarView(store: Store(
          initialState: DashboardBarDomain.State(),
          reducer: DashboardBarDomain()
        ))
        Spacer()
      }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
