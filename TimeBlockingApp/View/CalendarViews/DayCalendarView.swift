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
    @EnvironmentObject var calendarViewModel: CalendarViewModel

    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .center) {
                SideMenuButton(presentSideMenu: $presentSideMenu)
                VStack(alignment: .leading) {
                    Text(TimeUtils.getDayOfWeek(date: displayDate))
                        .font(.system(size: 26, weight: .medium, design: .rounded))
                    let monthDate = TimeUtils.getMonth(date: displayDate) + " " + String(TimeUtils.getDay(date: displayDate))
                    Text(monthDate)
                        .font(.system(size: 18, weight: .light, design: .rounded))
                }
                Spacer()
                AddEventButton(isDisabled: $presentSideMenu)
            }
            .padding(.horizontal, 10)
            .padding(.bottom, 10)

            fullDayEvents(events: calendarViewModel.events)

            Divider()
                .background(Color.gray)
                .shadow(color: Color.black, radius: 1.5, x: 0, y: 1)
            DayTimeGrid(displayDate: displayDate, events: calendarViewModel.events)
        }
        .gesture(
            DragGesture()
                .onEnded { value in
                    if value.translation.width < 0 { // Swipe left
                        displayDate = Calendar.current.date(byAdding: .day, value: 1, to: displayDate)!
                    } else if value.translation.width > 0 { // Swipe right
                        displayDate = Calendar.current.date(byAdding: .day, value: -1, to: displayDate)!
                    }
                }
        )
        .animation(.easeInOut)
    }

    func fullDayEvents(events: [EventModel]) -> some View {
        let allDayEvents = events.filter { $0.isAllDay }

        return Group {
            if !allDayEvents.isEmpty {
                VStack(alignment: .trailing, spacing: 3) {
                    ForEach(allDayEvents) { event in
                        EventBlock(event: event, height: 25)
                    }
                }
                .padding(.bottom, 3)
                .padding(.leading, 66)
                .padding(.trailing, 5)
            }
        }
    }
}

#Preview {
    DayCalendarView(presentSideMenu: .constant(false), displayDate: .constant(Date()))
        .environmentObject(CalendarViewModel())
}
