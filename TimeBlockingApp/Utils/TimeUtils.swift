//
//  TimeUtils.swift
//  TimeBlockingApp
//
//  Created by Christian Martinez on 12/18/24.
//

import Foundation

struct TimeUtils {
    /// Formats the given hour into a readable 12-hour format with AM/PM
    static func formatTime(_ hour: Int) -> String {
        if hour == 0 {
            return "12 AM"
        } else if hour < 12 {
            return "\(hour) AM"
        } else if hour == 12 {
            return "12 PM"
        } else {
            return "\(hour - 12) PM"
        }
    }

    /// Calculates the Y-position of the current time based on hour height
    /// - Parameters:
    ///   - hourHeight: The height of one hour block
    static func currentTimeYPosition(hourHeight: CGFloat, offset: CGFloat = 0) -> CGFloat {
        let calendar = Calendar.current
        let currentHour = calendar.component(.hour, from: Date())
        let currentMinute = calendar.component(.minute, from: Date())

        let minuteHeight = hourHeight / 60
        return CGFloat(currentHour) * hourHeight + CGFloat(currentMinute) * minuteHeight + offset
    }

    static func startTimer(onUpdate: @escaping () -> Void) {
        Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { _ in
            onUpdate()
        }
    }

    /// Returns an array of tuples representing the current week's days
    /// - Returns: [(Day number, Day letter)]
    static func getWeekDates() -> [(Int, String)] {
        let calendar = Calendar.current
        let today = Date()
        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: today))!
        return (0..<7).map { offset in
            guard let date = calendar.date(byAdding: .day, value: offset, to: startOfWeek) else { return (0, "") }
            let dayLetter = String(calendar.weekdaySymbols[calendar.component(.weekday, from: date) - 1].prefix(1))
            let dayNumber = calendar.component(.day, from: date)
            return (dayNumber, dayLetter)
        }
    }
}
