//
//  MockStore.swift
//  TimeBlockingApp
//
//  Created by Christian Martinez on 1/15/25.
//

import Foundation

class MockStore {
    static let shared = MockStore()
    private var events: [EventModel] = []

    private init() {
        let today = Date()
        let calendar = Calendar.current

        events = [
            EventModel(
                id: UUID(),
                title: "Team Meeting",
                startDate: calendar.date(byAdding: .hour, value: 0, to: today)!,
                endDate: calendar.date(byAdding: .hour, value: 2, to: today)!,
                description: "Conference Room A"
            ),
            EventModel(
                id: UUID(),
                title: "Lunch Break",
                startDate: calendar.date(byAdding: .hour, value: 4, to: today)!,
                endDate: calendar.date(byAdding: .hour, value: 5, to: today)!,
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
