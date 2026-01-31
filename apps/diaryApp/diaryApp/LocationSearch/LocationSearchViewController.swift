//
//  LocationSearchViewController.swift
//  diaryApp
//
//  Created by You on 30/01/26.
//

import UIKit
import MapKit

protocol LocationSearchDelegate: AnyObject {
    func didSelectLocation(_ location: Location)
}

class LocationSearchViewController: UIViewController {
    private let viewModel = LocationSearchViewModel()
    weak var delegate: LocationSearchDelegate?

    private let searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.placeholder = "Search for an address"
        sb.translatesAutoresizingMaskIntoConstraints = false
        return sb
    }()

    private let tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()

    private let cancelButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Cancel", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self

        view.addSubview(searchBar)
        view.addSubview(cancelButton)
        view.addSubview(tableView)

        cancelButton.addTarget(self, action: #selector(didTapCancel), for: .touchUpInside)

        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            cancelButton.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 8),
            cancelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            tableView.topAnchor.constraint(equalTo: cancelButton.bottomAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        setupBindings()
    }

    private func setupBindings() {
        viewModel.onResultsUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }

    @objc private func didTapCancel() {
        dismiss(animated: true)
    }
}

// MARK: - UISearchBarDelegate
extension LocationSearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.updateSearch(query: searchText)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

// MARK: - UITableViewDataSource
extension LocationSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.locations.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let reuseId = "LocationCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseId) ??
                   UITableViewCell(style: .subtitle, reuseIdentifier: reuseId)

        let completion = viewModel.locations[indexPath.row]
        cell.textLabel?.text = completion.title
        cell.detailTextLabel?.text = completion.subtitle
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

// MARK: - UITableViewDelegate
extension LocationSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let completion = viewModel.locations[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)

        viewModel.resolveLocation(from: completion) { [weak self] location in
            DispatchQueue.main.async {
                guard let self = self, let location = location else { return }
                self.delegate?.didSelectLocation(location)
                self.dismiss(animated: true)
            }
        }
    }
}
