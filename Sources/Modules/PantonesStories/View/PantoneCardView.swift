//
//  PantoneCardView.swift
//  chameleon
//
//  Created by Pavlentiy on 22.12.2023.
//

import SwiftUI

struct PantoneCardView: View {
    let name: String
    let number: String
    
    var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .strokeBorder(Color(.backgroundCommon), lineWidth: 10)
            
            CardSignatureView(name: name, number: number)
        }
    }
}

private struct CardSignatureView: View {
    private enum Constants {
        static let pantoneTitleKey = "pantoneTitle"
    }
    
    let name: String
    let number: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .frame(height: 150)
                .foregroundColor(Color(.backgroundCommon))
            
            VStack(alignment: .leading, spacing: 0) {
                Text(String(localized: String.LocalizationValue(Constants.pantoneTitleKey)))
                    .font(.pantoneTitle)
                    .padding(.bottom, 10)
                
                Text(number)
                    .font(.pantoneSubtitle)
                    .padding(.bottom, 6)
                
                Text(name)
                    .font(.pantoneSubtitle)
            }
            .padding(.horizontal, 10)
        }
    }
}

#Preview {
    PantoneCardView(name: "Viva Magenta", number: "18-1750 TCX")
        .background { Color.gray.ignoresSafeArea() }
}
