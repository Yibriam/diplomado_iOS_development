//
//  CurrencyConversionViewController.swift
//  countryInformation
//
//  Created by Yibriam on 05/12/25.
//

import UIKit

final class CurrencyConversionViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    private let basePicker = UIPickerView()
    private let targetPicker = UIPickerView()
    private let arrowImageView = UIImageView()
    private let amountField = UITextField()
    private let convertButton = UIButton(type: .system)
    private let resultLabel = UILabel()

    private var currencies: [String] = [] // e.g., ["USD","CAD","MXN",...]
    private var baseCode: String = "USD"
    private var targetCode: String = "MXN"

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        loadCurrencies()
        updateArrow()
    }

    private func loadCurrencies() {
        // From Currency.json: "moneda": "Dólar estadounidense (USD)" -> extract codes in parentheses
        let all = DataProvider.shared.currencyByCountry.values
        var setCodes: Set<String> = []
        for c in all {
            if let code = extractCode(from: c.moneda) {
                setCodes.insert(code)
            }
        }
        currencies = Array(setCodes).sorted()
        basePicker.reloadAllComponents()
        targetPicker.reloadAllComponents()
        if let bIdx = currencies.firstIndex(of: baseCode) {
            basePicker.selectRow(bIdx, inComponent: 0, animated: false)
        }
        if let tIdx = currencies.firstIndex(of: targetCode) {
            targetPicker.selectRow(tIdx, inComponent: 0, animated: false)
        }
    }

    private func extractCode(from moneda: String) -> String? {
        // Find "(XXX)" pattern
        guard let start = moneda.lastIndex(of: "("),
              let end = moneda.lastIndex(of: ")"),
              start < end else { return nil }
        let code = moneda[moneda.index(after: start)..<end]
        return String(code)
    }

    private func setupUI() {
        basePicker.dataSource = self
        basePicker.delegate = self
        targetPicker.dataSource = self
        targetPicker.delegate = self

        arrowImageView.contentMode = .scaleAspectFit
        arrowImageView.tintColor = .systemBlue

        amountField.placeholder = "Cantidad"
        amountField.borderStyle = .roundedRect
        amountField.keyboardType = .decimalPad
        amountField.delegate = self

        convertButton.setTitle("Convertir", for: .normal)
        convertButton.addTarget(self, action: #selector(convert), for: .touchUpInside)

        resultLabel.textAlignment = .center
        resultLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        resultLabel.numberOfLines = 2

        let pickersStack = UIStackView(arrangedSubviews: [basePicker, arrowImageView, targetPicker])
        pickersStack.axis = .horizontal
        pickersStack.spacing = 8
        pickersStack.distribution = .fillEqually

        let controlsStack = UIStackView(arrangedSubviews: [amountField, convertButton, resultLabel])
        controlsStack.axis = .vertical
        controlsStack.spacing = 12

        pickersStack.translatesAutoresizingMaskIntoConstraints = false
        controlsStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pickersStack)
        view.addSubview(controlsStack)

        NSLayoutConstraint.activate([
            pickersStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            pickersStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            pickersStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            pickersStack.heightAnchor.constraint(equalToConstant: 180),

            controlsStack.topAnchor.constraint(equalTo: pickersStack.bottomAnchor, constant: 16),
            controlsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            controlsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
        ])
    }

    private func updateArrow() {
        // Show > if base->target, and < if target->base (tie to selected?)
        // As per requirement, show direction indicator for conversion direction (base -> target)
        arrowImageView.image = UIImage(systemName: "chevron.right")
    }

    // MARK: picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int { 1 }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int { currencies.count }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? { currencies[row] }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let code = currencies[row]
        if pickerView === basePicker {
            baseCode = code
        } else {
            targetCode = code
        }
        updateArrow()
    }

    // MARK: conversion
    @objc private func convert() {
        let text = amountField.text ?? ""
        let value = Double(text) ?? 0
        let nonNegative = max(0, value) // Can't display negative numbers

        guard let rate = rate(from: baseCode, to: targetCode) else {
            resultLabel.text = "No hay tasa para \(baseCode) → \(targetCode)"
            return
        }
        let converted = nonNegative * rate
        resultLabel.text = "\(String(format: "%.4f", nonNegative)) \(baseCode) → \(String(format: "%.4f", converted)) \(targetCode)"
    }

    private func rate(from base: String, to target: String) -> Double? {
        // Try direct; if missing, try invert if available
        if let direct = DataProvider.shared.rates[base]?[target] {
            return direct
        } else if let inverse = DataProvider.shared.rates[target]?[base], inverse != 0 {
            return 1.0 / inverse
        } else {
            return nil
        }
    }

    // MARK: input
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Allow digits and one dot, prevent minus sign
        let allowed = CharacterSet(charactersIn: "0123456789.")
        return string.rangeOfCharacter(from: allowed.inverted) == nil
    }
}
