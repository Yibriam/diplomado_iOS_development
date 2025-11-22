//
//  ViewController.swift
//  shoppingList
//
//  Created by Yibriam on 21/11/25.
//

import UIKit

class ShoppingListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private var items: [String] = []
    
    private let tableView = UITableView()
    private let textField = UITextField()
    private let addButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Shopping List"
        view.backgroundColor = .systemBackground
        
        setupInputArea()
        setupTableView()
    }
    
    // MARK: - Setup UI
    private func setupInputArea() {
        textField.placeholder = "Enter item"
        textField.borderStyle = .roundedRect
        
        addButton.setTitle("Add", for: .normal)
        addButton.addTarget(self, action: #selector(addItem), for: .touchUpInside)
        
        let stack = UIStackView(arrangedSubviews: [textField, addButton])
        stack.axis = .horizontal
        stack.spacing = 8
        stack.distribution = .fillProportionally
        
        view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            textField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // Optional challenge: swipe down to add
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(addItemViaSwipe), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    // MARK: - Actions
    @objc private func addItem() {
        guard let text = textField.text, !text.isEmpty else { return }
        items.append(text)
        textField.text = ""
        tableView.reloadData()
    }
    
    @objc private func addItemViaSwipe() {
        // Example: add a placeholder item when swiping down
        items.append("New Item")
        tableView.reloadData()
        tableView.refreshControl?.endRefreshing()
    }
    
    // MARK: - Table DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    
    // MARK: - Delete with gestures
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
    -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] _, _, completion in
            guard let self = self else { return }
            
            // Confirmation alert
            let alert = UIAlertController(title: "Confirm Deletion",
                                          message: "Are you sure you want to delete \"\(self.items[indexPath.row])\"?",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
                self.items.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }))
            
            self.present(alert, animated: true)
            completion(true)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

