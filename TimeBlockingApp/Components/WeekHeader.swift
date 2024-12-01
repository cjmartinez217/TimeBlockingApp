//
//  WeekHeader.swift
//  TimeBlockingApp
//
//  Created by Christian Martinez on 11/21/24.
//

import SwiftUI

struct WeekHeader: View {
    let datesAndDayLetters = zip(Array(21...27), ["S", "M", "T", "W", "T", "F", "S"]).map { $0 }

    var body: some View {
        VStack {
            HStack {
                ForEach(datesAndDayLetters, id: \.0) { date, dayLetter in
                    VStack {
                        Text(dayLetter)
                        Text("\(date)")
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    WeekHeader()
}
