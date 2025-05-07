
//
//  TBSecondaryButton.swift
//  TimeBlockingApp
//
//  Created by Alex on 7/26/24.
//

import SwiftUI

enum TBSecondaryButtonStyle {
    case outline
    case filled

    var textColor: Color {
        switch self {
        case .outline:
            return .black
        case .filled:
            return .white
        }
    }

    var backgroundColor: Color {
        switch self {
        case .outline:
            return .white
        case .filled:
            return .blue // Assuming .blue for now, can be customized later
        }
    }

    var borderColor: Color {
        switch self {
        case .outline:
            return .black
        case .filled:
            return .clear // Or match backgroundColor if a border is always desired
        }
    }
    
    var borderWidth: CGFloat {
        switch self {
        case .outline:
            return 0.5
        case .filled:
            return 0.0 // No border for filled style by default
        }
    }
}

struct TBSecondaryButton: View {
    let text: String
    let style: TBSecondaryButtonStyle
    let action: () -> Void

    init(
        text: String,
        style: TBSecondaryButtonStyle = .outline,
        action: @escaping () -> Void
    ) {
        self.text = text
        self.style = style
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            Text(text)
                .font(.system(size: 14))
                .foregroundColor(style.textColor)
                .padding(.vertical, 6)
                .padding(.horizontal, 15)
                .frame(maxWidth: .infinity)
        }
        .background(style.backgroundColor)
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(style.borderColor, lineWidth: style.borderWidth)
        )
    }
}

#Preview {
    VStack(spacing: 20) {
        TBSecondaryButton(
            text: "Remove Account",
            style: .outline
        ) {}

        TBSecondaryButton(
            text: "Add Account",
            style: .filled
        ) {}
        
        TBSecondaryButton(
            text: "Custom Action",
            style: .filled
        ) {}
        .padding(.horizontal) // Example of how it might be used in a wider context
    }
    .padding()
}
