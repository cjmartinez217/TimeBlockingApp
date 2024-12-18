//
//  TimeBar.swift
//  TimeBlockingApp
//
//  Created by Christian Martinez on 12/18/24.
//

import SwiftUI

struct TimeBar: View {
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            Circle()
                .frame(width: 12, height: 12)
            Rectangle()
                .fill(Color.black)
                .frame(height: 2)
        }
    }
}

#Preview {
    TimeBar()
}
