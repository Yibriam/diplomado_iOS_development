//
//  ViewController.swift
//  Constrains
//
//  Created by Manuel Sánchez on 22/09/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var userField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!

    private let correctUsername = "Diplomado2024"
    private let correctPassword = "Yibriam_October"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.isEnabled = false
        userField.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: .editingChanged)
        passwordField.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: .editingChanged)
        }

    @objc private func textFieldDidChange( sender: UITextField) {
        let isUserFieldEmpty = userField.text?.isEmpty ?? true
        let isPasswordFieldEmpty = passwordField.text?.isEmpty ?? true
        
        loginButton.isEnabled = !isUserFieldEmpty && !isPasswordFieldEmpty
    }

    @IBAction func loginButtonTapped(_ sender: UIButton) {
        if userField.text == correctUsername && passwordField.text == correctPassword {
            logIn()
        } else {
            showErrorAlert()
        }
    }
    private func logIn() {
        performSegue(withIdentifier: "LoginHomeSegue", sender: nil)
    }
    
    private func showErrorAlert() {
        let alert = UIAlertController(title: "Error", message: "Los datos son incorrectos.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        present(alert, animated: true)
    }

}

