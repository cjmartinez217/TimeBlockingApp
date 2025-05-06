//
//  HorizontalCalendarView.swift
//  TimeBlockingApp
//
//  Created by Christian Martinez on 5/6/25.
//

import SwiftUI

struct HorizontalCalendarView: View {
    @StateObject private var eventStore = MockEventStore.shared
    @Binding var selectedItem: EventModel?
    @ObservedObject var horizontalCalendarViewModel: HorizontalCalendarViewModel
    @Binding var currentDate: Date
    @Binding var targetDate: Date?

    var body: some View {
        InfiniteCalendar<EventBlockView, EventBlock, HorizontalCalendarViewModel>(
            events: .constant(eventStore.events),
            settings: horizontalCalendarViewModel,
            targetDate: $targetDate
        )
        .onCurrentDateChanged { date in
            if currentDate.month != date.month {
                currentDate = date
            }
        }
        .onItemSelected { item in
            selectedItem = item
        }
        .onEventAdded { item in
            eventStore.addEvent(item)
        }
        .onEventMoved { item in
            eventStore.updateEvent(item)
        }
        .onEventCanceled { _ in
            print("Canceled some event gesture.")
        }
    }
}

#Preview {
    HorizontalCalendarView(
        selectedItem: .constant(nil),
        horizontalCalendarViewModel: HorizontalCalendarViewModel(numOfDays: 7, setDate: Date()),
        currentDate: .constant(Date()),
        targetDate: .constant(nil)
    )
}
