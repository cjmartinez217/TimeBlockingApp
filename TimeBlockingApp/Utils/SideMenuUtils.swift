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
}
