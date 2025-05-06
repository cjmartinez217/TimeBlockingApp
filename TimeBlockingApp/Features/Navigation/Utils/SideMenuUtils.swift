//
//  SideMenuUtils.swift
//  TimeBlockingApp
//
//  Created by Christian Martinez on 11/1/24.
//

import SwiftUI

enum SideMenuRowType: Int, CaseIterable {
    case day = 0
    case week = 1
    case month = 2

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

    var numOfDays: Int? {
        switch self {
        case .day: return 1
        case .week: return 7
        case .month: return nil // Uses different view type
        }
    }
}

enum SideMenuPage: Identifiable {
    case accounts, settings, feedback

    var id: String {
        switch self {
        case .accounts: return "accounts"
        case .settings: return "settings"
        case .feedback: return "feedback"
        }
    }
}

struct SideMenuState {
    var isPresented: Bool
    var selectedTab: SideMenuRowType
}
