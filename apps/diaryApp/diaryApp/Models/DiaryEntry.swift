//
//  DiaryEntry.swift
//  diaryApp
//
//  Created by Yibriam on 30/01/26.
//

import Foundation

struct DiaryEntry: Codable, Identifiable, Equatable {
    var id: UUID = UUID()
    var title: String
    var message: String
    var date: Date = Date()
    var location: Location?
    var photoFilename: String?
    var isDraft: Bool = false
    
    init(title: String,
         message: String,
         location: Location? = nil,
         photoFilename: String? = nil,
         isDraft: Bool = false) {
        self.title = title
        self.message = message
        self.location = location
        self.photoFilename = photoFilename
        self.isDraft = isDraft
    }
}

