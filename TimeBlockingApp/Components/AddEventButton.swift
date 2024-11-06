//
//  AddEventButton.swift
//  TimeBlockingApp
//
//  Created by Christian Martinez on 10/18/24.
//

import SwiftUI

struct AddEventButton: View {
    @State var isAddEventPresented: Bool = false
    @Binding var isDisabled: Bool

    var body: some View {
        Button {
            isAddEventPresented.toggle()
        } label: {
            ZStack {
                Circle()
                    .fill(isDisabled ? Color(red: 0.75, green: 0.55, blue: 0.55) : Color(red: 1, green: 0.6, blue: 0.6))
                    .frame(width: 64, height: 64)
                Image(systemName: "plus")
                    .foregroundStyle(Color(.white))
                    .font(.system(size: 38, weight: .bold, design: .rounded))
            }
        }
        .disabled(isDisabled)
        .sheet(isPresented: $isAddEventPresented) {
            AddEventView(isAddEventPresented: $isAddEventPresented)
        }
    }
}

#Preview {
    AddEventButton(isDisabled: .constant(false))
}
