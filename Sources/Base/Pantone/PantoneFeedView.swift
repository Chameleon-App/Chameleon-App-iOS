//
//  PantoneFeedView.swift
//  chameleon
//
//  Created by Ilia Chub on 11.12.2023.
//

import SwiftUI

struct PantoneFeedViewItem {
    let hex: String
    let name: String?
}

struct PantoneFeedView: View {
    let viewItem: PantoneFeedViewItem
    
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
