//
//  MonthGrid.swift
//  TimeBlockingApp
//
//  Created by Christian Martinez on 12/10/24.
//

import SwiftUI

struct MonthGrid: View {
    let date: Date
    private let days: [Date]
    let onDaySelected: (Date) -> Void

    init(date: Date = Date(), onDaySelected: @escaping (Date) -> Void) {
        self.date = date
        self.days = TimeUtils.getDaysForMonthGrid(date: date)
        self.onDaySelected = onDaySelected
    }

    var body: some View {
        ZStack {
            HStack {
                ForEach(0..<7, id: \.self) { _ in
                    Divider()
                        .background(Color.gray)
                        .padding(.top, 1)
                    Spacer()
                }
            }
            Grid {
                ForEach(0..<6, id: \.self) { row in
                    Divider()
                        .background(Color.gray)
                        .frame(maxHeight: 1)
                    GridRow {
                        ForEach(0..<7, id: \.self) { column in
                            let index = row * 7 + column
                            let day = days[index]
                            DayCell(
                                day: day,
                                isToday: Calendar.current.isDate(day, inSameDayAs: Date()),
                                isInMonth: Calendar.current.isDate(day, equalTo: date, toGranularity: .month),
                                onTap: { onDaySelected(day) }
                            )
                        }
                    }
                    Spacer()
                }
            }
        }
    }
}

struct DayCell: View {
    let day: Date
    let isToday: Bool
    let isInMonth: Bool
    let onTap: () -> Void

    var body: some View {
        let foregroundColor: Color = {
            switch (isToday, isInMonth) {
            case (true, _):
                return Color.white
            case (false, false):
                return Color.gray
            default:
                return Color.black
            }
        } ()
        ZStack {
            Circle()
                .fill(isToday ? Color("PrimaryThemeColor") : Color.white)
                .frame(width: 32, height: 32)
            Text("\(TimeUtils.getDay(date: day))")
                .foregroundColor(foregroundColor)
        }
        .onTapGesture {
            onTap()
        }
    }
}

#Preview {
    MonthGrid(onDaySelected: { _ in })
}
