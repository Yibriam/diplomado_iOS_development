import Foundation

final class DiaryDataService {
    private let fileName = "entries.json"

    private var fileURL: URL {
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documents.appendingPathComponent(fileName)
    }

    func loadEntries() -> [DiaryEntry] {
        do {
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            return try decoder.decode([DiaryEntry].self, from: data)
        } catch {
            print("Failed to load entries (will return empty): \(error.localizedDescription)")
            return []
        }
    }

    func saveEntries(_ entries: [DiaryEntry]) throws {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        let data = try encoder.encode(entries)
        try data.write(to: fileURL, options: .atomic)
    }

    func deleteEntry(_ entry: DiaryEntry) {
        var entries = loadEntries()
        entries.removeAll { $0.id == entry.id }
        do {
            try saveEntries(entries)
        } catch {
            print("Failed to delete entry: \(error.localizedDescription)")
        }
        if let photoFilename = entry.photoFilename {
            deletePhoto(named: photoFilename)
        }
    }

    private func deletePhoto(named filename: String) {
        guard let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let photoURL = documentsURL.appendingPathComponent(filename)
        try? FileManager.default.removeItem(at: photoURL)
    }
}
