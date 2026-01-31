//
//  AuthenticationViewModel.swift
//  diaryApp
//
//  Created by Yibriam on 30/01/26.
//

import UIKit
import LocalAuthentication

class AuthenticationViewModel {
    func authenticate(completion: @escaping (Bool) -> Void) {
        let context = LAContext()
        context.localizedCancelTitle = "Cancel"
        
        var error: NSError?
        
        let policy: LAPolicy = context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
            ? .deviceOwnerAuthenticationWithBiometrics
            : .deviceOwnerAuthentication
        
        if context.canEvaluatePolicy(policy, error: &error) {
            context.evaluatePolicy(policy, localizedReason: "Unlock Diary") { success, evalError in
                DispatchQueue.main.async {
                    if success {
                        completion(true)
                    } else {
                        if let evalError = evalError {
                            print("Authentication failed: \(evalError.localizedDescription)")
                        }
                        completion(false)
                    }
                }
            }
        } else {
            completion(false)
        }
    }
}
