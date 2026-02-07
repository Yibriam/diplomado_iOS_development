//
//  CircleImage.swift
//  swiftui-introduction-diplomado
//
//  Created by Alejandro Mendoza on 31/01/26.
//

import SwiftUI

struct CircleImage: View {
    @Environment(\.pokemonSoundAction) private var pokemonSoundAction
    
    var body: some View {
        Image("pikachu")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 200, height: 200)
            .clipShape(Circle())
            .overlay {
                Circle()
                    .stroke(Color.red,
                            lineWidth: 5)
            }
            .shadow(radius: 5)
            .onTapGesture {
                pokemonSoundAction?()
            }
    }
}

#Preview {
    CircleImage()
}
