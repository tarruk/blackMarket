//
//  PurcharsesDetailView.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 03/03/2023.
//

import SwiftUI

struct PurcharsesDetailView: View {
    
  @EnvironmentObject var router: PurchasesRouter

  var body: some View {
    NavigationStack(path: router.bindingStack) {
      VStack {
        Text("Purcharses Detail View")
        Button {
          router.push(toRoute: .productDetail)
        } label: {
          Text("Go to product detail")
        }
      }.registerStackDestinations(forRouter: router)
    }
  }
}

struct PurcharsesDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PurcharsesDetailView()
    }
}
