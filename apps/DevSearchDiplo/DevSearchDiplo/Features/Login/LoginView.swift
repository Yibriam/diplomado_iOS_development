//
//  LoginView.swift
//  DevSearchDiplo
//
//  Created by alumno on 20/02/26.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    
    var body: some View {
        ZStack {
            Color.viewBackground
                .ignoresSafeArea()
            
            VStack(spacing: 32) {
                VStack(spacing: 16) {
                    Image("stars")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    
                    Text("Bienvenido")
                        .font(.title).bold()
                    Text("Ingresa tus datos para continuar")
                }
                
                VStack(spacing: 16) {
                    VStack(alignment: .leading) {
                        Text("Usuario")
                        TextField("Ingresa el usuario", text: $viewModel.userText)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 16, style: .continuous)
                                    .fill(.white)
                            )
                            .overlay {
                                RoundedRectangle(cornerRadius: 16, style: .continuous)
                                    .stroke(.border,lineWidth: 1)
                            }
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Contraseña")
                        TextField("Ingresa la contraseña", text: $viewModel.passwordText)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 16, style: .continuous)
                                    .fill(.white)
                            )
                            .overlay {
                                RoundedRectangle(cornerRadius: 16, style: .continuous)
                                    .stroke(.border,lineWidth: 1)
                            }
                    }
                }
                
                
                Button {
                    Task {
                        await viewModel.login()
                    }
                } label: {
                    Text("Iniciar sesión")
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.white)
                        .background(
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .fill(viewModel.isValidFields ? .primaryColorBlue : .primaryColorBlue.opacity(0.3))
                        )
                }
                .disabled(viewModel.isValidFields ? false : true)
            }
            .padding(.horizontal, 16)
        }
    }
}

#Preview {
    LoginView()
}
