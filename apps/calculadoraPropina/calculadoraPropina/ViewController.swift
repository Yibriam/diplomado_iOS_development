//
//  ViewController.swift
//  calculadoraPropina
//
//  Created by Yibriam on 24/10/25.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var tipField: UITextField!
    @IBOutlet weak var tipPercentage: UISegmentedControl!
    @IBOutlet weak var tipCalculate: UIButton!

    var resultText: String? // Store the result to pass to the next view controller

    override func viewDidLoad() {
        super.viewDidLoad()

        // Initial setup
        tipCalculate.isEnabled = false
        tipField.delegate = self
        tipField.keyboardType = .decimalPad
        tipField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        tipPercentage.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let allowedCharacters = ".0123456789"
        let allowedCharacterSet = CharacterSet(charactersIn: allowedCharacters)
        let typedCharacterSet = CharacterSet(charactersIn: string)
        
        return allowedCharacterSet.isSuperset(of: typedCharacterSet)
    }

    @objc private func textFieldDidChange(_ sender: UITextField) {
        let isTipFieldEmpty = tipField.text?.isEmpty ?? true
        tipCalculate.isEnabled = !isTipFieldEmpty
    }

    @objc private func segmentChanged(_ sender: UISegmentedControl) {
        // Optional: live update
    }

    @IBAction func calculateButtonTapped(_ sender: UIButton) {
        performCalculation()
        performSegue(withIdentifier: "showResultSegue", sender: self)
    }

    func performCalculation() {
        guard let text = tipField.text, let billAmount = Double(text) else {
            resultText = "Invalid input"
            return
        }

        let selectedIndex = tipPercentage.selectedSegmentIndex
        let tipMultiplier: Double

        switch selectedIndex {
        case 0: tipMultiplier = 0.10
        case 1: tipMultiplier = 0.15
        case 2: tipMultiplier = 0.20
        default: tipMultiplier = 0.10
        }

        let tipAmount = billAmount * tipMultiplier
        let totalAmount = billAmount + tipAmount

        resultText = String(format: "Tip: %.2f | Total: %.2f", tipAmount, totalAmount)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showResultSegue",
           let destinationVC = segue.destination as? ViewControllerResult {
            destinationVC.tipResult = resultText
        }
    }
}
