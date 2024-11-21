//
//  Typography.swift
//  Skills
//
//  Created by Kyle Rohr on 20/11/2024.
//

import SwiftUI

public enum Typography: String, CaseIterable {
    case title
    case subtitle
    case jumbo

    case heading1
    case heading2
    case heading3
    case heading4

    case info

    case bodyS
    case bodyM
    case bodyL
    case bodyXL

    case caption
    case label
}
extension Font {
    static func lato(
        _ size: CGFloat,
        weight: Font.Weight = .regular
    ) -> Font {
        let fontName: String

        switch weight {
        case .black: fontName = "Lato-Black"
        case .bold: fontName = "Lato-Bold"
        case .light: fontName = "Lato-Light"
        case .thin: fontName = "Lato-Thin"
        default: fontName = "Lato-Regular"
        }

        return Font.custom(fontName, size: size).weight(weight)
    }

    static func newsreader(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        Font.custom("Newsreader", size: size).weight(weight)
    }

    static func newsreaderItalic(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        Font.custom("Newsreader", size: size).weight(weight).italic()
    }
}

struct TypographyModifier: ViewModifier {
    let typography: Typography

    func body(content: Content) -> some View {
        switch typography {
        case .title:
            content
                .font(.newsreader(48))
        case .subtitle:
            content
                .font(.newsreader(24, weight: .light))
                .kerning(5)
        case .jumbo:
            content
                .font(.newsreader(72))
        case .heading1:
            content
                .font(.newsreader(36))
        case .heading2:
            content
                .font(.newsreader(24))
        case .heading3:
            content
                .font(.newsreader(18))
        case .heading4:
            content
                .font(.newsreader(14))
        case .info:
            content
                .font(.newsreaderItalic(18, weight: .bold))
        case .bodyS:
            content
                .font(.newsreader(11))
                .lineSpacing(2)
        case .bodyM:
            content
                .font(.newsreader(12))
                .lineSpacing(3)
        case .bodyL:
            content
                .font(.newsreader(16))
                .lineSpacing(4)
        case .bodyXL:
            content
                .font(.newsreader(18))
                .lineSpacing(5)
        case .caption:
            content
                .font(.lato(12))
        case .label:
            content
                .font(.lato(16, weight: .bold))
        }
    }
}

public extension View {
    func typography(_ typography: Typography) -> some View {
        modifier(TypographyModifier(typography: typography))
    }
}

#Preview("Typography") {
    VStack(spacing: .Spacing.five) {
        ForEach(Typography.allCases, id: \.rawValue) { item in
            Text(item.rawValue.capitalized)
                .modifier(TypographyModifier(typography: item))
        }
    }
}
