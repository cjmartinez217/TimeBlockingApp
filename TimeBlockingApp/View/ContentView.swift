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

    var body: some View {
        ZStack {
            DayCalendarView()
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    AddEventButton()
                        .padding(.trailing, 24)
                }
            }
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
