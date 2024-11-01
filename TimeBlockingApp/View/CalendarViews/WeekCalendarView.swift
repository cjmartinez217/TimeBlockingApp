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
        HStack {
            SideMenuButton(presentSideMenu: $presentSideMenu)
            Text("Weekly view")
        }
    }
}

#Preview {
    WeekCalendarView(presentSideMenu: .constant(false))
}
