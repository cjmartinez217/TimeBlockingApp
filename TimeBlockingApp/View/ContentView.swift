//
//  ContentView.swift
//  TimeBlockingApp
//
//  Created by Christian Martinez on 10/11/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var presentSideMenu = false
    @State var selectedSideMenuTab = 0
    @State var selectedDay: Date = Date()

    var body: some View {

        ZStack {
            currentCalendarView
            SideMenu(isShowing: $presentSideMenu, selectedSideMenuTab: $selectedSideMenuTab)
                .ignoresSafeArea(.all)

            HStack {
                Spacer()
                VStack(alignment: .trailing) {
                    Spacer()
                    AIButton(isDisabled: $presentSideMenu)
                        .padding(.trailing, 24)
                }
            }
        }
    }

    @ViewBuilder
    var currentCalendarView: some View {
        switch selectedSideMenuTab {
        case 0:
            DayCalendarView(presentSideMenu: $presentSideMenu, displayDate: $selectedDay)
        case 1:
            WeekCalendarView(presentSideMenu: $presentSideMenu) { day in
                selectedDay = day
                selectedSideMenuTab = 0
            }
        case 2:
            MonthCalendarView(presentSideMenu: $presentSideMenu) { day in
                selectedDay = day
                selectedSideMenuTab = 0
            }
        default:
            EmptyView()
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
