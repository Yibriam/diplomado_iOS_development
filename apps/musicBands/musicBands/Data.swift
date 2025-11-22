//
//  Data.swift
//  musicBands
//
//  Created by Yibriam on 21/11/25.
//

import Foundation

struct Song {
    let title: String
    let duration: String
}

struct Album {
    let title: String
    let releaseYear: Int
    let songs: [Song]
    let imageName: String
}


struct Band {
    let name: String
    let imageName: String   // name of image asset
    let albums: [Album]
}
