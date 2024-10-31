//
//  AddEventView.swift
//  TimeBlockingApp
//
//  Created by Christian Martinez on 10/31/24.
//

import SwiftUI

struct AddEventView: View {
    @Binding var isAddEventPresented: Bool

    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Button(action: {
                        isAddEventPresented.toggle()
                    }) {
                        Text("Cancel")
                    }
                    Spacer()
                    Text("Save")
                }
                .padding(.all)
                Spacer()
            }
            Text("Add Event Modal")
        }
    }
}

#Preview {
    AddEventView(isAddEventPresented: .constant(true))
}
