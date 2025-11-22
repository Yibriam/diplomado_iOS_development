//
//  BandsViewController.swift
//  musicBands
//
//  Created by Yibriam on 21/11/25.
//

import UIKit

class BandsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private let tableView = UITableView()
    private var bands: [Band] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Bands"
        view.backgroundColor = .systemBackground

        // Sample data
        bands = [
            Band(name: "The Beatles", imageName: "beatles", albums: [
                Album(title: "Abbey Road", releaseYear: 1969, songs: [
                    Song(title: "Come Together", duration: "4:20"),
                    Song(title: "Something", duration: "3:03"),
                    Song(title: "Here Comes the Sun", duration: "3:06")
                ], imageName: "abbeyRoad"),
                Album(title: "Let It Be", releaseYear: 1970, songs: [
                    Song(title: "Let It Be", duration: "4:03"),
                    Song(title: "Across the Universe", duration: "3:48"),
                    Song(title: "The Long and Winding Road", duration: "3:38")
                ], imageName: "letItBe"),
                Album(title: "Revolver", releaseYear: 1966, songs: [
                    Song(title: "Eleanor Rigby", duration: "2:08"),
                    Song(title: "Yellow Submarine", duration: "2:40"),
                    Song(title: "Tomorrow Never Knows", duration: "3:00")
                ], imageName: "revolver")
            ]),
            
            Band(name: "Queen", imageName: "queen", albums: [
                Album(title: "A Night at the Opera", releaseYear: 1975, songs: [
                    Song(title: "Bohemian Rhapsody", duration: "5:55"),
                    Song(title: "Love of My Life", duration: "3:38"),
                    Song(title: "You're My Best Friend", duration: "2:50")
                ], imageName: "nightAtTheOpera"),
                Album(title: "News of the World", releaseYear: 1977, songs: [
                    Song(title: "We Will Rock You", duration: "2:02"),
                    Song(title: "We Are the Champions", duration: "2:59"),
                    Song(title: "Spread Your Wings", duration: "4:34")
                ], imageName: "newsOfTheWorld"),
                Album(title: "The Game", releaseYear: 1980, songs: [
                    Song(title: "Another One Bites the Dust", duration: "3:35"),
                    Song(title: "Crazy Little Thing Called Love", duration: "2:43"),
                    Song(title: "Save Me", duration: "3:48")
                ], imageName: "theGame")
            ]),
            
            Band(name: "AC/DC", imageName: "acdc", albums: [
                Album(title: "Back in Black", releaseYear: 1980, songs: [
                    Song(title: "Back in Black", duration: "4:15"),
                    Song(title: "Hells Bells", duration: "5:12"),
                    Song(title: "You Shook Me All Night Long", duration: "3:30")
                ], imageName: "backInBlack"),
                Album(title: "Highway to Hell", releaseYear: 1979, songs: [
                    Song(title: "Highway to Hell", duration: "3:28"),
                    Song(title: "Girls Got Rhythm", duration: "3:23"),
                    Song(title: "Touch Too Much", duration: "4:28")
                ], imageName: "highwayToHell"),
                Album(title: "Let There Be Rock", releaseYear: 1977, songs: [
                    Song(title: "Let There Be Rock", duration: "6:06"),
                    Song(title: "Whole Lotta Rosie", duration: "5:24"),
                    Song(title: "Bad Boy Boogie", duration: "4:27")
                ], imageName: "letThereBeRock")
            ])
        ]


        // Table setup
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "BandCell")

        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    // MARK: - Table DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bands.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let band = bands[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "BandCell", for: indexPath)
        cell.textLabel?.text = band.name
        cell.imageView?.image = UIImage(named: band.imageName)
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let albumsVC = AlbumsViewController(band: bands[indexPath.row])
        navigationController?.pushViewController(albumsVC, animated: true)
    }
}
