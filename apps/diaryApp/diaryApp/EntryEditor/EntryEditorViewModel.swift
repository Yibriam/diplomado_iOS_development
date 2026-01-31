import UIKit

class EntryEditorViewModel {
    private let service = DiaryDataService()
    
    /// Save new entry or update existing one
    func saveEntry(title: String, message: String, image: UIImage?, location: Location?, isDraft: Bool, existingId: UUID? = nil) {
        var photoFilename: String? = nil
        if let image = image {
            photoFilename = saveImageToDocuments(image)
        }
        
        // Build entry using convenience initializer
        var entry = DiaryEntry(
            title: title,
            message: message,
            location: location,
            photoFilename: photoFilename,
            isDraft: isDraft
        )
        
        // If updating, preserve id and date
        var entries = service.loadEntries()
        if let id = existingId, let index = entries.firstIndex(where: { $0.id == id }) {
            entry.id = id
            entry.date = entries[index].date // keep original date if desired
            entries[index] = entry
        } else {
            // new entry: date and id already set by DiaryEntry defaults
            entries.append(entry)
        }
        
        do {
            try service.saveEntries(entries)
            print("Saved entry: \(entry.title) (id: \(entry.id))")
        } catch {
            print("Failed to save entry: \(error.localizedDescription)")
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
