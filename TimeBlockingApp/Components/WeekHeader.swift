//
//  WeekHeader.swift
//  TimeBlockingApp
//
//  Created by Christian Martinez on 11/21/24.
//

import SwiftUI

struct WeekHeader: View {
    var dateInWeek = Date()
    let todaysDate = TimeUtils.getDay()

    var body: some View {
        let weekDates: [(Int, String)] = TimeUtils.getWeekDates(date: dateInWeek)

        VStack {
            HStack {
                ForEach(weekDates, id: \.0) { date, dayLetter in
                    VStack(spacing: 0) {
                        Text(dayLetter)
                            .foregroundColor(date == todaysDate ? Color("PrimaryThemeColor") : .black)
                        ZStack {
                            Circle()
                                .fill(date == todaysDate ? Color("PrimaryThemeColor") : Color.white)
                                .frame(width: 32, height: 32)
                            Text("\(date)")
                                .foregroundColor(date == todaysDate ? .white : .black)
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    WeekHeader()
}
