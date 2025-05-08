//
//  TBIcon.swift
//  TimeBlockingApp
//
//  Created by Christian Martinez on 5/8/25.
//

import SwiftUI

enum TBIconSize {
    case small
    case medium
    case large
    case xLarge

    var dimension: CGFloat {
        switch self {
        case .small:   return 16
        case .medium:  return 24
        case .large:   return 32
        case .xLarge:  return 48
        }
    }
}

enum TBIconStyle {
    case thin
    case regular
    case bold

    var weight: Font.Weight {
        switch self {
        case .thin:    return .thin
        case .regular: return .regular
        case .bold:    return .bold
        }
    }
}

enum TBIconTheme {
    case light
    case dark

    var color: Color {
        switch self {
        case .light: return .white
        case .dark:  return .black
        }
    }
}

struct TBIcon: View {
    private let name: String
    private let size: TBIconSize
    private let style: TBIconStyle
    private let theme: TBIconTheme

    init(
        _ name: String,
        size: TBIconSize = .medium,
        style: TBIconStyle = .regular,
        theme: TBIconTheme = .dark
    ) {
        self.name = name
        self.size = size
        self.style = style
        self.theme = theme
    }

    var body: some View {
        Image(systemName: name)
            .font(.system(size: size.dimension, weight: style.weight))
            .foregroundColor(theme.color)
    }
}

#Preview {
    HStack(spacing: 20) {
        TBIcon("plus", size: .small)
        TBIcon("plus", size: .medium)
        TBIcon("plus", size: .large)
        TBIcon("plus", size: .xLarge, style: .bold)
        TBIcon("star.fill", theme: .dark)
        TBIcon("heart", size: .medium, style: .thin, theme: .dark)
    }
    .padding()
}
