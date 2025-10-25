//
//  ViewController.swift
//  encuestaPreferencias
//
//  Created by Yibriam on 24/10/25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var foodChoice: UISegmentedControl!
    @IBOutlet weak var soccerSwitch: UISwitch!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sendButton: UIButton!

    var foodOption: String?
    var soccerValue: Bool?
    var leisureText: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        InitSegment()
        foodChoice.addTarget(self, action: #selector(validateInputs), for: .valueChanged)
        textField.addTarget(self, action: #selector(validateInputs), for: .editingChanged)
    }

    private func InitSegment() {
        sendButton.isEnabled = false
        foodChoice.selectedSegmentIndex = UISegmentedControl.noSegment
        
    }
    
    @objc private func validateInputs() {
        let isFoodSelected = foodChoice.selectedSegmentIndex != UISegmentedControl.noSegment
        
        let isActivityFill = !(textField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true)
        
        sendButton.isEnabled = isFoodSelected && isActivityFill
    }

    func showResults() {
        guard let text = textField.text else {
            leisureText = "Invalid input"
            return
        }

        let selectedIndex = foodChoice.selectedSegmentIndex
        switch selectedIndex {
        case 0: foodOption = "Pizza"
        case 1: foodOption = "Sushi"
        case 2: foodOption = "Ensalada"
        case 3: foodOption = "Hamburguesa"
        default: foodOption = "Pizza"
        }
        
        soccerValue = soccerSwitch.isOn ? true : false
        leisureText = text
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showResultSegue",
           let destinationVC = segue.destination as? ViewControllerResult {
            showResults()
            destinationVC.foodResult = foodOption
            destinationVC.soccerResult = soccerValue
            destinationVC.leisureResult = leisureText
        }
    }
    
    @IBAction func sendButtonTapped(_ sender: UIButton) {
        showResults()
        performSegue(withIdentifier: "showResultSegue", sender: self)
    }
    
}


