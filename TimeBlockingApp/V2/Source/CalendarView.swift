//
//  HorizontalCalendarView.swift
//  TimeBlockingApp
//
//  Created by Christian Martinez on 3/25/25.
//

import SwiftUI

struct CalendarView: View {
    @StateObject private var eventStore = MockEventStore.shared
    @State var currentDate: Date = Date()
    @State var targetDate: Date?
    @State var selectedItem: EventModel?
    @State private var isSideMenuPresented: Bool = false
    @State private var selectedSideMenuTab: Int = 1

    @ObservedObject var settings: CustomSettings = CustomSettings(numOfDays: 7, setDate: Date())

    var body: some View {
        VStack(spacing: 0.0) {
            CalendarHeader(date: currentDate, presentSideMenu: $isSideMenuPresented, isSingleDay: settings.numOfDays == 1)
            if selectedSideMenuTab == 2 {
                monthCalendarView
            } else {
                horizontalCalendarView
            }
        }
        .onChange(of: selectedSideMenuTab) { newValue in
            switch newValue {
            case 0: settings.updateScrollType(numOfDays: 1)
            case 1: settings.updateScrollType(numOfDays: 7)
            default: break
            }
        }
        .sheet(item: $selectedItem, onDismiss: { selectedItem = nil }, content: { EventDetailView(event: $0) })
        .sideMenu(isPresented: $isSideMenuPresented) {
            SideMenu(isShowing: $isSideMenuPresented, selectedSideMenuTab: $selectedSideMenuTab)
        }
        .ignoresSafeArea(.container, edges: .bottom)
    }

    var horizontalCalendarView: some View {
        InfiniteCalendar<EventBlockView, EventBlock, CustomSettings>(
            events: .constant(eventStore.events),
            settings: settings,
            targetDate: $targetDate
        )
        .onCurrentDateChanged { date in
            // Don't recommend update date of @Sate variable (if you defined) with date obtained.
            // Because, if update @State variable, InfiniteCalendar will start re-rendaring then it will use CPU too much.
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

    var monthCalendarView: some View {
        MonthCalendarView(presentSideMenu: $isSideMenuPresented, onDaySelected: {_ in})
    }
}

#Preview {
    CalendarView()
}
