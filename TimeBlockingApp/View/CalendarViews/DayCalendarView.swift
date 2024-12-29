//
//  DayCalendarView.swift
//  TimeBlockingApp
//
//  Created by Christian Martinez on 10/18/24.
//

import SwiftUI

struct DayCalendarView: View {
    @Binding var presentSideMenu: Bool
    @Binding var displayDate: Date

    var body: some View {
        VStack {
            HStack(alignment: .center) {
                SideMenuButton(presentSideMenu: $presentSideMenu)
                VStack(alignment: .leading) {
                    Text(TimeUtils.getDayOfWeek(date: displayDate))
                        .font(.system(size: 26, weight: .medium, design: .rounded))
                    let monthDate = TimeUtils.getMonth(date: displayDate) + " " + String(TimeUtils.getDay(date: displayDate))
                    Text(monthDate)
                        .font(.system(size: 18, weight: .light, design: .rounded))
                }
                Spacer()
                AddEventButton(isDisabled: $presentSideMenu)
            }
            .padding(.horizontal, 10)
            DayTimeGrid(displayDate: displayDate)
        }
        .gesture(
            DragGesture()
                .onEnded { value in
                    if value.translation.width < 0 { // Swipe left
                        displayDate = Calendar.current.date(byAdding: .day, value: 1, to: displayDate)!
                    } else if value.translation.width > 0 { // Swipe right
                        displayDate = Calendar.current.date(byAdding: .day, value: -1, to: displayDate)!
                    }
                }
        )
        .animation(.easeInOut)
    }
}

#Preview {
    DayCalendarView(presentSideMenu: .constant(false), displayDate: .constant(Date()))
}
