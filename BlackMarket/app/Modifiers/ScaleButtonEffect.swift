//
//  ScaleButtonEffect.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 11/01/2023.
//

import Foundation
import SwiftUI

struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
        .scaleEffect(configuration.isPressed ? 0.97 : 1)
    }
}
