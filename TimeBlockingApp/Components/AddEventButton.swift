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
                Image(systemName: "plus")
                    .foregroundStyle(isDisabled ? Color(red: 0.3, green: 0.3, blue: 0.3) : Color(.black))
                    .font(.system(size: 36, weight: .bold, design: .rounded))
            }
        }
        .disabled(isDisabled)
        .sheet(isPresented: $isAddEventPresented) {
            EventFormView(isAddEventPresented: $isAddEventPresented)
        }
    }
}

#Preview {
    AddEventButton(isDisabled: .constant(false))
}
