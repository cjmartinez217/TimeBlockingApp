//
//  EventBlock.swift
//  TimeBlockingApp
//
//  Created by Christian Martinez on 1/20/25.
//

import SwiftUI

struct EventBlock: View {
    let event: EventModel
    var height: CGFloat?
    @State private var showingDetail = false

    var body: some View {
        let durationInMinutes = event.endDate.timeIntervalSince(event.startDate) / 60
        let eventHeight =  durationInMinutes / 60 * Constants.hourHeight

        Button(action: {
            showingDetail = true
        }) {
            VStack(alignment: .leading) {
                Text(event.title)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundStyle(.white)
                    .padding(.leading, 12)
                    .padding(.top, 4)
                Spacer()
            }
            .frame(height: height ?? eventHeight)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.blue)
            .cornerRadius(6)
            .fullScreenCover(isPresented: $showingDetail) {
                EventDetailView(event: event)
            }
        }
    }
}

#Preview {
    EventBlock(event: EventModel(
        id: UUID(),
        title: "Test1",
        startDate: Calendar.current.date(byAdding: .hour, value: 0, to: Date())!,
        endDate: Calendar.current.date(byAdding: .hour, value: 1, to: Date())!,
        description: "testing"
    ))
}
