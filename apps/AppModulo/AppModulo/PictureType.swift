//
//  PictureType.swift
//  AppModulo
//
//  Created by Yibriam on 18/10/25.
//

import Foundation
import UIKit

enum PictureType {
    case dog, cat
    
    var captionedImages: [(CaptionedImage)] {
        switch self {
        case .dog:
            return [
                .init(image: UIImage.dog1, caption: "Peluzo"),
                .init(image: UIImage(resource: .dog2), caption: "Fido"),
                .init(image: UIImage(named: "dog-3") ?? UIImage(), caption: "Milaneso")
            ]
        case .cat:
            return [
                .init(image: UIImage.cat1, caption: "Milo"),
                .init(image: UIImage.cat2, caption: "Coffe"),
                .init(image: UIImage.cat3, caption: "Marcelo")
            ]
        }
    }
}

struct CaptionedImage {
    var image: UIImage
    var caption: String?
}
