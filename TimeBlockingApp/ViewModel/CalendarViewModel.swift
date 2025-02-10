//
//  CalendarViewModel.swift
//  TimeBlockingApp
//
//  Created by Christian Martinez on 1/17/25.
//

import Foundation

@MainActor
class CalendarViewModel: ObservableObject {
    private let calendarService: CalendarServiceProtocol
    @Published var events: [EventModel] = []
    @Published var isLoading = false
    @Published var error: Error?

    init(calendarService: CalendarServiceProtocol = MockCalendarService()) {
        self.calendarService = calendarService
    }

    func fetchEvents(for date: Date) {
        Task {
            isLoading = true
            do {
                events = try await calendarService.fetchEvents(for: date)
            } catch {
                self.error = error
            }
            isLoading = false
        }
    }

    func deleteEvent(with id: UUID) {
        Task {
            do {
                try await calendarService.deleteEvent(with: id)
                events.removeAll { $0.id == id }
            } catch {
                self.error = error
            }
        }
    }

    func createEvent(_ event: EventModel) {
        Task {
            do {
                try await calendarService.createEvent(event)
                if Calendar.current.isDate(event.startDate, inSameDayAs: Date()) {
                    await fetchEvents(for: event.startDate)
                }
            } catch {
                self.error = error
            }
        }
    }

    func updateEvent(_ event: EventModel) {
        Task {
            do {
                try await calendarService.updateEvent(event)
                await fetchEvents(for: event.startDate)
            } catch {
                self.error = error
            }
        }
    }
}
