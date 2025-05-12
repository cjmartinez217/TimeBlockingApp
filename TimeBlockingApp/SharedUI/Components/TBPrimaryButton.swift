//
//  TBPrimaryButton.swift
//  TimeBlockingApp
//
//  Created by Christian Martinez on 4/25/25.
//

import SwiftUI

enum TBButtonSize {
    case small
    case medium
    case large

    var dimension: CGFloat {
        switch self {
        case .small: return Constants.buttonSizeSmall
        case .medium: return Constants.buttonSizeMedium
        case .large: return Constants.buttonSizeLarge
        }
    }

    var iconSize: TBIconSize {
        switch self {
        case .small: return .small
        case .medium: return .medium
        case .large: return .large
        }
    }
}

enum TBButtonTheme {
    case none
    case neutral
    case highlight

    var color: Color {
        switch self {
        case .none:
            return .clear
        case .neutral:
            return .backgroundNeutral
        case .highlight:
            return .backgroundHighlight
        }
    }
}

enum TBButtonWeight {
    case light
    case standard
    case bold

    var iconWeight: TBIconWeight {
        switch self {
        case .light: return .thin
        case .standard: return .regular
        case .bold: return .bold
        }
    }
}

struct TBPrimaryButton: View {
    let icon: String
    let action: () -> Void
    let size: TBButtonSize
    let weight: TBButtonWeight
    let theme: TBButtonTheme

    init(
        icon: String,
        size: TBButtonSize = .medium,
        weight: TBButtonWeight = .standard,
        theme: TBButtonTheme = .none,
        action: @escaping () -> Void
    ) {
        self.icon = icon
        self.size = size
        self.weight = weight
        self.theme = theme
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            TBIcon(
                icon,
                size: size.iconSize,
                weight: weight.iconWeight,
            )
        }
        .padding(size.dimension * 0.25)
        .background(theme.color)
        .clipShape(Circle())
    }
}

#Preview {
    HStack(spacing: 20) {
        TBPrimaryButton(
            icon: "plus",
            size: .small,
            weight: .bold,
            theme: .none
        ) {}

        TBPrimaryButton(
            icon: "mic",
            size: .medium,
            weight: .standard,
            theme: .neutral
        ) {}

        TBPrimaryButton(
            icon: "xmark",
            size: .large,
            weight: .light,
            theme: .highlight
        ) {}
    }
}
