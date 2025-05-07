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
    let icon: Image
    let action: () -> Void
    let size: TBButtonSize
    let theme: TBButtonTheme
    let background: TBButtonBackground

    init(
        icon: Image,
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
                .resizable()
                .scaledToFit()
                .frame(width: size.dimension * 0.5, height: size.dimension * 0.5)
                .foregroundStyle(.black)
                .frame(minWidth: size.dimension, minHeight: size.dimension)
                .fontWeight(theme.weight)
        }
        .background(background.color)
        .clipShape(Capsule())
    }
}

#Preview {
    HStack(spacing: 20) {
        TBPrimaryButton(
            icon: Image(systemName: "plus"),
            size: .large,
            theme: .bold,
            background: .none
        ) {}

        TBPrimaryButton(
            icon: Image(systemName: "mic"),
            size: .medium,
            theme: .standard,
            background: .neutral
        ) {}

        TBPrimaryButton(
            icon: Image(systemName: "xmark"),
            size: .small,
            theme: .light,
            background: .highlight
        ) {}
    }
}
