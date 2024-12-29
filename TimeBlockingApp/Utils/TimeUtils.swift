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
    static func getWeekDates(date: Date = Date()) -> [(Int, String)] {
        let calendar = Calendar.current
        let today = date
        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: today))!
        return (0..<7).map { offset in
            guard let date = calendar.date(byAdding: .day, value: offset, to: startOfWeek) else { return (0, "") }
            let dayLetter = String(calendar.weekdaySymbols[calendar.component(.weekday, from: date) - 1].prefix(1))
            let dayNumber = getDay(date: date)
            return (dayNumber, dayLetter)
        }
    }

    /// Returns the full day name (e.g., "Thursday") for the given date
    /// - Parameter date: The date to format (defaults to the current date)
    static func getDayOfWeek(date: Date = Date()) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE" // Full day name
        return formatter.string(from: date)
    }

    /// Returns the full month name (e.g., "July") for the given date
    /// - Parameter date: The date to format (defaults to the current date)
    static func getMonth(date: Date = Date()) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM" // Full month name
        return formatter.string(from: date)
    }

    /// Returns the day of the month (e.g., "25") for the given date
    /// - Parameter date: The date to format (defaults to the current date)
    static func getDay(date: Date = Date()) -> Int {
        return Calendar.current.component(.day, from: date)
    }

    /// Returns the days for the current month's grid, including days from previous and next months
    /// - Parameters:
    ///   - date: The current date (defaults to `Date()`)
    ///   - calendar: The calendar to use (defaults to `Calendar.current`)
    /// - Returns: An array of `Date` objects representing the days in the grid
    static func getDaysForMonthGrid(date: Date = Date(), calendar: Calendar = Calendar.current) -> [Date] {
        var dates: [Date] = []

        // Get the start of the current month
        guard let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: date)) else {
            return dates
        }

        // Determine the weekday of the first day of the current month
        let weekdayOfFirstDay = calendar.component(.weekday, from: startOfMonth)

        // Add days from the previous month to fill the grid
        let daysFromPreviousMonth = weekdayOfFirstDay - 1
        for i in stride(from: daysFromPreviousMonth, through: 1, by: -1) {
            dates.append(calendar.date(byAdding: .day, value: -i, to: startOfMonth)!)
        }

        // Add days for the current month
        let range = calendar.range(of: .day, in: .month, for: startOfMonth)!
        for day in range {
            dates.append(calendar.date(byAdding: .day, value: day - 1, to: startOfMonth)!)
        }

        // Add days from the next month to fill the remaining grid
        let remainingDays = 42 - dates.count // Total slots in a 6x7 grid
        if let nextMonth = calendar.date(byAdding: .month, value: 1, to: startOfMonth) {
            for day in 0..<remainingDays {
                dates.append(calendar.date(byAdding: .day, value: day, to: nextMonth)!)
            }
        }

        return dates
    }
}
