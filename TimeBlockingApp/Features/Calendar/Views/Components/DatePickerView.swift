//
//  DatePickerView.swift
//  TimeBlockingApp
//
//  Created by Christian Martinez on 1/24/25.
//

import SwiftUI

struct DatePickerView: View {
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d, yyyy"
        return formatter
    }

    private var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter
    }

    @Binding var selection: Date
    var minDate: Date?
    let displayedComponents: DatePicker.Components

    private var label: String {
        switch displayedComponents {
        case .date:
            return dateFormatter.string(from: selection)
        case .hourAndMinute:
            return timeFormatter.string(from: selection)
        default:
            return ""
        }
    }

    var body: some View {
        ZStack {
            DatePicker(
                "",
                selection: $selection,
                in: (minDate ?? .distantPast)...,
                displayedComponents: displayedComponents
            )
            .labelsHidden()
            .opacity(0.015)

            Text(label)
                .underline(displayedComponents == .hourAndMinute)
                .allowsHitTesting(false)
        }
    }
}

#Preview {
    DatePickerView(
        selection: .constant(Date()),
        displayedComponents: .date
    )
}
