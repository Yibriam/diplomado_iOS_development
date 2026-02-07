import UIKit
import MapKit

class EntryDetailViewModel {
    let entry: DiaryEntry
    
    init(entry: DiaryEntry) {
        self.entry = entry
    }
    
    func loadImageFromDisk(filename: String) -> UIImage? {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(filename)
        return UIImage(contentsOfFile: path.path)
    }
    
    func calculateRoute(transportType: MKDirectionsTransportType, completion: @escaping (MKRoute?) -> Void) {
        guard let loc = entry.location else { return }
        
        let request = MKDirections.Request()
        request.source = MKMapItem.forCurrentLocation()
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: loc.latitude, longitude: loc.longitude)))
        request.transportType = transportType
        
        let directions = MKDirections(request: request)
        directions.calculate { response, error in
            completion(response?.routes.first)
        }
    }
}
