//
//  ShopViewController.swift
//  shoppingApp
//
//  Created by Yibriam on 07/11/25.
//

import UIKit

class ShopViewController: UIViewController {

    @IBOutlet weak var carrot: UIButton!
    @IBOutlet weak var bread: UIButton!
    @IBOutlet weak var tomato: UIButton!
    @IBOutlet weak var paper: UIButton!
    @IBOutlet weak var cereal: UIButton!
    @IBOutlet weak var eggs: UIButton!
    @IBOutlet weak var milk: UIButton!
    @IBOutlet weak var cheese: UIButton!
    @IBOutlet weak var lettuce: UIButton!
    @IBOutlet weak var potato: UIButton!
    @IBOutlet weak var goShoppingButton: UIButton!

    var selectedItems: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
    }

    func setupButtons() {
        let buttons = [carrot, bread, tomato, paper, cereal, eggs, milk, cheese, lettuce, potato]
        let names = ["Carrot", "Bread", "Tomato", "Paper", "Cereal", "Eggs", "Milk", "Cheese", "Lettuce", "Potato"]

        for (index, button) in buttons.enumerated() {
            button?.tag = index
            button?.setTitle(names[index], for: .normal)
            button?.backgroundColor = .systemBlue
            button?.setImage(UIImage(named: names[index].lowercased()), for: .normal)
            button?.addTarget(self, action: #selector(toggleSelection(_:)), for: .touchUpInside)
        }

        goShoppingButton.addTarget(self, action: #selector(goShopping), for: .touchUpInside)
    }

    @objc func toggleSelection(_ sender: UIButton) {
        let itemName = sender.title(for: .normal) ?? ""

        if selectedItems.contains(itemName) {
            selectedItems.removeAll { $0 == itemName }
            sender.backgroundColor = .systemBlue
            sender.setImage(UIImage(named: itemName.lowercased()) ?? UIImage(systemName: "cart"), for: .normal)
        } else {
            selectedItems.append(itemName)
            sender.backgroundColor = .systemGreen
            sender.setImage(UIImage(systemName: "checkmark"), for: .normal)
        }
    }

    @objc func goShopping() {
        let listVC = ListViewController()
        listVC.selectedItems = selectedItems
        present(listVC, animated: true)
    }
}

