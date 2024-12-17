//
//  DayCalendarView.swift
//  TimeBlockingApp
//
//  Created by Christian Martinez on 10/18/24.
//

import SwiftUI

struct DayCalendarView: View {
    @Binding var presentSideMenu: Bool

    var body: some View {
        VStack {
            HStack(alignment: .center) {
                SideMenuButton(presentSideMenu: $presentSideMenu)
                VStack(alignment: .leading) {
                    Text("Thursday")
                        .font(.system(size: 26, weight: .medium, design: .rounded))
                    Text("July 25")
                        .font(.system(size: 18, weight: .light, design: .rounded))
                }
                Spacer()
                AddEventButton(isDisabled: $presentSideMenu)
            }
            .padding(.horizontal, 10)
            DayTimeGrid()
        }
    }
}

#Preview {
    DayCalendarView(presentSideMenu: .constant(false))
}
