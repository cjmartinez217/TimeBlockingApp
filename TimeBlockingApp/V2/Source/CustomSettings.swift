//
//  CustomSettings.swift
//  TimeBlockingApp
//
//  Created by Christian Martinez on 3/26/25.
//

import SwiftUI

class CustomSettings: ICSettings {

    @Published public var numOfDays: Int = 1
    @Published public var initDate: Date = Date()
    @Published public var scrollType: ScrollType = .pageScroll
    @Published public var moveTimeMinInterval: Int = 15
    @Published public var timeRange: (startTime: Int, endTime: Int) = (1, 23)
    @Published public var withVibrateFeedback: Bool = true
    @Published public var datePosition: ICViewUI.DatePosition = .left

    required public init() {}

    init(numOfDays: Int, setDate: Date) {
        self.numOfDays = numOfDays
        initDate = setDate
        scrollType = (numOfDays == 1 || numOfDays == 7) ? .pageScroll : .sectionScroll
    }

    func updateScrollType(numOfDays: Int) {
        self.numOfDays = numOfDays
        scrollType = (numOfDays == 1 || numOfDays == 7) ? .pageScroll : .sectionScroll
    }
}
