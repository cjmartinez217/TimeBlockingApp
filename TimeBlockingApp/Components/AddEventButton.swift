//
//  AddEventButton.swift
//  TimeBlockingApp
//
//  Created by Christian Martinez on 10/18/24.
//

import SwiftUI

struct AddEventButton: View {
    @State var isAddEventPresented: Bool = false

    var body: some View {
        Button {
            isAddEventPresented.toggle()
        } label: {
            ZStack {
                Circle()
                    .fill(Color(red: 1, green: 0.6, blue: 0.6))
                    .frame(width: 64, height: 64)
                Image(systemName: "plus")
                    .foregroundStyle(Color(.white))
                    .font(.system(size: 38, weight: .bold, design: .rounded))
            }
        }
        .sheet(isPresented: $isAddEventPresented) {
            AddEventView(isAddEventPresented: $isAddEventPresented)
        }
    }
}

#Preview {
    AddEventButton()
}
