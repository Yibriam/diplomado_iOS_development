//
//  LoginViewModel.swift
//  DevSearchDiplo
//
//  Created by alumno on 20/02/26.
//

import Foundation
import Combine

@MainActor
final class LoginViewModel: ObservableObject {
    @Published var userText = "" {
        didSet { validateFields() }
    }
    @Published var passwordText = "" {
        didSet { validateFields() }
    }
    @Published private(set) var isValidFields = false
    
    private var loginService = LoginService()
    
    func login() async {
        let user = LoginModel(user: userText, password: passwordText)
        let response = await loginService.fetchUser(with: user)
        print(response)
    }
    
    func validateFields() {
        isValidFields = !userText.isEmpty && !passwordText.isEmpty
    }
}
