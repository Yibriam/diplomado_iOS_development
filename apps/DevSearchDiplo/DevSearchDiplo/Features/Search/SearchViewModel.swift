//
//  SearchViewModel.swift
//  DevSearchDiplo
//
//  Created by alumno on 20/02/26.
//

import Foundation
import Combine

@MainActor
final class SearchViewModel: ObservableObject {
    @Published var searchText: String = ""
    var errorMessage: String?
    
    func fetchUser() async {
        do {
            let response = try await UserService().getUser(user: searchText)
            if let response {
                print(response)
            }
        } catch {
            errorMessage = "Error al obtener al usuario"
        }
    }
}
