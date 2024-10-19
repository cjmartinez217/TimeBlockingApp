//
//  AddEventButton.swift
//  TimeBlockingApp
//
//  Created by Christian Martinez on 10/18/24.
//

import SwiftUI

struct AddEventButton: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(Color(red: 1, green: 0.6, blue: 0.6))
                .frame(width: 64, height: 64)
            Image(systemName: "plus")
                .foregroundStyle(Color(.white))
                .font(.system(size: 38, weight: .bold, design: .rounded))
        }
    }
}

#Preview {
    AddEventButton()
}
