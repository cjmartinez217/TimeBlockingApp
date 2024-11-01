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
                DayHeader()
                Spacer()
            }
            .padding(.leading, 10)
            Spacer()
            DayTimeGrid()
        }
    }
}

#Preview {
    DayCalendarView(presentSideMenu: .constant(false))
}
