//
//  ViewController.swift
//  TableView
//
//  Created by Yibriam on 15/11/25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var button2: UIButton!
    
    var array: [String] = ["Manuel","Grecia","Alejandro"]
    var secondArray: [String] = ["Sanchez","Escarcega","Mendoza","Ramirez","Perez"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
//                tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        guard let newItem = textField.text, !newItem.isEmpty else {return}
        array.append(newItem)
        tableView.reloadData()
        print(array)
    }
    
    @IBAction func sortButton(_ sender: Any) {
        tableView.isEditing.toggle()
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            print(array[indexPath.row])
        } else {
            print(secondArray[indexPath.row])
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            array.count
        } else {
            secondArray.count
        }
        
    }
    
    //    Personalized cell
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomTableViewCell
        
        if indexPath.section == 0 {
            cell.customName.text = array[indexPath.row]
        } else {
            cell.customName.text = secondArray[indexPath.row]
        }
        
//        cell.customName.text = array[indexPath.row]
        
//        Simple cell reusable
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
//        Simple cell no reusable
//        var cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
//
//        Modern version
//
//        var content = cell.defaultContentConfiguration()
//        content.text = array[indexPath.row]
//        content.text = "Holi"
//        content.secondaryText = "Holi"
//        cell.contentConfiguration = content
//
//        cell.textLabel?.text = "Holi"
//        cell.detailTextLabel?.text = "Holi"
//        cell.backgroundColor = .lightGray
//        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    
}


extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        array.swapAt(sourceIndexPath.row, destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        "Delete"
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            array.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Nombre"
        } else {
            return "Apellido"
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
}
