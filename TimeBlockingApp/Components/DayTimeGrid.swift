//
//  DayTimeGrid.swift
//  TimeBlockingApp
//
//  Created by Christian Martinez on 10/17/24.
//

import SwiftUI

struct DayTimeGrid: View {
    let hours = Array(0...23)

    var body: some View {
        ScrollView {
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
                            Divider()
                                .background(Color.gray)
                                .frame(height: 70)
                            Spacer()
                        }
                        .frame(height: 70)
                    }
                }
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
    DayTimeGrid()
}
