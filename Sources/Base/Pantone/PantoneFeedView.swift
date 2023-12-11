//
//  PantoneFeedView.swift
//  chameleon
//
//  Created by Ilia Chub on 11.12.2023.
//

import SwiftUI

struct PantoneFeedViewItem: Equatable {
    let color: Color?
    let name: String?
    
    init(color: Color, name: String?) {
        self.color = color
        self.name = name
    }
    
    init(hex: String, name: String?) {
        self.color = Color(hex: hex)
        self.name = name
    }
}

struct PantoneFeedView: View {
    let viewItem: PantoneFeedViewItem
    let width: CGFloat
    
    var body: some View {
        VStack(spacing: 5) {
            viewItem.color
                .clipShape(.circle)
                .aspectRatio(1, contentMode: .fit)
            if let name = viewItem.name {
                Text(name.capitalized)
                    .font(.bodySmall)
                    .lineLimit(3)
                    .multilineTextAlignment(.center)
            }
        }
        .frame(width: width)
    }
}
