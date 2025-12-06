//
//  CountryDetailViewController.swift
//  countryInformation
//
//  Created by Yibriam on 05/12/25.
//

// CountryDetailViewController.swift
import UIKit

final class CountryDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private let countryName: String
    private let tableView = UITableView()
    private let headerView = UIStackView()
    private let flagImageView = UIImageView()   // <-- use UIImageView instead of UILabel
    private let capitalLabel = UILabel()
    private let languageLabel = UILabel()
    private let currencyButton = UIButton(type: .system)

    private var states: [String] = []

    init(countryName: String) {
        self.countryName = countryName
        super.init(nibName: nil, bundle: nil)
        self.title = countryName
    }
    required init?(coder: NSCoder) { fatalError() }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupHeader()
        setupTable()
        populate()
    }

    private func setupHeader() {
        flagImageView.contentMode = .scaleAspectFit
        flagImageView.clipsToBounds = true
        flagImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true

        capitalLabel.font = UIFont.systemFont(ofSize: 16)
        languageLabel.font = UIFont.systemFont(ofSize: 16)
        currencyButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        currencyButton.setTitle("Ver moneda y convertir", for: .normal)
        currencyButton.addTarget(self, action: #selector(openCurrencyTab), for: .touchUpInside)

        headerView.axis = .vertical
        headerView.spacing = 8
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.addArrangedSubview(flagImageView)
        headerView.addArrangedSubview(capitalLabel)
        headerView.addArrangedSubview(languageLabel)
        headerView.addArrangedSubview(currencyButton)

        view.addSubview(headerView)
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }

    private func setupTable() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 12),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    private func populate() {
        let provider = DataProvider.shared

        // Load flag image from assets using Flags.json mapping
        if let flagCode = provider.flags[countryName],
           let image = UIImage(named: flagCode) {
            flagImageView.image = image
        } else {
            flagImageView.image = UIImage(systemName: "flag") // fallback SF Symbol
        }

        if let detail = provider.detailsByCountry[countryName] {
            capitalLabel.text = "Capital: \(detail.capital)"
            languageLabel.text = "Idioma: \(detail.idioma)"
        } else {
            capitalLabel.text = "Capital: -"
            languageLabel.text = "Idioma: -"
        }

        states = provider.statesByCountry[countryName] ?? []
        tableView.reloadData()
    }

    // MARK: table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { states.count }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let s = states[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var config = cell.defaultContentConfiguration()
        config.text = s
        cell.contentConfiguration = config
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let stateName = states[indexPath.row]
        let vc = POIViewController(countryName: countryName, stateName: stateName)
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .pageSheet
        present(nav, animated: true, completion: nil)
    }

    // MARK: currency action
    @objc private func openCurrencyTab() {
        presentingViewController?.dismiss(animated: true, completion: nil)
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
           let tab = sceneDelegate.window?.rootViewController as? UITabBarController {
            tab.selectedIndex = 1
        }
    }
}
