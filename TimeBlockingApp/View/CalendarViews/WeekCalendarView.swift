//
//  WeekCalendarView.swift
//  TimeBlockingApp
//
//  Created by Christian Martinez on 11/1/24.
//

import SwiftUI

struct WeekCalendarView: View {
    @Binding var presentSideMenu: Bool

    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .center) {
                SideMenuButton(presentSideMenu: $presentSideMenu)
                Text("July")
                    .font(.system(size: 28, weight: .medium, design: .rounded))
                Spacer()
                AddEventButton(isDisabled: $presentSideMenu)
            }
            .padding(.horizontal, 10)
            WeekHeader()
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
                WeekTimeGrid()
                    .padding(.top, 15)
            }
        }
    }
}

#Preview {
    WeekCalendarView(presentSideMenu: .constant(false))
}
