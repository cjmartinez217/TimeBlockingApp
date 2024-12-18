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

    var body: some View {

        ZStack {
            TabView(selection: $selectedSideMenuTab) {
                DayCalendarView(presentSideMenu: $presentSideMenu)
                    .tag(0)
                WeekCalendarView(presentSideMenu: $presentSideMenu)
                    .tag(1)
                MonthCalendarView(presentSideMenu: $presentSideMenu)
                    .tag(2)
            }
            .tabViewStyle(.page)
            .ignoresSafeArea()

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
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
