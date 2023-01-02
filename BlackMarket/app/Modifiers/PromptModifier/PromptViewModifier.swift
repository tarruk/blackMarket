//
//  PromptViewModifier.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 28/12/2022.
//

import Foundation
import SwiftUI
import ComposableArchitecture

struct PromptViewModifier: ViewModifier {
  
  let store: StoreOf<PromptModifierDomain>
  
  func body(content: Content) -> some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      ZStack {
        content
        VStack {
          if viewStore.showPrompt {
            PromptView(message: viewStore.message, style: viewStore.style)
              .frame(maxWidth: .infinity)
              .offset(y: viewStore.offset.height)
              .transition(.move(edge: .top).animation(UI.ViewAnimations.prompt))
              .gesture(
                DragGesture()
                  .onChanged({ value in
                    if value.translation.height < .zero {
                      viewStore.send(.offsetChanged(value.translation))
                    }
                  })
                  .onEnded({ value in
                    if value.translation.height < .zero {
                      withAnimation {
                        viewStore.send(.offsetChanged(.zero))
                        viewStore.send(.showPrompt(
                          message: viewStore.message,
                          style: viewStore.style,
                          show: false
                        ))
                      }
                    }
                })
            )
         }
          Spacer()
        }
        .animation(UI.ViewAnimations.prompt, value: viewStore.showPrompt)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
      }
    }
  }
  
}

extension View {
  func showPrompt(store: StoreOf<PromptModifierDomain>) -> some View {
    modifier(PromptViewModifier(store: store))
  }
}

