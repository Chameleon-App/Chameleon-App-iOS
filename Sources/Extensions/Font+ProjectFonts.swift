//
//  Font+ProjectFonts.swift
//  chameleon
//
//  Created by Ilia Chub on 11.12.2023.
//

import SwiftUI

extension Font {
    private enum CustomFonts {
        static let helveticaBold = "Helvetica-Bold"
    }
    
    static var bodySmall: Font { .system(size: 13, weight: .regular) }
    static var bodyPrimary: Font { .system(size: 14, weight: .regular) }
    static var bodyBig: Font { .system(size: 16, weight: .regular) }
    static var titlePrimary: Font { .system(size: 16, weight: .bold) }
    static var headingPrimary: Font { .system(size: 24, weight: .heavy) }
    static var subheadingPrimary: Font { .system(size: 16, weight: .bold) }
    static var pantoneTitle: Font { .custom(CustomFonts.helveticaBold, size: 42) }
    static var pantoneSymbol: Font { .custom(CustomFonts.helveticaBold, size: 32) }
    static var pantoneSubtitle: Font { .custom(CustomFonts.helveticaBold, size: 20) }
}
