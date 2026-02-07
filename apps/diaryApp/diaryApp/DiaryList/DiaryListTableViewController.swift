//
//  DiaryListTableViewController.swift
//  diaryApp
//
//  Created by Yibriam on 30/01/26.
//

import UIKit

class DiaryListTableViewController: UITableViewController {
    private let viewModel = DiaryListViewModel()
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Diary"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DiaryCell")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addEntry)
        )
    }
    
    @objc private func addEntry() {
        let editor = EntryEditorViewController(entry: nil)
        navigationController?.pushViewController(editor, animated: true)
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "DiaryCell")
        let entry = viewModel.entries[indexPath.row]
        
        cell.textLabel?.text = entry.title
        cell.detailTextLabel?.text = dateFormatter.string(from: entry.date)
        
        if entry.isDraft {
            cell.accessoryType = .detailDisclosureButton
            cell.textLabel?.textColor = .systemOrange
        } else {
            cell.accessoryType = .none
            cell.textLabel?.textColor = .label
        }
        
        return cell
    }
    
    // MARK: - TableView DataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = viewModel.entries.count
        
        if count == 0 {
            let emptyLabel = UILabel()
            emptyLabel.text = "No entries yet. Tap + to add one."
            emptyLabel.textAlignment = .center
            emptyLabel.textColor = .secondaryLabel
            tableView.backgroundView = emptyLabel
        } else {
            tableView.backgroundView = nil
        }
        
        return count
    }
    
    // MARK: - TableView Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedEntry = viewModel.entries[indexPath.row]
            
        // PASS the existing entry so the editor knows we are UPDATING, not creating
        let editorVC = EntryEditorViewController(entry: selectedEntry)
        
        navigationController?.pushViewController(editorVC, animated: true)
    }

    // Ensure the list refreshes when you come back
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.reloadEntries()
        tableView.reloadData()
    }
}
