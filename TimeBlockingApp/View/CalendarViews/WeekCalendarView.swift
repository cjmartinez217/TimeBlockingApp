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
        VStack {
            HStack(alignment: .center) {
                SideMenuButton(presentSideMenu: $presentSideMenu)
                Text("July")
                    .font(.system(size: 26, weight: .medium, design: .rounded))
                Spacer()
            }
            .padding(.leading, 10)
            ZStack(alignment: .top) {
                Divider()
                    .background(Color.black)
                    .padding(.top)
                    .clipped()
                WeekTimeGrid()
            }
        }
    }
}

#Preview {
    WeekCalendarView(presentSideMenu: .constant(false))
}
