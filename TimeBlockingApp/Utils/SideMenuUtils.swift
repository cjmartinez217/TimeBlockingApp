//
//  File.swift
//  TimeBlockingApp
//
//  Created by Christian Martinez on 11/1/24.
//

enum SideMenuRowType: Int, CaseIterable {
    case day = 0
    case week
    case month

    var title: String {
        switch self {
        case .day:
            return "Day"
        case .week:
            return "Week"
        case .month:
            return "Month"
        }
    }

    var icon: String {
        switch self {
        case .day:
            return "rectangle.grid.1x2"
        case .week:
            return "rectangle.split.3x1"
        case .month:
            return "rectangle.split.3x3"
        }
    }
}
