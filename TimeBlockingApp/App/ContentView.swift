//
//  ContentView.swift
//  TimeBlockingApp
//
//  Created by Christian Martinez on 3/25/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = HorizontalCalendarViewModel(numOfDays: 7, setDate: Date())
    @State private var eventStore = MockEventStore.shared
    @State private var currentDate = Date()
    @State private var targetDate: Date?
    @State private var selectedEvent: EventModel?
    @State private var sideMenuState = SideMenuState(isPresented: false, selectedTab: .week)
    @State private var isAIViewPresented = false

    var body: some View {
        ZStack {
            calendarStack
            aiModal
        }
        .ignoresSafeArea(.container, edges: .bottom)
    }

    private var calendarStack: some View {
        VStack(spacing: 0) {
            CalendarHeader(
                date: currentDate,
                presentSideMenu: $sideMenuState.isPresented,
                isSingleDay: sideMenuState.selectedTab == .day
            )

            Group {
                if sideMenuState.selectedTab == .month {
                    MonthCalendarView(onDaySelected: { _ in })
                } else {
                    HorizontalCalendarView(
                        selectedItem: $selectedEvent,
                        horizontalCalendarViewModel: viewModel,
                        currentDate: $currentDate,
                        targetDate: $targetDate
                    )
                }
            }
        }
        .onChange(of: sideMenuState.selectedTab) { oldValue, newValue in
            if let days = newValue.numOfDays {
                viewModel.updateScrollType(numOfDays: days)
            }
        }
        .sheet(item: $selectedEvent) { EventDetailView(event: $0) }
        .sideMenu(isPresented: $sideMenuState.isPresented) {
            SideMenu(
                isShowing: $sideMenuState.isPresented,
                selectedTab: Binding(
                    get: { sideMenuState.selectedTab.rawValue },
                    set: { sideMenuState.selectedTab = SideMenuRowType(rawValue: $0) ?? .week }
                )
            )
        }
    }

    @ViewBuilder
    private var aiModal: some View {
      if isAIViewPresented {
        AIModal(isPresented: $isAIViewPresented)
          .frame(maxWidth: 350, maxHeight: 350)
          .transition(.move(edge: .bottom))
          .animation(.spring(), value: isAIViewPresented)
          .padding(.bottom, 10)
      }
    }
  }

#Preview {
    ContentView()
}
