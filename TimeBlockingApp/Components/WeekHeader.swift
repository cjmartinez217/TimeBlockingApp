//
//  WeekHeader.swift
//  TimeBlockingApp
//
//  Created by Christian Martinez on 11/21/24.
//

import SwiftUI

struct WeekHeader: View {
    var dateInWeek = Date()
    let onDaySelected: (Date) -> Void

    var body: some View {
        let weekDates: [(Date, String)] = TimeUtils.getWeekDates(date: dateInWeek)

        VStack {
            HStack {
                ForEach(weekDates, id: \.0) { date, dayLetter in
                    VStack(spacing: 0) {
                        Text(dayLetter)
                            .foregroundColor(Calendar.current.isDateInToday(date) ? Color("PrimaryThemeColor") : .black)
                        ZStack {
                            Circle()
                                .fill(Calendar.current.isDateInToday(date) ? Color("PrimaryThemeColor") : Color.white)
                                .frame(width: 32, height: 32)
                            Text("\(TimeUtils.getDay(date: date))")
                                .foregroundColor(Calendar.current.isDateInToday(date) ? .white : .black)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .onTapGesture {
                        onDaySelected(date)
                    }
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    WeekHeader(onDaySelected: { _ in })
}
