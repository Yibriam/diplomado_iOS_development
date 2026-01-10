//
//  ColourTableViewController.swift
//  FakestagramShare
//
//  Created by alberto on 29/11/25.
//

import UIKit

class ColoursTableViewController: UITableViewController {
    
    private let model = ColoursModel(repository: ColoursRemoteRepository(), imageDownloader: RemoteImageDownloader())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(ColourCell.self, forCellReuseIdentifier: ColourCell.identifier)
        tableView.allowsSelection = false
        tableView.isPrefetchingEnabled = false
        Task {
            await loadData()
        }
    }
    
    func loadData() {
        model.loadColoursList { [weak self] Error in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    func loadData() async {
        do {
            try await model.loadColourList()
            tableView.reloadData()
        } catch {
            presentErrorAlert(title: "Error ", message: error.localizedDescription)
        }
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return model.colours.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ColourCell.identifier, for: indexPath) as? ColourCell else { return UITableViewCell() }
        let colour = model.colours[indexPath.section]
        Task {
            await cell.setPhoto(colour)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.frame.width
    }
    
}
