//
//  loginView.swift
//  devSearch
//
//  Created by Yibriam on 20/02/26.
//

import SwiftUI

struct loginView: View {
    @State var userText = ""
    var body: some View {
        ZStack {
            Color.viewBackground
                .ignoresSafeArea()
            VStack (spacing: 32) {
                VStack(spacing: 16) {
                    Image("stars")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    
                    Text("Bienvenidos")
                        .font(.title)
                        .bold()
                    Text("Ingresa tus datos para continuar")
                }
                VStack (alignment: .leading) {
                    Text("Usuario")
                    TextField("Ingresa el usuario", text: $userText)
                        .padding()
                        .background(RoundedRectangle (cornerRadius: 16, style: .continuous)
                            .fill(.white))
                }
                .padding(.horizontal, 16)
            }
        }
    }
}

#Preview {
    loginView()
}
