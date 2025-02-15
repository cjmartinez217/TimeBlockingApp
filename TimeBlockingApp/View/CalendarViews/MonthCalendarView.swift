//
//  MonthCalendarView.swift
//  TimeBlockingApp
//
//  Created by Christian Martinez on 11/1/24.
//

import SwiftUI

struct MonthCalendarView: View {
    @Binding var presentSideMenu: Bool
    @State private var displayDate = Date()
    let onDaySelected: (Date) -> Void

    var body: some View {
        VStack {
            HStack(alignment: .center) {
                SideMenuButton(presentSideMenu: $presentSideMenu)
                Text(TimeUtils.getMonth(date: displayDate))
                    .font(.system(size: 28, weight: .medium, design: .rounded))
                Spacer()
                AddEventButton(date: displayDate, isDisabled: $presentSideMenu)
            }
            .padding(.horizontal, 10)
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
    MonthCalendarView(presentSideMenu: .constant(false), onDaySelected: { _ in })
}
