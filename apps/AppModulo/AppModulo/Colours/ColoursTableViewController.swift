//
//  ColourTableViewController.swift
//  FakestagramShare
//
//  Created by alberto on 29/11/25.
//

import UIKit

class ColoursTableViewController: UITableViewController {
    
    private let model = ColoursModel(repository: ColoursLocalRepository(), imageDownloader: LocalImageDownloader())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(ColourCell.self, forCellReuseIdentifier: ColourCell.identifier)
        tableView.allowsSelection = false
        tableView.isPrefetchingEnabled = false
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ColourCell.identifier, for: indexPath) as? ColourCell else { return UITableViewCell() }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.frame.width
    }
    
}
