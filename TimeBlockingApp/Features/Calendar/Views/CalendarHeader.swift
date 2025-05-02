//
//  CalendarHeader.swift
//  TimeBlockingApp
//
//  Created by Christian Martinez on 4/5/25.
//

import SwiftUI

struct CalendarHeader: View {
    let date: Date
    @Binding var presentSideMenu: Bool
    let isSingleDay: Bool

    var body: some View {
        HStack(alignment: .center) {
            SideMenuButton(presentSideMenu: $presentSideMenu)
            if isSingleDay {
                VStack(alignment: .leading) {
                    Text(TimeUtils.getDayOfWeek(date: date))
                        .font(.system(size: 26, weight: .medium, design: .rounded))
                    let monthDate = TimeUtils.getMonth(date: date) + " " + String(TimeUtils.getDay(date: date))
                    Text(monthDate)
                        .font(.system(size: 18, weight: .light, design: .rounded))
                }
            } else {
                Text(TimeUtils.getMonth(date: date))
                    .font(.system(size: 28, weight: .medium, design: .rounded))
            }
            Spacer()
            AddEventButton(date: date, isDisabled: $presentSideMenu)
        }
    }
}

#Preview {
    CalendarHeader(date: Date(), presentSideMenu: .constant(false), isSingleDay: true)
}
