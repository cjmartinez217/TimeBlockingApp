//
//  MonthCalendarView.swift
//  TimeBlockingApp
//
//  Created by Christian Martinez on 11/1/24.
//

import SwiftUI

struct MonthCalendarView: View {
    @Binding var presentSideMenu: Bool
    @State private var displayMonth = Date()

    var body: some View {
        VStack {
            HStack(alignment: .center) {
                SideMenuButton(presentSideMenu: $presentSideMenu)
                Text(TimeUtils.getMonth(date: displayMonth))
                    .font(.system(size: 28, weight: .medium, design: .rounded))
                Spacer()
                AddEventButton(isDisabled: $presentSideMenu)
            }
            .padding(.horizontal, 10)
            MonthGrid(date: displayMonth)
        }
        .gesture(
            DragGesture()
                .onEnded { value in
                    if value.translation.width < 0 { // Swipe left
                        displayMonth = Calendar.current.date(byAdding: .month, value: 1, to: displayMonth)!
                    } else if value.translation.width > 0 { // Swipe right
                        displayMonth = Calendar.current.date(byAdding: .month, value: -1, to: displayMonth)!
                    }
                }
        )
    }
}

#Preview {
    MonthCalendarView(presentSideMenu: .constant(false))
}
