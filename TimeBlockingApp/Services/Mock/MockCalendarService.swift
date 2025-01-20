//
//  MockCalendarService.swift
//  TimeBlockingApp
//
//  Created by Christian Martinez on 1/15/25.
//

import Foundation

class MockCalendarService: CalendarServiceProtocol {
    private let store = MockStore.shared

    func fetchEvents(for date: Date) async throws -> [EventModel] {
        try? await Task.sleep(nanoseconds: 500_000_000)
        return store.getEvents(for: date)
    }

    func deleteEvent(with id: UUID) async throws {
        try? await Task.sleep(nanoseconds: 500_000_000)
        store.deleteEvent(with: id)
    }

    func createEvent(_ event: EventModel) async throws {
        try? await Task.sleep(nanoseconds: 500_000_000)
        store.addEvent(event)
    }

    func updateEvent(_ event: EventModel) async throws {
        try? await Task.sleep(nanoseconds: 500_000_000)
        store.updateEvent(event)
    }
}
