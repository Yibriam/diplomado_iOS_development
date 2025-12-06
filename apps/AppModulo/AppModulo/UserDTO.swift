//
//  UserDTO.swift
//  AppModulo
//
//  Created by Yibriam on 29/11/25.
//

struct UserDTO: Decodable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let address: AddressDTO
    
    struct AddressDTO: Decodable {
        let street: String
        let city: String
        let latitude: String?
        let longitude: String?
        
        private enum CodingKeys: String, CodingKey {
            case street
            case city
            case geolocation = "geo"
        }
        
        private enum GeoCodingKeys: String, CodingKey {
            case latitude = "lat"
            case longitude = "lng"
        }
        
        init(from decoder: any Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            self.street = try values.decode(String.self, forKey: .street)
            self.city = try values.decode(String.self, forKey: .city)
            let geo = try values.nestedContainer(keyedBy: GeoCodingKeys.self, forKey: .geolocation)
            self.latitude = try geo.decode(String.self, forKey: .latitude)
            self.longitude = try geo.decode(String.self, forKey: .longitude)
        }
    }
}
