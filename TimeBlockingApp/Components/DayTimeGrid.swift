//
//  DayTimeGrid.swift
//  TimeBlockingApp
//
//  Created by Christian Martinez on 10/17/24.
//

import SwiftUI

struct DayTimeGrid: View {
    var displayDate = Date()
    let events: [EventModel]

    @State private var currentTimePosition: CGFloat = 0
    let hours = Array(0...23)

    var body: some View {
        ScrollView {
            ZStack(alignment: .topLeading) {
                VStack(spacing: 0) {
                    ForEach(hours, id: \.self) { hour in
                        ZStack(alignment: .topLeading) {
                            Divider()
                                .background(Color.gray)
                                .offset(y: 37)
                                .padding(.leading, 60)
                            HStack {
                                Text(TimeUtils.formatTime(hour))
                                    .frame(width: 50, alignment: .trailing)
                                    .padding(.leading, 8)
                                Divider()
                                    .background(Color.gray)
                                    .frame(height: Constants.hourHeight)
                                Spacer()
                            }
                            .frame(height: Constants.hourHeight)
                        }
                    }
                }
                ForEach(events) { event in
                    EventBlock(event: event)
                        .padding(.top, (CGFloat(Calendar.current.component(.hour, from: event.startDate)) + CGFloat(Calendar.current.component(.minute, from: event.startDate)) / 60) * Constants.hourHeight)
                        .padding(.leading, 66)
                        .offset(y: 37)
                }
                if (Calendar.current.isDateInToday(displayDate)) {
                    TimeBar()
                        .padding(.leading, 60)
                        .offset(y: currentTimePosition)
                        .onAppear {
                            updateCurrentTimePosition()
                            TimeUtils.startTimer(onUpdate: updateCurrentTimePosition)
                        }
                        .animation(.none)
                }
            }
        }
    }

    func updateCurrentTimePosition() {
        currentTimePosition = TimeUtils.currentTimeYPosition(hourHeight: Constants.hourHeight, offset: 30)
    }
}

#Preview {
    DayTimeGrid(events: [
        EventModel(
            id: UUID(),
            title: "Test1",
            startDate: Calendar.current.date(byAdding: .hour, value: 0, to: Date())!,
            endDate: Calendar.current.date(byAdding: .hour, value: 2, to: Date())!,
            description: "testing"
        )
    ])
}
