import UIKit

class EntryEditorViewModel {
    private let service = DiaryDataService()
    
    func saveEntry(title: String, message: String, image: UIImage?, location: Location?, isDraft: Bool, existingId: UUID? = nil) {
        
        var entries = service.loadEntries()
        
        if let id = existingId, let index = entries.firstIndex(where: { $0.id == id }) {
            
            if let newImage = image {
                entries[index].photoFilename = saveImageToDocuments(newImage)
            }
            
            entries[index].title = title
            entries[index].message = message
            entries[index].location = location
            entries[index].isDraft = isDraft
            
        } else {
            // 2. This is a brand new entry
            var photoFilename: String? = nil
            if let newImage = image {
                photoFilename = saveImageToDocuments(newImage)
            }
            
            let newEntry = DiaryEntry(
                title: title,
                message: message,
                location: location,
                photoFilename: photoFilename,
                isDraft: isDraft
            )
            entries.append(newEntry)
        }
        
        do {
            try service.saveEntries(entries)
        } catch {
            print("Failed to save entries: \(error.localizedDescription)")
        }
    }
    
    func saveAsDraft(title: String, message: String, image: UIImage?, location: Location?, existingId: UUID? = nil) {
        saveEntry(title: title, message: message, image: image, location: location, isDraft: true, existingId: existingId)
    }
    
    private func saveImageToDocuments(_ image: UIImage) -> String? {
        guard let data = image.jpegData(compressionQuality: 0.8),
              let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        let imageName = UUID().uuidString + ".jpg"
        let imageURL = documentsURL.appendingPathComponent(imageName)
        
        do {
            try data.write(to: imageURL, options: .atomic)
            return imageName
        } catch {
            print("Error saving image: \(error.localizedDescription)")
            return nil
        }
    }
}
