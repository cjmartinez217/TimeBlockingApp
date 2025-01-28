//
//  EventBlock.swift
//  TimeBlockingApp
//
//  Created by Christian Martinez on 1/20/25.
//

import SwiftUI

struct EventBlock: View {
    let event: EventModel

    var body: some View {
        let durationInMinutes = event.endDate.timeIntervalSince(event.startDate) / 60
        let eventHeight =  durationInMinutes / 60 * Constants.hourHeight

        VStack {
            VStack(alignment: .leading) {
                Text(event.title)
                    .font(.system(size: 16, weight: .bold))
                if let eventDescription = event.description {
                    Text(eventDescription)
                        .font(.system(size: 12))
                }
            }
            .padding(8)
        }
        .frame(height: eventHeight)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.blue)
        .cornerRadius(10)
    }
}

#Preview {
    EventBlock(event: EventModel(
        id: UUID(),
        title: "Test1",
        startDate: Calendar.current.date(byAdding: .hour, value: 0, to: Date())!,
        endDate: Calendar.current.date(byAdding: .hour, value: 2, to: Date())!,
        description: "testing"
    ))
}
