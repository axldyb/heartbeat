//
//  ViewStyling.swift
//  Heartbeat
//
//  Created by Aksel Dybdal on 24/02/2022.
//

import SwiftUI

struct TitleModifier: ViewModifier {

    func body(content: Content) -> some View {
        content
            .font(.custom("Arial", size: 40))
            .foregroundColor(.black)
    }
}

struct BlueButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}
