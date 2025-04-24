//
//  DayCalendarView.swift
//  TimeBlockingApp
//
//  Created by Christian Martinez on 10/18/24.
//

import SwiftUI

struct DayCalendarView: View {
    @Binding var presentSideMenu: Bool
    @Binding var displayDate: Date
    @StateObject private var calendarViewModel = CalendarViewModel()
    @StateObject private var previousCalendarViewModel = CalendarViewModel()
    @StateObject private var nextCalendarViewModel = CalendarViewModel()

    var body: some View {
        SlideableCalendarView(
            content: {
                dayContent(for: displayDate, calendarViewModel: calendarViewModel)
            },
            previousContent: {
                let previousDate = Calendar.current.date(byAdding: .day, value: -1, to: displayDate)!
                dayContent(for: previousDate, calendarViewModel: previousCalendarViewModel)
            },
            nextContent: {
                // This will be the next day's content
                let nextDate = Calendar.current.date(byAdding: .day, value: 1, to: displayDate)!
                dayContent(for: nextDate, calendarViewModel: nextCalendarViewModel)
            },
            onSwipeLeft: {
                swipeLeft()
            },
            onSwipeRight: {
                swipeRight()
            }
        )
        .onAppear {
            calendarViewModel.fetchEvents(for: displayDate)
            previousCalendarViewModel.fetchEvents(for: Calendar.current.date(byAdding: .day, value: -1, to: displayDate)!)
            nextCalendarViewModel.fetchEvents(for: Calendar.current.date(byAdding: .day, value: 1, to: displayDate)!)
        }
    }

    private func dayContent(for date: Date, calendarViewModel: CalendarViewModel) -> some View {
        VStack(spacing: 0) {
            HStack(alignment: .center) {
                SideMenuButton(presentSideMenu: $presentSideMenu)
                VStack(alignment: .leading) {
                    Text(TimeUtils.getDayOfWeek(date: date))
                        .font(.system(size: 26, weight: .medium, design: .rounded))
                    let monthDate = TimeUtils.getMonth(date: displayDate) + " " + String(TimeUtils.getDay(date: date))
                    Text(monthDate)
                        .font(.system(size: 18, weight: .light, design: .rounded))
                }
                Spacer()
                AddEventButton(date: date, isDisabled: $presentSideMenu)
            }
            .padding(.horizontal, 10)
            .padding(.bottom, 10)

            fullDayEvents(events: calendarViewModel.events)

            Divider()
                .background(Color.gray)
                .shadow(color: Color.black, radius: 1.5, x: 0, y: 1)
            DayTimeGrid(displayDate: displayDate, events: calendarViewModel.events)
        }
    }

    func fullDayEvents(events: [EventModel]) -> some View {
        let allDayEvents = events.filter { $0.isAllDay }

        return Group {
            if !allDayEvents.isEmpty {
                VStack(alignment: .trailing, spacing: 3) {
                    ForEach(allDayEvents) { event in
                        EventBlockView(event)
                    }
                }
                .padding(.bottom, 3)
                .padding(.leading, 66)
                .padding(.trailing, 5)
            }
        }
    }

    func swipeLeft() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { // Wait for animation to complete
            displayDate = Calendar.current.date(byAdding: .day, value: 1, to: displayDate)!
            calendarViewModel.events = nextCalendarViewModel.events
            previousCalendarViewModel.fetchEvents(for: Calendar.current.date(byAdding: .day, value: -1, to: displayDate)!)
            nextCalendarViewModel.fetchEvents(for: Calendar.current.date(byAdding: .day, value: 1, to: displayDate)!)
        }
    }

    func swipeRight() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { // Wait for animation to complete
            displayDate = Calendar.current.date(byAdding: .day, value: -1, to: displayDate)!
            calendarViewModel.events = previousCalendarViewModel.events
            previousCalendarViewModel.fetchEvents(for: Calendar.current.date(byAdding: .day, value: -1, to: displayDate)!)
            nextCalendarViewModel.fetchEvents(for: Calendar.current.date(byAdding: .day, value: 1, to: displayDate)!)
        }
    }
}

#Preview {
    DayCalendarView(presentSideMenu: .constant(false), displayDate: .constant(Date()))
        .environmentObject(CalendarViewModel())
}
