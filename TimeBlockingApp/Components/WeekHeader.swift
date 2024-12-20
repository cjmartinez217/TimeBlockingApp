//
//  WeekHeader.swift
//  TimeBlockingApp
//
//  Created by Christian Martinez on 11/21/24.
//

import SwiftUI

struct WeekHeader: View {
    var weekDates: [(Int, String)] = TimeUtils.getWeekDates()
    let currentDate = Calendar.current.component(.day, from: Date())

    var body: some View {
        VStack {
            HStack {
                ForEach(weekDates, id: \.0) { date, dayLetter in
                    VStack(spacing: 0) {
                        Text(dayLetter)
                            .foregroundColor(date == currentDate ? Color("PrimaryThemeColor") : .black)
                        ZStack {
                            Circle()
                                .fill(date == currentDate ? Color("PrimaryThemeColor") : Color.white)
                                .frame(width: 32, height: 32)
                            Text("\(date)")
                                .foregroundColor(date == currentDate ? .white : .black)
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
