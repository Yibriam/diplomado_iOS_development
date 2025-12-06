//
//  LoginViewController.swift
//  FakestagramShare
//
//  Created by alberto on 11/10/25.
//

import UIKit

final class LoginViewController: UIViewController {
    
    let model = LoginModel(repository: UserLocalRepository())
    
    var customView: LoginView {
        return view as! LoginView
    }
    
    override func loadView() {
        view = LoginView()
        customView.loginButton.addAction(UIAction(handler: loginButtonTapped(_:)), for: .touchUpInside)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func loginButtonTapped(_ action: UIAction) {
        print("user: ", customView.userTextField.text)
        print("password: ", customView.passwordTextField.text)
        doLogin()
    }
    
    private func doLogin() {
        model.findUser(by: customView.userTextField.text ?? "") { [weak self] error in
            DispatchQueue.main.async {
                if let error {
                    // Presentar una alerta
                    self?.presentErrorAlert(title: "Error", message: error.localizedDescription)
                } else {
                    self?.setMainView()
                }
            }
        }
    }
    
    private func logIn() {
        let homeViewController = HomeViewController(nibName: "HomeView", bundle: nil)
        let navigationController = UINavigationController(rootViewController: homeViewController)
        navigationController.modalPresentationStyle = .fullScreen
        navigationController.modalTransitionStyle = .flipHorizontal
        navigationController.navigationBar.prefersLargeTitles = true
        present(navigationController, animated: true)
    }
    
    private func setMainView() {
            let homeViewController = HomeViewController()
            
            let coloursViewController = ColoursTableViewController()
            coloursViewController.tabBarItem = UITabBarItem(title: "Colours", image: UIImage(systemName: "star"), tag: 2)
            
            let navigationController = UINavigationController(rootViewController: homeViewController)
            navigationController.navigationBar.prefersLargeTitles = true
            navigationController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 1)
            
            let tabBarController = UITabBarController()
            tabBarController.viewControllers = [navigationController, coloursViewController]
            tabBarController.modalPresentationStyle = .fullScreen
            tabBarController.modalTransitionStyle = .flipHorizontal
            present(tabBarController, animated: true)
        }

}

