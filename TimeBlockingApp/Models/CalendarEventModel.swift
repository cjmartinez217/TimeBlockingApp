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
    let description: String?
    let isAllDay: Bool

    init(id: UUID = UUID(), title: String, startDate: Date, endDate: Date, description: String = "", isAllDay: Bool = false) {
        self.id = id
        self.title = title
        self.startDate = startDate
        self.endDate = endDate
        self.description = description
        self.isAllDay = isAllDay
    }
}

struct DayDateModel: Codable {
    let date: Date
    let events: [EventModel]
}


struct CalendarModel: Identifiable {
    let id = UUID()
    var name: String
    var email: String
    var isActive: Bool
}
