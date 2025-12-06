//
//  POIViewController.swift
//  countryInformation
//
//  Created by Yibriam on 05/12/25.
//

import UIKit

final class POIViewController: UIViewController, UITableViewDataSource {
    private let countryName: String
    private let stateName: String
    private let tableView = UITableView()
    private var pois: [String] = []

    init(countryName: String, stateName: String) {
        self.countryName = countryName
        self.stateName = stateName
        super.init(nibName: nil, bundle: nil)
        self.title = stateName
    }
    required init?(coder: NSCoder) { fatalError() }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        tableView.dataSource = self
        tableView.frame = view.bounds
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(tableView)
        pois = DataProvider.shared.poiByCountryState[countryName]?[stateName] ?? []
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { pois.count }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = pois[indexPath.row]
        return cell
    }
}

