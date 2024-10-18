//
//  DayCalendarView.swift
//  TimeBlockingApp
//
//  Created by Christian Martinez on 10/18/24.
//

import SwiftUI

struct DayCalendarView: View {
    var body: some View {
        VStack {
            DayHeader()
                .padding(.leading, 10)
                .padding(.top, 12)
            Spacer()
            DayTimeGrid()
        }
    }
}

#Preview {
    DayCalendarView()
}
