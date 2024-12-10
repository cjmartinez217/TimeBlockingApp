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
        VStack {
            HStack(alignment: .center) {
                SideMenuButton(presentSideMenu: $presentSideMenu)
                Text("July")
                    .font(.system(size: 28, weight: .medium, design: .rounded))
                Spacer()
            }
            .padding(.leading, 10)
            MonthGrid()
        }
    }
}

#Preview {
    MonthCalendarView(presentSideMenu: .constant(false))
}
