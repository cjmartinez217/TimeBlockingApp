//
//  AIButton.swift
//  TimeBlockingApp
//
//  Created by Christian Martinez on 12/12/24.
//

import SwiftUI

struct AIButton: View {
    @Binding var isDisabled: Bool
    
    var body: some View {
        Button {
            print("clicked")
        } label: {
            ZStack {
                Circle()
                    .fill(isDisabled ? Color.gray : Color(red: 0.9, green: 0.9, blue: 0.9))
                    .frame(width: 64, height: 64)
                    .animation(.easeInOut, value: isDisabled)
                    .opacity(0.8)
                Circle()
                    .stroke(
                        LinearGradient(
                            gradient: Gradient(colors: isDisabled
                                ? [Color(red: 0.8, green: 0.1, blue: 0.1), Color(red: 0.1, green: 0.1, blue: 0.6)]
                                : [Color.red, Color.blue]
                            ),
                            startPoint: .topTrailing,
                            endPoint: .bottomLeading),
                        style: StrokeStyle(lineWidth: 8)
                    )
                    .frame(width: 36, height: 36)
                    .animation(.easeInOut, value: isDisabled)
            }
        }
        .disabled(isDisabled)
    }
}

#Preview {
    AIButton(isDisabled: .constant(false))
}
