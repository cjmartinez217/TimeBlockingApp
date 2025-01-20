//
//  CalendarEventModel.swift
//  TimeBlockingApp
//
//  Created by Christian Martinez on 1/15/25.
//

import Foundation

struct EventModel: Codable, Identifiable {
    let id: UUID
    let title: String
    let startDate: Date
    let endDate: Date
    let description: String

    init(id: UUID = UUID(), title: String, startDate: Date, endDate: Date, description: String) {
        self.id = id
        self.title = title
        self.startDate = startDate
        self.endDate = endDate
        self.description = description
    }
}

struct DayDateModel: Codable {
    let date: Date
    let events: [EventModel]
}
