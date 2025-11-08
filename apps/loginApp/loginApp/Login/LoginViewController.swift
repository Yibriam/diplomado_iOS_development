//
//  LoginViewController.swift
//  loginApp
//
//  Created by Yibriam on 07/11/25.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var user2Field: UITextField!
    @IBOutlet weak var password2Field: UITextField!
    @IBOutlet weak var login2Button: UIButton!
    
    private let correctUsername = "Diplomado2024"
    private let correctPassword = "Yibriam_October"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        login2Button.isEnabled = false
        user2Field.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: .editingChanged)
        password2Field.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: .editingChanged)
    }

    @objc private func textFieldDidChange( sender: UITextField) {
        let isUserFieldEmpty = user2Field.text?.isEmpty ?? true
        let isPasswordFieldEmpty = password2Field.text?.isEmpty ?? true
        
        login2Button.isEnabled = !isUserFieldEmpty && !isPasswordFieldEmpty
    }

    @IBAction func loginButtonTapped(_ sender: UIButton) {
        if user2Field.text == correctUsername && password2Field.text == correctPassword {
            logIn()
        } else {
            showErrorAlert()
        }
    }
    private func logIn() {
        navigateToInformationViewController()
    }
    
    private func navigateToInformationViewController() {
        let welcomeViewController = WelcomeViewController(nibName: "WelcomeViewController", bundle: nil)
        let navigationController = UINavigationController(rootViewController: welcomeViewController)
        navigationController.modalPresentationStyle = .fullScreen
        navigationController.modalTransitionStyle = .flipHorizontal
        navigationController.navigationBar.prefersLargeTitles = true
        present(navigationController, animated: true)
    }
    
    private func showErrorAlert() {
        let alert = UIAlertController(title: "Error", message: "Los datos son incorrectos.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        present(alert, animated: true)
    }

}
