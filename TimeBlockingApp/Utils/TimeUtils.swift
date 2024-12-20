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
            let dayNumber = getDay(from: date)
            return (dayNumber, dayLetter)
        }
    }

    /// Returns the full day name (e.g., "Thursday") for the given date
    /// - Parameter date: The date to format (defaults to the current date)
    static func getDayOfWeek(from date: Date = Date()) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE" // Full day name
        return formatter.string(from: date)
    }

    /// Returns the full month name (e.g., "July") for the given date
    /// - Parameter date: The date to format (defaults to the current date)
    static func getMonth(from date: Date = Date()) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM" // Full month name
        return formatter.string(from: date)
    }

    /// Returns the day of the month (e.g., "25") for the given date
    /// - Parameter date: The date to format (defaults to the current date)
    static func getDay(from date: Date = Date()) -> Int {
        return Calendar.current.component(.day, from: date)
    }
}
