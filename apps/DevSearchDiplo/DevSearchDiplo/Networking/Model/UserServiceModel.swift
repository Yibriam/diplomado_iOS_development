//
//  UserServiceModel.swift
//  DevSearchDiplo
//
//  Created by alumno on 20/02/26.
//

import Foundation

public struct GetUserResponse: Codable {
    let id: Int?
    let name: String?
    let avatar_url: String?
    let login: String?
    let company: String?
    let location: String?
    let bio: String?
}
