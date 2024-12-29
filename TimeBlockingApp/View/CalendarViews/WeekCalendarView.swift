//
//  WeekCalendarView.swift
//  TimeBlockingApp
//
//  Created by Christian Martinez on 11/1/24.
//

import SwiftUI

struct WeekCalendarView: View {
    @Binding var presentSideMenu: Bool
    @State private var dateInWeek = Date() // Track the start of the current week

    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .center) {
                SideMenuButton(presentSideMenu: $presentSideMenu)
                Text(TimeUtils.getMonth(date: dateInWeek))
                    .font(.system(size: 28, weight: .medium, design: .rounded))
                Spacer()
                AddEventButton(isDisabled: $presentSideMenu)
            }
            .padding(.horizontal, 10)
            WeekHeader(dateInWeek: dateInWeek)
                .padding(.leading, 70)
                .padding(.vertical, 10)
            ZStack(alignment: .top) {
                VStack(spacing: 0) {
                    HStack(spacing: 47) {
                        ForEach(0..<7, id: \.self) { _ in
                            Divider()
                                .background(Color.gray)
                        }
                        .frame(height: 15)
                    }
                    .padding(.leading, 22)
                    Divider()
                        .background(Color.black)
                }
                WeekTimeGrid(dateInWeek: dateInWeek)
                    .padding(.top, 15)
            }
        }
        .gesture(
            DragGesture()
                .onEnded { value in
                    if value.translation.width < 0 { // Swipe left
                        dateInWeek = Calendar.current.date(byAdding: .weekOfYear, value: 1, to: dateInWeek)!
                    } else if value.translation.width > 0 { // Swipe right
                        dateInWeek = Calendar.current.date(byAdding: .weekOfYear, value: -1, to: dateInWeek)!
                    }
                }
        )
        .animation(.easeInOut)
    }
}

#Preview {
    WeekCalendarView(presentSideMenu: .constant(false))
}
