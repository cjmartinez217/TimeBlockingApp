//
//  MonthCalendarView.swift
//  TimeBlockingApp
//
//  Created by Christian Martinez on 11/1/24.
//

import SwiftUI

struct MonthCalendarView: View {
    @Binding var presentSideMenu: Bool

    var body: some View {
        HStack {
            SideMenuButton(presentSideMenu: $presentSideMenu)
            Text("Month View")
        }
    }
}

#Preview {
    MonthCalendarView(presentSideMenu: .constant(false))
}
