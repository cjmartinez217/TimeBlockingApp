//
//  TBInfoItem.swift
//  TimeBlockingApp
//
//  Created by Christian Martinez on 5/8/25.
//

import SwiftUI

enum TBInfoItemSize {
    case small
    case medium
    case large

    var iconSize: TBIconSize {
        switch self {
        case .small: return .small
        case .medium: return .medium
        case .large: return .large
        }
    }

    var textSize: TBTextSize {
        switch self {
        case .small: return .size100
        case .medium: return .size200
        case .large: return .size300
        }
    }

    var spacing: CGFloat {
        switch self {
        case .small: return 8
        case .medium: return 10
        case .large: return 12
        }
    }
}

enum TBInfoItemWeight {
    case light
    case medium
    case bold

    var iconWeight: TBIconWeight {
        switch self {
        case .light:
            return .thin
        case .medium:
            return .regular
        case .bold:
            return .bold
        }
    }

    var textWeight: TBTextWeight {
        switch self {
        case .light:
            return .light
        case .medium:
            return .medium
        case .bold:
            return .bold
        }
    }
}

struct TBInfoItem: View {
    let icon: String
    let text: String
    let size: TBInfoItemSize
    let weight: TBInfoItemWeight
    let action: (() -> Void)?

    init(
        icon: String,
        text: String,
        size: TBInfoItemSize = .medium,
        weight: TBInfoItemWeight = .medium,
        action: (() -> Void)? = nil
    ) {
        self.icon = icon
        self.text = text
        self.size = size
        self.weight = weight
        self.action = action
    }

    var body: some View {
        let content = HStack(spacing: size.spacing) {
            TBIcon(icon, size: size.iconSize, weight: weight.iconWeight)
            TBText(text, size: size.textSize, weight: weight.textWeight)
        }

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
            icon: "info.circle",
            text: "App Version 1.0.0",
            weight: .bold
        )

        TBInfoItem(
            icon: "person.crop.circle",
            text: "Accounts",
            size: .small,
            action: { print("Accounts tapped") }
        )

        TBInfoItem(
            icon: "person.crop.circle",
            text: "Accounts",
            size: .large,
            weight: .light,
            action: { print("Accounts tapped") }
        )
    }
    .padding()
}
