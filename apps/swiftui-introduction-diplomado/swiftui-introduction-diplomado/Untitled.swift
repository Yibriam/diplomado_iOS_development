//
//  Untitled.swift
//  swiftui-introduction-diplomado
//
//  Created by Alejandro Mendoza on 31/01/26.
//


import SwiftUI

struct EnvironmentExample: View {
    @Environment(\.dynamicTypeSize) private var typeSize
    var body: some View {
        VStack {
            if typeSize.isAccessibilitySize {
                Text("accessibility font size")
            } else {
                Text("other size")
            }
            
            HStack {
                Text("hello")
                Text("world")
            }
            .font(.headline)
            
            Text("this is another text")
        }
    }
}

#Preview {
    EnvironmentExample()
}
