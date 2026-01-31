//
//  DiaryListViewModel.swift
//  diaryApp
//
//  Created by Yibriam on 30/01/26.
//

import Foundation

class DiaryListViewModel {
    private let service = DiaryDataService()
    private(set) var entries: [DiaryEntry] = []

    init() {
        reloadEntries()
    }

    func reloadEntries() {
        entries = service.loadEntries().sorted { $0.date > $1.date }
    }

    func addEntry(_ entry: DiaryEntry) {
        entries.append(entry)
        saveEntries()
    }

    func updateEntry(_ entry: DiaryEntry) {
        if let index = entries.firstIndex(where: { $0.id == entry.id }) {
            entries[index] = entry
            saveEntries()
        }
    }

    func deleteEntry(at index: Int) {
        guard index < entries.count else { return }
        entries.remove(at: index)
        saveEntries()
    }

    private func saveEntries() {
        do {
            try service.saveEntries(entries)
            reloadEntries()
        } catch {
            // Surface the error for debugging; replace with user-facing handling if needed
            print("Failed to save entries: \(error.localizedDescription)")
        }
    }
}
