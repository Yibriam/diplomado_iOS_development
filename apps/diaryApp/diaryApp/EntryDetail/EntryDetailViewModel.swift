//
//  EntryDetailViewModel.swift
//  diaryApp
//
//  Created by Yibriam on 30/01/26.
//

import MapKit

class EntryDetailViewModel {
    let entry: DiaryEntry
    
    init(entry: DiaryEntry) {
        self.entry = entry
    }
    
    func openDirections(transportType: MKDirectionsTransportType) {
        guard let location = entry.location else { return }
        
        let destinationPlacemark = MKPlacemark(
            coordinate: CLLocationCoordinate2D(latitude: location.latitude,
                                               longitude: location.longitude),
            addressDictionary: nil
        )
        let destinationItem = MKMapItem(placemark: destinationPlacemark)
        destinationItem.name = entry.title
        
        let sourceItem = MKMapItem.forCurrentLocation()
        
        let request = MKDirections.Request()
        request.source = sourceItem
        request.destination = destinationItem
        request.transportType = transportType
        
        let directions = MKDirections(request: request)
        directions.calculate { response, error in
            if let route = response?.routes.first {
                print("Route distance: \(route.distance) meters")
            } else if let error = error {
                print("Error calculating directions: \(error.localizedDescription)")
            }
        }
        
        MKMapItem.openMaps(
            with: [sourceItem, destinationItem],
            launchOptions: [MKLaunchOptionsDirectionsModeKey:
                            transportType == .walking ? MKLaunchOptionsDirectionsModeWalking
                                                      : MKLaunchOptionsDirectionsModeDriving]
        )
    }
}
