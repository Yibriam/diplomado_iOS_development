//
//  ViewController.swift
//  calculadoraIMC
//
//  Created by Yibriam on 24/10/25.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var heightField: UITextField!
    @IBOutlet weak var weightField: UITextField!
    @IBOutlet weak var calculateIMC: UIButton!

    var resultText: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Initial setup
        calculateIMC.isEnabled = false
        heightField.delegate = self
        heightField.keyboardType = .decimalPad
        weightField.delegate = self
        weightField.keyboardType = .decimalPad
        heightField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        weightField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let allowedCharacters = ".0123456789"
        let allowedCharacterSet = CharacterSet(charactersIn: allowedCharacters)
        let typedCharacterSet = CharacterSet(charactersIn: string)
        
        return allowedCharacterSet.isSuperset(of: typedCharacterSet)
    }

    @objc private func textFieldDidChange(_ sender: UITextField) {
        let isHeightFieldEmpty = heightField.text?.isEmpty ?? true
        let isWeightFieldEmpty = weightField.text?.isEmpty ?? true
        calculateIMC.isEnabled = !isHeightFieldEmpty && !isWeightFieldEmpty
    }

    @IBAction func calculateButtonTapped(_ sender: UIButton) {
        performCalculation()
        performSegue(withIdentifier: "showResultSegue", sender: self)
    }

    func performCalculation() {
        guard let heightText = heightField.text,
              let weightText = weightField.text,
              let height = Double(heightText),
              let weight = Double(weightText),
              height > 0 else {
            resultText = "Invalid input"
            return
        }

        let imc = weight / (height * height)
        var category = ""

        switch imc {
        case ..<18.5:
            category = "Bajo Peso"
        case 18.5..<24.9:
            category = "Normal"
        case 25..<29.9:
            category = "Sobrepeso"
        case 30..<34.9:
            category = "Obesidad I"
        case 35..<39.9:
            category = "Obesidad II"
        case 40..<49.9:
            category = "Obesidad III"
        default:
            category = "Obesity IV"
        }

        resultText = String(format: "IMC: %.2f (%@)", imc, category)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showResultSegue",
           let destinationVC = segue.destination as? ViewControllerResult {
            destinationVC.IMCResult = resultText
        }
    }
}


