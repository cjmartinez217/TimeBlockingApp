//
//  HorizontalCalendarView.swift
//  TimeBlockingApp
//
//  Created by Christian Martinez on 3/25/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var eventStore = MockEventStore.shared
    @State var currentDate: Date = Date()
    @State var targetDate: Date?
    @State var selectedItem: EventModel?
    @State private var isSideMenuPresented: Bool = false
    @State private var selectedSideMenuTab: Int = 1
    @State private var isAIViewPresented: Bool = false


    @ObservedObject var horizontalCalendarViewModel: HorizontalCalendarViewModel = HorizontalCalendarViewModel(numOfDays: 7, setDate: Date())

    var body: some View {
        ZStack {
            VStack(spacing: 0.0) {
                CalendarHeader(date: currentDate, presentSideMenu: $isSideMenuPresented, isSingleDay: horizontalCalendarViewModel.numOfDays == 1)
                if selectedSideMenuTab == 2 {
                    monthCalendarView
                } else {
                    horizontalCalendarView
                }
            }
            .onChange(of: selectedSideMenuTab) { newValue in
                switch newValue {
                case 0: horizontalCalendarViewModel.updateScrollType(numOfDays: 1)
                case 1: horizontalCalendarViewModel.updateScrollType(numOfDays: 7)
                default: break
                }
            }
            .sheet(item: $selectedItem, onDismiss: { selectedItem = nil }, content: { EventDetailView(event: $0) })
            .sideMenu(isPresented: $isSideMenuPresented) {
                SideMenu(isShowing: $isSideMenuPresented, selectedSideMenuTab: $selectedSideMenuTab)
            }

            if isAIViewPresented {
                VStack {
                    Spacer()
                    AIModal(isPresented: $isAIViewPresented)
                        .frame(width: UIScreen.main.bounds.width * 0.85)
                        .frame(height: UIScreen.main.bounds.width * 0.85)
                        .transition(.move(edge: .bottom))
                        .animation(.spring(), value: isAIViewPresented)
                        .padding(.bottom, 10)
                }
            }
        }
        .ignoresSafeArea(.container, edges: .bottom)
    }

    var horizontalCalendarView: some View {
        InfiniteCalendar<EventBlockView, EventBlock, HorizontalCalendarViewModel>(
            events: .constant(eventStore.events),
            settings: horizontalCalendarViewModel,
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
    ContentView()
}
