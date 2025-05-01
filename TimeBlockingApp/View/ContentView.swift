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
    @State private var isAIViewPresented: Bool = false

    var body: some View {

        ZStack {
            currentCalendarView
            SideMenu(isShowing: $presentSideMenu, selectedSideMenuTab: $selectedSideMenuTab)
                .ignoresSafeArea(.all)

            HStack {
                Spacer()
                VStack(alignment: .trailing) {
                    Spacer()
                    AIButton(isDisabled: $presentSideMenu) {
                        isAIViewPresented.toggle()
                    }
                    .padding(.trailing, 24)
                }
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
    }

    @ViewBuilder
    var currentCalendarView: some View {
        switch selectedSideMenuTab {
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
