//
//  DayHeaderView.swift
//  TimeBlockingApp
//
//  Created by Christian Martinez on 10/12/24.
//

import SwiftUI

struct DayHeader: View {
    var body: some View {
        HStack {
            Image(systemName: "line.horizontal.3")
                .font(.system(size: 38, weight: .bold, design: .rounded))
            VStack(alignment: .leading) {
                Text("Thursday")
                    .font(.system(size: 26, weight: .medium, design: .rounded))
                Text("July 25")
                    .font(.system(size: 18, weight: .light, design: .rounded))
            }
            Spacer()
        }
    }
}

#Preview {
    VStack {
        DayHeader()
        Spacer()
    }
}
