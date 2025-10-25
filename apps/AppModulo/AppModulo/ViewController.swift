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
        let homeViewController = HomeViewController(nibName: "HomeView", bundle: nil)
        let navigationController = UINavigationController(rootViewController: homeViewController)
        navigationController.modalPresentationStyle = .fullScreen
        navigationController.modalTransitionStyle = .flipHorizontal
        navigationController.navigationBar.prefersLargeTitles = true
        present(navigationController, animated: true)
    }

}

