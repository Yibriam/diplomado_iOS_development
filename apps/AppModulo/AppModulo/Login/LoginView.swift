//
//  LoginView.swift
//  FakestagramShare
//
//  Created by alberto on 08/11/25.
//

import UIKit

class LoginView: UIView {

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Login"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 40, weight: .bold)
        return label
    }()
    
    private lazy var userLabel: UILabel = {
        let label = UILabel()
        label.text = "User"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Password"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var userTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "email"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var loginButton: UIButton = {
        let loginButton = UIButton()
        loginButton.setTitle("Log in", for: .normal)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        var configuration = UIButton.Configuration.filled()
        configuration.background.backgroundColor = .accent
        configuration.baseForegroundColor = .systemBackground
        loginButton.configuration = configuration
        return loginButton
    }()
    
    private lazy var formContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(titleLabel)
        addSubview(formContainer)
        formContainer.addSubview(userLabel)
        formContainer.addSubview(passwordLabel)
        formContainer.addSubview(userTextField)
        formContainer.addSubview(passwordTextField)
        formContainer.addSubview(loginButton)
        setTitleLabelConstraints()
        setUserLabelConstraints()
        setUserTextFieldConstraints()
        setPasswordLabelConstraints()
        setPasswordFieldConstraints()
        setFormContainerConstraints()
        setButtonConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 32),
            titleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -32),
            titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: formContainer.topAnchor, constant: -8)
            
        ])
    }
    
    private func setUserLabelConstraints() {
        NSLayoutConstraint.activate([
            userLabel.topAnchor.constraint(equalTo: formContainer.topAnchor),
            userLabel.leadingAnchor.constraint(equalTo: formContainer.leadingAnchor),
            userLabel.trailingAnchor.constraint(equalTo: formContainer.trailingAnchor),
            userLabel.bottomAnchor.constraint(equalTo: userTextField.topAnchor, constant: -8)
        ])
    }
    
    private func setUserTextFieldConstraints() {
        NSLayoutConstraint.activate([
            userTextField.leadingAnchor.constraint(equalTo: userLabel.leadingAnchor),
            userTextField.trailingAnchor.constraint(equalTo: userLabel.trailingAnchor),
            userTextField.bottomAnchor.constraint(equalTo: passwordLabel.topAnchor, constant: -16)
        ])
    }
    
    private func setPasswordLabelConstraints() {
        NSLayoutConstraint.activate([
            passwordLabel.leadingAnchor.constraint(equalTo: userLabel.leadingAnchor),
            passwordLabel.trailingAnchor.constraint(equalTo: userLabel.trailingAnchor),
            passwordLabel.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: -8)
        ])
    }
    
    private func setPasswordFieldConstraints() {
        NSLayoutConstraint.activate([
            passwordTextField.leadingAnchor.constraint(equalTo: userLabel.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: userLabel.trailingAnchor),
            passwordTextField.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: -32)
        ])
    }
    
    private func setButtonConstraints() {
        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: formContainer.centerXAnchor),
            loginButton.widthAnchor.constraint(equalTo: formContainer.widthAnchor, multiplier: 0.5),
            loginButton.bottomAnchor.constraint(equalTo: formContainer.bottomAnchor)
        ])
    }
    
    private func setFormContainerConstraints() {
        formContainer.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        formContainer.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        let yCenterAnchor = formContainer.centerYAnchor.constraint(equalTo: centerYAnchor)
        yCenterAnchor.priority = .defaultLow
        yCenterAnchor.isActive = true
    }
    
}
