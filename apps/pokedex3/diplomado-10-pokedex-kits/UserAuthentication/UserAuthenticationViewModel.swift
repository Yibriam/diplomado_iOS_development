//
//  UserAuthenticationViewModel.swift
//  diplomado-10-pokedex-kits
//
//  Created by Yibriam on 30/01/26.
//

import UIKit
import LocalAuthentication

protocol UserAuthenticationViewModelDelegate: AnyObject {
    func authenticationDidSucceed()
    func authenticationDidFail(with error: String)
}

class UserAuthenticationViewModel {
    
    weak var delegate: UserAuthenticationViewModelDelegate?
    
    func authenticateUser() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identify to view pokemon"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                   localizedReason: reason) { [weak self] success, evalError in
                
                DispatchQueue.main.async {
                    if success {
                        self?.delegate?.authenticationDidSucceed()
                    } else {
                        let errorMessage = evalError?.localizedDescription ?? "Authentication failed."
                        self?.delegate?.authenticationDidFail(with: errorMessage)
                    }
                }
            }
        } else {
            let errorMessage = error?.localizedDescription ?? "Biometrics not available on this device."
            self.delegate?.authenticationDidFail(with: errorMessage)
        }
    }
}
