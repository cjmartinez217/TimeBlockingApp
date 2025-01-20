//
//  CalendarServiceProtocol.swift
//  TimeBlockingApp
//
//  Created by Christian Martinez on 1/15/25.
//

import Foundation

protocol CalendarServiceProtocol {
    func fetchEvents(for date: Date) async throws -> [EventModel]
    func deleteEvent(with id: UUID) async throws
    func createEvent(_ event: EventModel) async throws
    func updateEvent(_ event: EventModel) async throws
}
