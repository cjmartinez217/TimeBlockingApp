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
    let icon: TBIcon?

    init(
        text: String,
        style: TBSecondaryButtonStyle = .outline,
        icon: TBIcon? = nil,
        action: @escaping () -> Void
    ) {
        self.text = text
        self.style = style
        self.icon = icon
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) { // Adjust spacing as needed
                if let icon {
                    icon
                }
                TBText(text, size: .size100)
            }
            .padding(.vertical, 6)
            .padding(.horizontal, 15)
            .frame(maxWidth: .infinity)
            .foregroundColor(style.textColor)
        }
        .background(style.backgroundColor)
        .cornerRadius(Constants.buttonCornerRadius)
        .overlay(
            RoundedRectangle(cornerRadius: Constants.buttonCornerRadius)
                .stroke(style.borderColor, lineWidth: style.borderWidth)
        )
    }
}

#Preview {
    VStack(spacing: 20) {
        TBSecondaryButton(
            text: "Remove Account",
            style: .outline,
            // For outline style, text is black, so default icon theme (.dark) is fine.
            icon: TBIcon("trash", size: .small),
            action: {}
        )
        .frame(width: 200)

        TBSecondaryButton(
            text: "Add Account",
            style: .filled,
            action: {}
        )
        .frame(width: 150)
        
        TBSecondaryButton(
            text: "Add Account with Icon",
            style: .filled,
             // For filled style, text is white, so icon theme should be .light.
            icon: TBIcon("plus.circle.fill", size: .small, theme: .light),
            action: {}
        )
        .frame(width: 200)


        TBSecondaryButton(
            text: "Custom Action",
            style: .filled
        ) {}
        .padding(.horizontal) // Example of how it might be used in a wider context
    }
    .padding()
}
