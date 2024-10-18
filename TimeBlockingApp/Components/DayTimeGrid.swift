//
//  DayTimeGrid.swift
//  TimeBlockingApp
//
//  Created by Christian Martinez on 10/17/24.
//

import SwiftUI

struct DayTimeGrid: View {
    // List of hours to display
        let hours = Array(0...23)  // Represents 5 AM to 1 PM

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                ForEach(hours, id: \.self) { hour in
                    ZStack(alignment: .topLeading) {
                        // Horizontal divider behind the content
                        Divider()
                            .background(Color.gray)
                            .offset(y: 37) // Center the line with respect to the row height
                            .padding(.leading, 60)

                        HStack {
                            // Time label
                            Text(formatTime(hour))
                                .frame(width: 50, alignment: .trailing)
                                .padding(.leading, 8)

                            Divider()
                                .frame(height: 70)

                            // Empty space for potential events
                            Spacer()
                        }
                        .frame(height: 70) // Height of each row
                    }
                }
            }
        }
    }

        // Helper function to format time
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
