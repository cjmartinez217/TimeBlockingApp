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

enum TBIconWeight {
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
    private let weight: TBIconWeight
    private let theme: TBIconTheme

    init(
        _ name: String,
        size: TBIconSize = .medium,
        weight: TBIconWeight = .regular,
        theme: TBIconTheme = .dark
    ) {
        self.name = name
        self.size = size
        self.weight = weight
        self.theme = theme
    }

    var body: some View {
        Image(systemName: name)
            .font(.system(size: size.dimension, weight: weight.weight))
            .foregroundColor(theme.color)
    }
}

#Preview {
    HStack(spacing: 20) {
        TBIcon("plus", size: .small)
        TBIcon("plus", size: .medium)
        TBIcon("plus", size: .large)
        TBIcon("plus", size: .xLarge, weight: .bold)
        TBIcon("star.fill", theme: .dark)
        TBIcon("heart", size: .medium, weight: .thin, theme: .dark)
    }
    .padding()
}
