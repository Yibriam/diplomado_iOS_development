//
//  AlbumsViewController.swift
//  musicBands
//
//  Created by Yibriam on 21/11/25.
//

import UIKit

class AlbumsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private let tableView = UITableView()
    private let band: Band

    init(band: Band) {
        self.band = band
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) not implemented") }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = band.name
        view.backgroundColor = .systemBackground

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "AlbumCell")

        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return band.albums.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return 1 }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return band.albums[section].title
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let album = band.albums[indexPath.section]
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath)
        cell.textLabel?.text = "\(album.title) (\(album.releaseYear))"
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let songsVC = SongsViewController(album: band.albums[indexPath.section])
        navigationController?.pushViewController(songsVC, animated: true)
    }
}
