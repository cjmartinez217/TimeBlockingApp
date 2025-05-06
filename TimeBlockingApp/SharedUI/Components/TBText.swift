//
//  TBText.swift
//  TimeBlockingApp
//
//  Created by Christian Martinez on 5/6/25.
//

import SwiftUI

enum TBTextSize {
    case size100
    case size200
    case size300
    case size400
    case size500

    var fontSize: CGFloat {
        switch self {
        case .size100: return Constants.textSize100
        case .size200: return Constants.textSize200
        case .size300: return Constants.textSize300
        case .size400: return Constants.textSize400
        case .size500: return Constants.textSize500
        }
    }
}

enum TBTextWeight {
    case light
    case medium
    case bold

    var weight: Font.Weight {
        switch self {
        case .light: return .light
        case .medium: return .medium
        case .bold: return .bold
        }
    }
}

struct TBText: View {
    let text: String
    let size: TBTextSize
    let weight: TBTextWeight

    init(
        _ text: String,
        size: TBTextSize = .size300,
        weight: TBTextWeight = .medium
    ) {
        self.text = text
        self.size = size
        self.weight = weight
    }

    var body: some View {
        Text(text)
            .font(.system(size: size.fontSize, weight: weight.weight))
    }
}

#Preview {
    VStack(spacing: 20) {
        // Size variations
        Group {
            TBText("Size 100", size: .size100)
            TBText("Size 200", size: .size200)
            TBText("Size 300", size: .size300)
            TBText("Size 400", size: .size400)
            TBText("Size 500", size: .size500)
        }

        Divider()

        // Weight variations
        Group {
            TBText("Light Weight", weight: .light)
            TBText("Medium Weight", weight: .medium)
            TBText("Bold Weight", weight: .bold)
        }

        Divider()

        // Combinations
        Group {
            TBText("Large Bold", size: .size500, weight: .bold)
            TBText("Small Light", size: .size100, weight: .light)
            TBText("Medium Medium", size: .size300, weight: .medium)
        }
    }
    .padding()
}
