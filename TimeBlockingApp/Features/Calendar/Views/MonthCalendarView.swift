//
//  MonthCalendarView.swift
//  TimeBlockingApp
//
//  Created by Christian Martinez on 11/1/24.
//

import SwiftUI

struct MonthCalendarView: View {
    @State private var displayDate = Date()
    let onDaySelected: (Date) -> Void

    var body: some View {
        VStack {
            ZStack {
                Color.clear
                MonthGrid(date: displayDate, onDaySelected: onDaySelected)
            }
            .contentShape(Rectangle())
            .gesture(
                DragGesture()
                    .onEnded { value in
                        if value.translation.width < 0 { // Swipe left
                            displayDate = Calendar.current.date(byAdding: .month, value: 1, to: displayDate)!
                        } else if value.translation.width > 0 { // Swipe right
                            displayDate = Calendar.current.date(byAdding: .month, value: -1, to: displayDate)!
                        }
                    }
            )
            .animation(.easeInOut)
        }
    }
}

#Preview {
    MonthCalendarView(onDaySelected: { _ in })
}
