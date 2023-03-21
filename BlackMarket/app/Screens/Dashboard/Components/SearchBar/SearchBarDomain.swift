//
//  SearchBarDomain.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 09/01/2023.
//

import Foundation
import ComposableArchitecture

struct SearchBarDomain: ReducerProtocol {
  struct State: Equatable {
    
    static func == (lhs: SearchBarDomain.State, rhs: SearchBarDomain.State) -> Bool {
      rhs.text == lhs.text
    }
    
    var placeholder: String = LocalizedString.SearchBarDomain.placeholder
    @BindableState var text: String
  }
  
  enum Action: BindableAction {
    case binding(BindingAction<State>)
    case search
    case textDidChange(String)
  }
  
  var body: some ReducerProtocol<State, Action> {
    
    BindingReducer()
    
    Reduce { state, action in
      return .none
    }
  }
}

private extension LocalizedString {
  enum SearchBarDomain {
    static let placeholder: String = "SEARCHBAR_PLACEHOLDER".localized
  }
}
