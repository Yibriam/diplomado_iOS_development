//
//  Location.swift
//  diaryApp
//
//  Created by Yibriam on 30/01/26.
//

import CoreLocation

struct Location: Codable, Equatable {
    var latitude: Double
    var longitude: Double
    var address: String
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
