//
//  MockStore.swift
//  TimeBlockingApp
//
//  Created by Christian Martinez on 1/15/25.
//

import Foundation

class MockStore: ObservableObject {
    static let shared = MockStore()
    @Published private(set) var events: [EventModel] = []

    private init() {
        let calendar = Calendar.current

        var todayComponents = calendar.dateComponents([.year, .month, .day], from: Date())
        todayComponents.hour = 9
        let firstEventStart = calendar.date(from: todayComponents)!

        todayComponents.hour = 10
        todayComponents.minute = 30
        let firstEventEnd = calendar.date(from: todayComponents)!

        // Second event: 12:00 PM to 1:00 PM
        todayComponents.hour = 12
        todayComponents.minute = 0
        let secondEventStart = calendar.date(from: todayComponents)!

        todayComponents.hour = 13
        let secondEventEnd = calendar.date(from: todayComponents)!



        events = [
            EventModel(
                id: UUID(),
                title: "Team Meeting",
                startDate: firstEventStart,
                endDate: firstEventEnd,
                description: "Conference Room A"
            ),
            EventModel(
                id: UUID(),
                title: "Lunch Break",
                startDate: secondEventStart,
                endDate: secondEventEnd,
                description: "Test description"
            )
        ]
    }

    func getEvents(for date: Date) -> [EventModel] {
        let calendar = Calendar.current
        return events.filter { event in
            calendar.isDate(event.startDate, inSameDayAs: date)
        }
    }

    func addEvent(_ event: EventModel) {
        events.append(event)
    }

    func deleteEvent(with id: UUID) {
        events.removeAll { $0.id == id }
    }

    func updateEvent(_ updatedEvent: EventModel) {
        if let index = events.firstIndex(where: { $0.id == updatedEvent.id }) {
            events[index] = updatedEvent
        }
    }
}
