//
//  ViewController.swift
//  rockPaperScissors
//
//  Created by Yibriam on 14/11/25.
//

import UIKit

class ConfigurationViewController: UIViewController {
    
    var configView: ConfigurationView {
        return view as! ConfigurationView
    }
    
    override func loadView() {
        view = ConfigurationView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Actions
        configView.gameTypeSegmentedControl.addTarget(self, action: #selector(gameTypeChanged), for: .valueChanged)
        configView.continueButton.addTarget(self, action: #selector(continueTapped), for: .touchUpInside)
        configView.informationButton.addTarget(self, action: #selector(informationTapped), for: .touchUpInside)
        
        // Text field validation
        [configView.playersNameTextField,
         configView.winsTextField,
         configView.losesTextField,
         configView.scoreToWinTextField].forEach {
            $0.addTarget(self, action: #selector(validateForm), for: .editingChanged)
        }
    }
    
    @objc private func gameTypeChanged() {
        configView.toggleGameModeUI()
        validateForm()
    }
    
    @objc private func validateForm() {
        let nameValid = !(configView.playersNameTextField.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true)
        
        if configView.gameTypeSegmentedControl.selectedSegmentIndex == 0 {
            // Rounds mode: only name required
            configView.continueButton.isHidden = !nameValid
        } else {
            // Points mode: all fields required
            let winsValid = !(configView.winsTextField.text?.isEmpty ?? true)
            let losesValid = !(configView.losesTextField.text?.isEmpty ?? true)
            let scoreValid = !(configView.scoreToWinTextField.text?.isEmpty ?? true)
            configView.continueButton.isHidden = !(nameValid && winsValid && losesValid && scoreValid)
        }
    }

    
    @objc private func continueTapped() {
        // If button is hidden, do nothing
        guard !configView.continueButton.isHidden else { return }
        
        let gameVC = GameScreenViewController()
        gameVC.playerName = configView.playersNameTextField.text ?? "Player"
        
        if configView.gameTypeSegmentedControl.selectedSegmentIndex == 0 {
            gameVC.isPointsMode = false
            gameVC.targetWins = Int(configView.winsSlider.value.rounded())
        } else {
            gameVC.isPointsMode = true
            gameVC.winValue = Int(configView.winsTextField.text ?? "0") ?? 0
            gameVC.loseValue = Int(configView.losesTextField.text ?? "0") ?? 0
            gameVC.requiredScore = Int(configView.scoreToWinTextField.text ?? "0") ?? 0
        }
        
        present(gameVC, animated: true)
    }


    
    @objc private func informationTapped() {
        let infoVC = InformationViewController(nibName: "InformationView", bundle: nil)
        present(infoVC, animated: true)
    }
    
}


