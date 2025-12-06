//
//  ColoursModel.swift
//  AppModulo
//
//  Created by Yibriam on 29/11/25.
//

import UIKit

class ColoursModel {
    
    private let repository: ColoursRepository
    private let imageDownloader: ImageDownloaderProtocol
    var colours = [Colour]()
    private var currentOffset: Int = 0
    
    init(repository: ColoursRepository, imageDownloader: ImageDownloaderProtocol, colours: [Colour] = [Colour]()) {
        self.repository = repository
        self.imageDownloader = imageDownloader
        self.colours = []
        self.currentOffset = 0
    }
    
    func loadColoursList(handler: @escaping (Error?) -> Void) {
        do {
            if let coloursDTO = try repository.getColoursList(for: "") {
                self.colours = coloursDTO.compactMap({ dto in
                    var urlComponents = URLComponents(string: dto.url)
                    urlComponents?.host = "dummyImage.com"
                    guard let url = urlComponents?.url else { return nil }
                    return Colour(url: url)
                })
            }
            handler(nil)
        } catch {
            handler(error)
        }
    }
}

class Colour {
    
    private let imageDownloader: ImageDownloaderProtocol
    
    let url: URL
    var image: UIImage?
    
    init(url: URL, download: ImageDownloaderProtocol, image: UIImage? = nil) {
        self.url = url
        self.image = image
        self.imageDownloader = downloader
    }
    
}


protocol ImageDownloaderProtocol {
    func downloadImage(url: URL) -> Data?
    
}

struct LocalImageDownloader: ImageDownloaderProtocol {
    func downloadImage(url: URL) -> Data? {
        UIImage.dog1.jpegData(compressionQuality: 1)
    }
    
    
}
