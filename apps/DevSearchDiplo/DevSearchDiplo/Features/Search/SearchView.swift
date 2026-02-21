//
//  DevSearchView.swift
//  DevExplorer
//
//  Created by Fernando Gutiérrez on 18/02/26.
//

import SwiftUI

struct DevSearchView: View {
    @StateObject private var searchViewModel = SearchViewModel()
    
    var body: some View {
        ZStack {
            Color.viewBackground
                .ignoresSafeArea()
            
            VStack(spacing: 52) {
                VStack(spacing: 16) {
                    ZStack {
                        Circle().fill(.cardBackground)
                            .frame(width: 100, height: 100)
                        
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundStyle(.primaryColorBlue)
                    }
                    
                    VStack(spacing: 8) {
                        Text("Encuentra a alguien")
                            .font(.title).bold()
                        Text("Busca desarrolladores por su nombre de usuario")
                    }
                }
                                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Usuario")
                    TextField("Escribe el nombre de usuario aquí ...", text: $searchViewModel.searchText)
                        .padding()
                        .foregroundStyle(.secondaryText)
                        .background(
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .fill(.white)
                        )
                        .overlay {
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .stroke(.border, lineWidth: 1)
                        }
                }
                
                Button {
                    Task {
                        await searchViewModel.fetchUser()
                    }
                } label: {
                    Text("Buscar")
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.white).bold()
                        .background(
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .fill(searchViewModel.searchText.isEmpty ? .primaryColorBlue.opacity(0.3) : .primaryColorBlue)
                        )
                }
                .disabled(searchViewModel.searchText.isEmpty ? true : false)
            }
            .padding(.horizontal, 16)
        }
        .safeAreaInset(edge: .top) {
            HStack {
                Spacer()
                Button("Cerrar sesión") {
                    Task {
                        
                    }
                }
            }
            .padding(.horizontal, 16)
        }
    }
}

#Preview {
    DevSearchView()
}

