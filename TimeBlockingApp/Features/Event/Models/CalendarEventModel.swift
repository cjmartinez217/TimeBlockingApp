//
//  CalendarEventModel.swift
//  TimeBlockingApp
//
//  Created by Christian Martinez on 1/15/25.
//

import Foundation
import SwiftUICore

struct EventModel: ICEventable {
    
    static func create(from eventable: EventModel?, state: EditState?) -> EventModel {
        if var model = eventable?.copy() {
            model.editState = state
            return model
        }
        return EventModel(title: "New", startDate: TimeUtils.getStartDate(), endDate: TimeUtils.getEndDate(), editState: state)
    }
    
    func copy() -> EventModel {
        var copy = EventModel(title: title, startDate: startDate, endDate: endDate, isAllDay: isAllDay, editState: editState, color: color)
        copy.id = id
        copy.intraStartDate = intraStartDate
        copy.intraEndDate = intraEndDate
        return copy
    }
    
    private(set) var id: String = UUID().uuidString
    var title: String
    var startDate: Date
    var endDate: Date
    var intraStartDate: Date
    var intraEndDate: Date
    var editState: EditState?
    var description: String?
    var isAllDay: Bool
    var color: Color?

    init(title: String, startDate: Date, endDate: Date, description: String = "", isAllDay: Bool = false, editState: EditState? = nil, color: Color? = Color.google.defaultColor) {
        self.title = title
        self.startDate = startDate
        self.endDate = endDate
        self.intraStartDate = startDate
        self.intraEndDate = endDate
        self.description = description
        self.isAllDay = isAllDay
        self.editState = editState
        self.color = color
    }
}

struct DayDateModel {
    let date: Date
    let events: [EventModel]
}

struct CalendarModel: Identifiable {
    let id = UUID()
    var name: String
    var email: String
    var isActive: Bool
}
