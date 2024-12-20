//
//  DayTimeGrid.swift
//  TimeBlockingApp
//
//  Created by Christian Martinez on 10/17/24.
//

import SwiftUI

struct DayTimeGrid: View {
    let hours = Array(0...23)
    @State private var currentTimePosition: CGFloat = 0
    let hourHeight: CGFloat = 70

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
                                    .frame(height: hourHeight)
                                Spacer()
                            }
                            .frame(height: hourHeight)
                        }
                    }
                }

                TimeBar()
                    .padding(.leading, 60)
                    .offset(y: currentTimePosition)
                    .onAppear {
                        updateCurrentTimePosition()
                        TimeUtils.startTimer(onUpdate: updateCurrentTimePosition)
                    }
            }
        }
    }

    func updateCurrentTimePosition() {
        currentTimePosition = TimeUtils.currentTimeYPosition(hourHeight: hourHeight, offset: 30)
    }
}

#Preview {
    DayTimeGrid()
}
