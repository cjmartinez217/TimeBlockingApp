//
//  WeekTimeGrid.swift
//  TimeBlockingApp
//
//  Created by Christian Martinez on 11/19/24.
//

import SwiftUI

struct WeekTimeGrid: View {
    var dateInWeek: Date = Date()
    @State private var currentTimePosition: CGFloat = 0

    let hours = Array(0...23)
    let hourHeight: CGFloat = 70
    private var currentDayIndex: Int {
        Calendar.current.component(.weekday, from: Date()) - 1
    }

    var body: some View {
        ZStack {
            HStack(spacing: 47) {
                ForEach(0..<7, id: \.self) { _ in
                    Divider()
                        .background(Color.gray)
                }
            }
            .padding(.leading, 22)
            ScrollView {
                ZStack {
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
                                }
                                .frame(height: 70)
                            }
                        }
                    }
                    .padding(.top, 10)

                    if (Calendar.current.isDateInToday(dateInWeek)) {
                        GeometryReader { geometry in
                            let dayWidth = (geometry.size.width - 60) / 7
                            
                            TimeBar()
                                .frame(width: dayWidth + 5)
                                .offset(
                                    x: CGFloat(currentDayIndex) * dayWidth + 60,
                                    y: currentTimePosition
                                )
                                .onAppear {
                                    updateCurrentTimePosition()
                                    TimeUtils.startTimer(onUpdate: updateCurrentTimePosition)
                                }
                                .animation(.none)
                        }
                    }
                }
            }
        }
    }

    func updateCurrentTimePosition() {
        currentTimePosition = TimeUtils.currentTimeYPosition(hourHeight: hourHeight, offset: 41)
    }
}

#Preview {
    WeekTimeGrid()
}
