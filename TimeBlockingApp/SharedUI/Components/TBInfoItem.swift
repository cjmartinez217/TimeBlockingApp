//
//  TBInfoItem.swift
//  TimeBlockingApp
//
//  Created by Christian Martinez on 5/8/25.
//

import SwiftUI

struct TBInfoItem: View {
    let icon: TBIcon
    let text: TBText
    let action: (() -> Void)?

    init(
        icon: TBIcon,
        text: TBText,
        action: (() -> Void)? = nil
    ) {
        self.icon = icon
        self.text = text
        self.action = action
    }

    var body: some View {
        let content = HStack(spacing: 10) {
            icon
            text
        }
        .accessibilityElement(children: .combine)

        if let action = action {
            Button(action: action) {
                content
            }
            .buttonStyle(.plain)
        } else {
            content
        }
    }
}

#Preview {
    VStack(spacing: 16) {
        TBInfoItem(
            icon: TBIcon("info.circle", size: .medium, style: .regular, theme: .dark),
            text: TBText("App Version 1.0.0", size: .size300, weight: .medium)
        )

        TBInfoItem(
            icon: TBIcon("person.crop.circle", style: .bold),
            text: TBText("Accounts", size: .size300, weight: .bold),
            action: { print("Accounts tapped") }
        )
    }
    .padding()
}
