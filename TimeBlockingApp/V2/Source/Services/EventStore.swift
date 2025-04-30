//
//  EventStore.swift
//  TimeBlockingApp
//
//  Created by Christian Martinez on 4/29/25.
//

import Foundation

protocol EventStoreProtocol {
    var events: [EventModel] { get }
    func addEvent(_ event: EventModel)
    func updateEvent(_ event: EventModel)
    func deleteEvent(with id: String)
    func getEvents(for date: Date) -> [EventModel]
}

class MockEventStore: EventStoreProtocol, ObservableObject {
    static let shared = MockEventStore()
    @Published private(set) var events: [EventModel]

    private init() {
        self.events = SampleData().events
    }

    func addEvent(_ event: EventModel) {
        events.append(event)
    }

    func updateEvent(_ event: EventModel) {
        if let index = events.firstIndex(where: { $0.id == event.id }) {
            events[index] = event
        }
    }

    func deleteEvent(with id: String) {
        events.removeAll { $0.id == id }
    }

    func getEvents(for date: Date) -> [EventModel] {
        let calendar = Calendar.current
        return events.filter { event in
            calendar.isDate(event.startDate, inSameDayAs: date)
        }
    }
}

// Future implementation for real backend
class LiveEventStore: EventStoreProtocol, ObservableObject {
    static let shared = LiveEventStore()
    @Published private(set) var events: [EventModel] = []

    private init() {}

    func addEvent(_ event: EventModel) {
        // TODO: Implement API call
    }

    func updateEvent(_ event: EventModel) {
        // TODO: Implement API call
    }

    func deleteEvent(with id: String) {
        // TODO: Implement API call
    }

    func getEvents(for date: Date) -> [EventModel] {
        // TODO: Implement API call
        return []
    }
}
