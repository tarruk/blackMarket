//
//  PurchasedItemDomain.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 08/03/2023.
//

import Foundation
import ComposableArchitecture

struct PurchasedItemDomain: ReducerProtocol {
  struct State: Equatable {
    var id: Int
    var imageURL: URL?
    var title: String
    var formattedPrice: String
    var productState: ProductState
    var numberOfItems: String
    var playImage: String?
    var boughtDate: String
    
    init(product: PurchasedProduct) {
      self.imageURL = URL(string: product.picture?.urlSpacesSensible ?? "")
      self.id = product.id
      self.title = product.name
      self.formattedPrice = String(
        format: LocalizedString.PurchasedItemDomain.formattedPrice,
        product.unitPrice
      )
      self.productState = .restored
      
      if product.quantity > 1 {
        self.numberOfItems = "\(product.quantity) \(LocalizedString.PurchasedItemDomain.purchasedItems)"
      } else {
        self.numberOfItems = "\(product.quantity) \(LocalizedString.PurchasedItemDomain.purchasedItem)"
      }
     
      self.playImage = product.picture
      self.boughtDate = product.dateBought.bmFormatter
    }
    
  }
 
  enum Action {}
  
  func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
    return .none
  }
}

extension LocalizedString {
  enum PurchasedItemDomain {
    static let formattedPrice = "PURCHASED_ITEM_FORMATTED_PRICE".localized
    static let purchasedItem = "PURCHASED_ITEM".localized
    static let purchasedItems = "PURCHASED_ITEMS".localized
  }
}
