//
//  ColorFeedView.swift
//  chameleon
//
//  Created by Ilia Chub on 11.12.2023.
//

import SwiftUI
import Foundation

struct ColorFeedViewItem {
    let hex: String
    let name: String?
}

struct ColorFeedView: View {
    let viewItem: ColorFeedViewItem
    
    var body: some View {
        VStack(spacing: 5) {
            Color(hex: viewItem.hex)
                .clipShape(.circle)
                .aspectRatio(1, contentMode: .fit)
            
            if let name = viewItem.name {
                Text(name)
                    .font(.bodySmall)
            }
        }
    }
}
