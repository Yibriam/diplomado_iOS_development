//
//  LocationSearchViewModel.swift
//  diaryApp
//
//  Created by Yibriam on 30/01/26.
//

import MapKit

class LocationSearchViewModel: NSObject, MKLocalSearchCompleterDelegate {
    private let completer = MKLocalSearchCompleter()
    
    private(set) var locations: [MKLocalSearchCompletion] = []
    
    var onResultsUpdated: (() -> Void)?
    
    override init() {
        super.init()
        completer.delegate = self
    }
    
    func updateSearch(query: String) {
        completer.queryFragment = query
    }
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        locations = completer.results
        onResultsUpdated?()
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print("Location search failed: \(error.localizedDescription)")
        locations = []
        onResultsUpdated?()
    }
    
    func resolveLocation(from completion: MKLocalSearchCompletion, completionHandler: @escaping (Location?) -> Void) {
        let request = MKLocalSearch.Request(completion: completion)
        let search = MKLocalSearch(request: request)
        
        search.start { response, error in
            guard let mapItem = response?.mapItems.first else {
                completionHandler(nil)
                return
            }
            
            let coordinate = mapItem.placemark.coordinate
            let address = [
                mapItem.placemark.name,
                mapItem.placemark.locality,
                mapItem.placemark.administrativeArea
            ]
            .compactMap { $0 }
            .joined(separator: ", ")
            
            let location = Location(latitude: coordinate.latitude,
                                    longitude: coordinate.longitude,
                                    address: address)
            completionHandler(location)
        }
    }
}
