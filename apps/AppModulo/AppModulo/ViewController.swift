//
//  ViewController.swift
//  AppModulo
//
//  Created by Yibriam on 11/10/25.
//

import UIKit

final class LoginViewController: UIViewController {
    
    @IBOutlet weak var userField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        print("user: ", userField.text)
        print("password: ", passwordField.text)
        logIn()
    }
    
    private func logIn() {
        let navigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BaseNavigationController")
        navigationController.modalPresentationStyle = .fullScreen
        navigationController.modalTransitionStyle = .flipHorizontal
        present(navigationController, animated: true)
    }

}

