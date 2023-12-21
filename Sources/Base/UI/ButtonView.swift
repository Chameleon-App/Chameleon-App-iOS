//
//  ButtonView.swift
//  chameleon
//
//  Created by Ilia Chub on 18.12.2023.
//

import SwiftUI

enum ButtonViewStyleType {
    case primary
    case attention
}

struct ButtonView: View {
    private enum Constants {
        static let defaultHeight: CGFloat = 52
        static let defaultHorizontalPadding: CGFloat = 16
    }
    
    let styleType: ButtonViewStyleType
    let content: String
    let action: Closure.Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Text(content)
            }
                .frame(height: Constants.defaultHeight)
                .frame(maxWidth: CGFloat.infinity)
                .padding(.horizontal, Constants.defaultHorizontalPadding)
        }
        .buttonStyle(ButtonViewStyle.get(styleType: styleType))
    }
}

struct ButtonViewStyle: ButtonStyle {
    private enum Constants {
        static let cornerRadius: CGFloat = 15
    }
    
    let backgroundColorSet: ButtonViewColorsSet
    let foregroundColorSet: ButtonViewColorsSet
    let cornerRadius: CGFloat
    
    @Environment(\.isEnabled) private var isEnabled
    
    func makeBody(configuration: Configuration) -> some View {
        let foregroundColor = foregroundColorSet.getColor(
            isPressed: configuration.isPressed,
            isActive: isEnabled
        )
        let backgroundColor = backgroundColorSet.getColor(
            isPressed: configuration.isPressed,
            isActive: isEnabled
        )
        
        configuration
            .label
            .lineLimit(1)
            .foregroundColor(foregroundColor)
            .tint(foregroundColor)
            .background(backgroundColor)
            .font(.titlePrimary)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .animation(.default, value: isEnabled)
    }
    
    static func get(styleType: ButtonViewStyleType) -> Self {
        switch styleType {
        case .attention:
            getAttentionStyle()
        case .primary:
            getPrimaryStyle()
        }
    }
    
    private static func getAttentionStyle() -> Self {
        let backgroundColorSet = ButtonViewColorsSet(
            active: Color(.buttonBackgroundAttention),
            pressed: Color(.buttonBackgroundPressed),
            disabled: Color(.buttonBackgroundAttention)
        )
        
        let foregroundColorSet = ButtonViewColorsSet(
            active: Color(.buttonTextPrimary),
            pressed: Color(.buttonTextPrimaryPressed),
            disabled: Color(.buttonTextPrimaryPressed)
        )
        
        return .init(
            backgroundColorSet: backgroundColorSet,
            foregroundColorSet: foregroundColorSet,
            cornerRadius: Constants.cornerRadius
        )
    }
    
    private static func getPrimaryStyle() -> Self {
        let backgroundColorSet = ButtonViewColorsSet(
            active: Color(.buttonBackgroundPrimary),
            pressed: Color(.buttonBackgroundPressed),
            disabled: Color(.buttonBackgroundPrimary)
        )
        
        let foregroundColorSet = ButtonViewColorsSet(
            active: Color(.buttonTextPrimary),
            pressed: Color(.buttonTextPrimaryPressed),
            disabled: Color(.buttonTextPrimaryPressed)
        )
        
        return .init(
            backgroundColorSet: backgroundColorSet,
            foregroundColorSet: foregroundColorSet,
            cornerRadius: Constants.cornerRadius
        )
    }
}

struct ButtonViewColorsSet {
    let active: Color
    let pressed: Color
    let disabled: Color
    
    func getColor(isPressed: Bool, isActive: Bool) -> Color {
        if isPressed {
            return pressed
        } else if isActive {
            return active
        } else {
            return disabled
        }
    }
}
