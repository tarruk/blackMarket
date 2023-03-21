//
//  TabBarView.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 17/02/2023.
//

import SwiftUI
import ComposableArchitecture
import Combine

struct TabBarView: View {
  @ObservedObject private var tabBarManager: TabBarManager
  
  init(tabBarManager: TabBarManager) {
    self.tabBarManager = tabBarManager
  }
  
  var body: some View {
    ZStack {
      tabBarManager.currentView
      VStack {
        Spacer()
        HStack {
          ForEach(tabBarManager.routes) { tab in
            Spacer()
            getTabImage(forTab: tab)
              .onTapGesture {
                tabBarManager.switchTab(to: tab)
              }
          }
          Spacer()
        }
        .frame(height: 50)
        .frame(maxWidth: .infinity, alignment: .bottom)
        .background(.black)
      }
    }
  }
  
  private func getTabImage(forTab tab: TabRoute) -> some View {
    ZStack {
      if tab == tabBarManager.currentTab.wrappedValue {
        Circle()
          .foregroundColor(.gray)
          .frame(width: 70, height: 70)
      }
      tab.image
        .renderingMode(.template)
        .foregroundColor(tabBarManager.currentTab.wrappedValue == tab ? .black : .white)
    }
  }
  
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
      TabBarView(
        tabBarManager: TabBarManager(routes: [])
      )
    }
}
