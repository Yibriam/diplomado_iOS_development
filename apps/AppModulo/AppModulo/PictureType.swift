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
    
    var captionedImages: [(image: UIImage, caption: String)] {
        switch self {
        case .dog:
            return [
                (UIImage.dog1, "Peluzo"),
                (UIImage(resource: .dog2), "Fido"),
                (UIImage(named: "dog-3") ?? UIImage(), "Milaneso")
            ]
        case .cat:
            return [
                (UIImage.cat1, "Milo"),
                (UIImage.cat2, "Coffe"),
                (UIImage.cat3, "Marcelo"),
            ]
        }
    }
}
