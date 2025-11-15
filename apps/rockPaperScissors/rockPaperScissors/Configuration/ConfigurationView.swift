//
//  Configuration.swift
//  rockPaperScissors
//
//  Created by Yibriam on 14/11/25.
//

import UIKit

class ConfigurationView: UIView {
    
    lazy var playersNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Player's name"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var gameTypeSegmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["Rounds", "Points"])
        control.selectedSegmentIndex = 0
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    lazy var winsSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 1
        slider.maximumValue = 5
        slider.value = 3
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        return slider
    }()

    @objc private func sliderValueChanged(_ sender: UISlider) {
        let currentValue = Int(sender.value.rounded())
        roundsValueLabel.text = "\(currentValue)"
    }

    
    lazy var roundsValueLabel: UILabel = {
        let label = UILabel()
        label.text = "3" // default value
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    lazy var winsTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Win Value"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var losesTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Lose Value"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var scoreToWinTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Required Score to Win"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Continue", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = .systemBlue
        configuration.baseForegroundColor = .white
        button.configuration = configuration
        button.isHidden = true
        return button
    }()
    
    lazy var informationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Information", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = .systemGray
        configuration.baseForegroundColor = .white
        button.configuration = configuration
        return button
    }()
    
    lazy var formContainer: UIView = {
        let view  = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        
        addSubview(formContainer)
        formContainer.addSubview(playersNameTextField)
        formContainer.addSubview(gameTypeSegmentedControl)
        formContainer.addSubview(winsSlider)
        formContainer.addSubview(roundsValueLabel)
        formContainer.addSubview(winsTextField)
        formContainer.addSubview(losesTextField)
        formContainer.addSubview(scoreToWinTextField)
        formContainer.addSubview(continueButton)
        formContainer.addSubview(informationButton)
        
        configurationConstraints()
        toggleGameModeUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configurationConstraints() {
        NSLayoutConstraint.activate([
            // Pin formContainer to safe area with margins
            formContainer.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            formContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            formContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            formContainer.bottomAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            // Player name
            playersNameTextField.topAnchor.constraint(equalTo: formContainer.topAnchor),
            playersNameTextField.leadingAnchor.constraint(equalTo: formContainer.leadingAnchor),
            playersNameTextField.trailingAnchor.constraint(equalTo: formContainer.trailingAnchor),
            
            // Segmented control
            gameTypeSegmentedControl.topAnchor.constraint(equalTo: playersNameTextField.bottomAnchor, constant: 20),
            gameTypeSegmentedControl.leadingAnchor.constraint(equalTo: formContainer.leadingAnchor),
            gameTypeSegmentedControl.trailingAnchor.constraint(equalTo: formContainer.trailingAnchor),
            
            // Slider (rounds mode)
            winsSlider.topAnchor.constraint(equalTo: gameTypeSegmentedControl.bottomAnchor, constant: 20),
            winsSlider.leadingAnchor.constraint(equalTo: formContainer.leadingAnchor),
            winsSlider.trailingAnchor.constraint(equalTo: formContainer.trailingAnchor),
            
            roundsValueLabel.topAnchor.constraint(equalTo: winsSlider.bottomAnchor, constant: 8),
            roundsValueLabel.centerXAnchor.constraint(equalTo: winsSlider.centerXAnchor),
            
            // Points mode fields
            winsTextField.topAnchor.constraint(equalTo: gameTypeSegmentedControl.bottomAnchor, constant: 90),
            winsTextField.leadingAnchor.constraint(equalTo: formContainer.leadingAnchor),
            winsTextField.trailingAnchor.constraint(equalTo: formContainer.trailingAnchor),
            
            losesTextField.topAnchor.constraint(equalTo: winsTextField.bottomAnchor, constant: 10),
            losesTextField.leadingAnchor.constraint(equalTo: formContainer.leadingAnchor),
            losesTextField.trailingAnchor.constraint(equalTo: formContainer.trailingAnchor),
            
            scoreToWinTextField.topAnchor.constraint(equalTo: losesTextField.bottomAnchor, constant: 10),
            scoreToWinTextField.leadingAnchor.constraint(equalTo: formContainer.leadingAnchor),
            scoreToWinTextField.trailingAnchor.constraint(equalTo: formContainer.trailingAnchor),
            
            // Continue button
            continueButton.topAnchor.constraint(equalTo: scoreToWinTextField.bottomAnchor, constant: 20),
            continueButton.centerXAnchor.constraint(equalTo: formContainer.centerXAnchor),
            
            // Information button
            informationButton.topAnchor.constraint(equalTo: continueButton.bottomAnchor, constant: 10),
            informationButton.centerXAnchor.constraint(equalTo: formContainer.centerXAnchor),
            informationButton.bottomAnchor.constraint(equalTo: formContainer.bottomAnchor)
        ])
    }

    
    func toggleGameModeUI() {
        if gameTypeSegmentedControl.selectedSegmentIndex == 0 {
            // Rounds mode
            winsSlider.isHidden = false
            winsTextField.isHidden = false
            losesTextField.isHidden = false
            scoreToWinTextField.isHidden = false
        } else {
            // Points mode
            winsSlider.isHidden = false
            winsTextField.isHidden = false
            losesTextField.isHidden = false
            scoreToWinTextField.isHidden = false
        }
    }
}
