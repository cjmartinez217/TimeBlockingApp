//
//  DayCalendarView.swift
//  TimeBlockingApp
//
//  Created by Christian Martinez on 10/18/24.
//

import SwiftUI

struct DayCalendarView: View {
    @Binding var presentSideMenu: Bool
    @State var currentDay = Date()

    var body: some View {
        VStack {
            HStack(alignment: .center) {
                SideMenuButton(presentSideMenu: $presentSideMenu)
                VStack(alignment: .leading) {
                    Text(TimeUtils.getDayOfWeek(date: currentDay))
                        .font(.system(size: 26, weight: .medium, design: .rounded))
                    let monthDate = TimeUtils.getMonth(date: currentDay) + " " + String(TimeUtils.getDay(date: currentDay))
                    Text(monthDate)
                        .font(.system(size: 18, weight: .light, design: .rounded))
                }
                Spacer()
                AddEventButton(isDisabled: $presentSideMenu)
            }
            .padding(.horizontal, 10)
            DayTimeGrid(displayDate: currentDay)
        }
        .gesture(
            DragGesture()
                .onEnded { value in
                    if value.translation.width < 0 { // Swipe left
                        currentDay = Calendar.current.date(byAdding: .day, value: 1, to: currentDay)!
                    } else if value.translation.width > 0 { // Swipe right
                        currentDay = Calendar.current.date(byAdding: .day, value: -1, to: currentDay)!
                    }
                }
        )
    }
}

#Preview {
    DayCalendarView(presentSideMenu: .constant(false))
}
