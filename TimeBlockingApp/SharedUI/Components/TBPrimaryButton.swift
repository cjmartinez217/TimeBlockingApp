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
}

enum TBButtonBackground {
    case none
    case neutral
    case highlight
    case destructive

    var color: Color {
        switch self {
        case .none:
            return .clear
        case .neutral:
            return .backgroundNeutral
        case .highlight:
            return .backgroundHighlight
        case .destructive:
            return Color.red.opacity(0.9)
        }
    }
}

enum TBButtonTheme {
    case light
    case standard
    case bold

    var weight: Font.Weight {
        switch self {
        case .light: return .light
        case .standard: return .regular
        case .bold: return .semibold
        }
    }
}

struct TBPrimaryButton: View {
    let icon: TBIcon
    let action: () -> Void
    let size: TBButtonSize
    let theme: TBButtonTheme
    let background: TBButtonBackground

    init(
        icon: TBIcon,
        size: TBButtonSize = .medium,
        theme: TBButtonTheme = .standard,
        background: TBButtonBackground = .none,
        action: @escaping () -> Void
    ) {
        self.icon = icon
        self.size = size
        self.theme = theme
        self.background = background
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            icon
        }
        .padding(size.dimension * 0.25)
        .background(background.color)
        .clipShape(Circle())
    }
}

#Preview {
    HStack(spacing: 20) {
        TBPrimaryButton(
            icon: TBIcon("plus", size: .small),
            size: .small,
            theme: .bold,
            background: .none
        ) {}

        TBPrimaryButton(
            icon: TBIcon("mic"),
            size: .medium,
            theme: .standard,
            background: .neutral
        ) {}

        TBPrimaryButton(
            icon: TBIcon("xmark", size: .large, theme: .light),
            size: .large,
            theme: .light,
            background: .highlight
        ) {}
    }
}
