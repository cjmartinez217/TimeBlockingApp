//
//  MonthGrid.swift
//  TimeBlockingApp
//
//  Created by Christian Martinez on 12/10/24.
//

import SwiftUI

struct MonthGrid: View {
    private let days: [Date] = TimeUtils.getDaysForMonthGrid()

    var body: some View {
        ZStack {
            HStack {
                ForEach(0..<7, id: \.self) { _ in
                    Divider()
                        .background(Color.gray)
                        .padding(.top, 1)
                    Spacer()
                }
            }
            Grid {
                ForEach(0..<5, id: \.self) { row in
                    Divider()
                        .background(Color.gray)
                        .frame(maxHeight: 1)
                    GridRow {
                        ForEach(0..<7, id: \.self) { column in
                            let index = row * 7 + column
                            Text("\(TimeUtils.getDay(date: days[index]))")
                        }
                    }
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    MonthGrid()
}
