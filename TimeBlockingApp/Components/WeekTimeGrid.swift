//
//  WeekTimeGrid.swift
//  TimeBlockingApp
//
//  Created by Christian Martinez on 11/19/24.
//

import SwiftUI

struct WeekTimeGrid: View {
    let hours = Array(0...23)

    var body: some View {
        ScrollView {
            ZStack {
                HStack(spacing: 47) {
                    ForEach(0..<7, id: \.self) { _ in
                        Divider()
                            .background(Color.gray)
                    }
                }
                .padding(.leading, 22)
                VStack(spacing: 0) {
                    ForEach(hours, id: \.self) { hour in
                        ZStack(alignment: .topLeading) {
                            Divider()
                                .background(Color.gray)
                                .offset(y: 37)
                                .padding(.leading, 60)

                            HStack {
                                Text(formatTime(hour))
                                    .frame(width: 50, alignment: .trailing)
                                    .padding(.leading, 8)
                            }
                            .frame(height: 70)
                        }
                    }
                }
                .padding(.top, 10)
            }
        }
    }

    func formatTime(_ hour: Int) -> String {
        if hour == 0 {
            return "12 AM"
        }
        else if hour < 12 {
            return "\(hour) AM"
        } else if hour == 12 {
            return "12 PM"
        } else {
            return "\(hour - 12) PM"
        }
    }
}

#Preview {
    WeekTimeGrid()
}
