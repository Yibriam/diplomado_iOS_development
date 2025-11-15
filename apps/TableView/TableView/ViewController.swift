//
//  ViewController.swift
//  TableView
//
//  Created by Yibriam on 15/11/25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var array: [String] = ["Manuel","Grecia","Alejandro"]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        // Do any additional setup after loading the view.
    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        Simple cell reusable
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
//        Simple cell no reusable
//        var cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        
//        Modern version
        
        var content = cell.defaultContentConfiguration()
        content.text = array[indexPath.row]
//        content.text = "Holi"
        content.secondaryText = "Holi"
        cell.contentConfiguration = content
        
//        cell.textLabel?.text = "Holi"
//        cell.detailTextLabel?.text = "Holi"
//        cell.backgroundColor = .lightGray
//        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    
}
