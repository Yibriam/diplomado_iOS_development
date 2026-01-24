//
//  BranchListViewController.swift
//  donBigotes
//
//  Created by Yibriam on 23/01/26.
//

import UIKit

class BranchListViewController: UITableViewController {
    private let branches: [Branch]
    
    init(branches: [Branch]) {
        self.branches = branches
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) { fatalError() }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sucursales"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "branchCell")
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return branches.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "branchCell")
        let branch = branches[indexPath.row]
        cell.textLabel?.text = branch.name
        cell.detailTextLabel?.text = branch.address
        cell.detailTextLabel?.textColor = .secondaryLabel
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = BranchDetailViewController(branch: branches[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
}
