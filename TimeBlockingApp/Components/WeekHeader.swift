//
//  WeekHeader.swift
//  TimeBlockingApp
//
//  Created by Christian Martinez on 11/21/24.
//

import SwiftUI

struct WeekHeader: View {
    let datesAndDayLetters = zip(Array(21...27), ["S", "M", "T", "W", "T", "F", "S"]).map { $0 }
    let currentDate = 25

    var body: some View {
        VStack {
            HStack {
                ForEach(datesAndDayLetters, id: \.0) { date, dayLetter in
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
