//
//  SampleData.swift
//  Demo
//
//  Created by Shohe Ohtani on 2022/05/21.
//

import Foundation
import SwiftUI

class SampleData {
    private let firstDate = Date().set(hour: Date().hour, minute: 0, second: 0)
    private let secondDate = Date().set(day: Date().day+1, hour: Date().hour-2, minute: 0, second: 0)
    private let thirdDate = Date().set(day: Date().day+2, hour: Date().hour+1, minute: 0, second: 0)
    
    lazy var events: [EventModel] = [
        EventModel(title: "One", startDate: firstDate, endDate: firstDate.add(component: .hour, value: 1)),
        EventModel(title: "AllDay-1", startDate: firstDate.startOfDay, endDate: firstDate.endOfDay, isAllDay: true, color: Color.google.emerald),
        EventModel(title: "AllDay-2", startDate: firstDate.startOfDay, endDate: firstDate.endOfDay, isAllDay: true, color: Color.google.emerald),
        EventModel(title: "AllDay-3", startDate: firstDate.startOfDay, endDate: firstDate.endOfDay, isAllDay: true, color: Color.google.flamingo),
        EventModel(title: "AllDay-4", startDate: firstDate.startOfDay, endDate: firstDate.endOfDay, isAllDay: true, color: Color.google.grape),

        EventModel(title: "Two", startDate: secondDate, endDate: secondDate.add(component: .hour, value: 4), color: Color.google.banana),
        EventModel(title: "AllDay-5", startDate: secondDate.startOfDay, endDate: secondDate.endOfDay, isAllDay: true),

        EventModel(title: "Three", startDate: thirdDate, endDate: thirdDate.add(component: .hour, value: 2), color: Color.google.graphite),
        EventModel(title: "AllDay-6", startDate: thirdDate.startOfDay, endDate: thirdDate.endOfDay, isAllDay: true),
        EventModel(title: "AllDay-7", startDate: thirdDate.startOfDay, endDate: thirdDate.endOfDay, isAllDay: true),
    ]
}

extension Color {
    struct google {
        static var defaultColor = Color(#colorLiteral(red: 0.2666666667, green: 0.5960784314, blue: 0.8784313725, alpha: 1))
        static var tomato = Color(#colorLiteral(red: 0.7647058824, green: 0.1607843137, blue: 0.1137254902, alpha: 1))
        static var tangerine = Color(#colorLiteral(red: 0.8823529412, green: 0.368627451, blue: 0.2039215686, alpha: 1))
        static var banana = Color(#colorLiteral(red: 0.9333333333, green: 0.7568627451, blue: 0.2980392157, alpha: 1))
        static var basil = Color(#colorLiteral(red: 0.2235294118, green: 0.4941176471, blue: 0.2823529412, alpha: 1))
        static var sage = Color(#colorLiteral(red: 0.3607843137, green: 0.7019607843, blue: 0.4941176471, alpha: 1))
        static var emerald = Color(#colorLiteral(red: 0.2549019608, green: 0.5764705882, blue: 0.5333333333, alpha: 1))
        static var peacock = Color(#colorLiteral(red: 0.2666666667, green: 0.5960784314, blue: 0.8784313725, alpha: 1))
        static var blueberry = Color(#colorLiteral(red: 0.2588235294, green: 0.3176470588, blue: 0.6823529412, alpha: 1))
        static var lavender = Color(#colorLiteral(red: 0.4823529412, green: 0.5176470588, blue: 0.7725490196, alpha: 1))
        static var grape = Color(#colorLiteral(red: 0.5098039216, green: 0.1764705882, blue: 0.6431372549, alpha: 1))
        static var flamingo = Color(#colorLiteral(red: 0.8470588235, green: 0.5058823529, blue: 0.4666666667, alpha: 1))
        static var graphite = Color(#colorLiteral(red: 0.3803921569, green: 0.3803921569, blue: 0.3803921569, alpha: 1))
    }
}
