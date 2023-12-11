//
//  TriplePantoneFeedView.swift
//  chameleon
//
//  Created by Ilia Chub on 11.12.2023.
//

import SwiftUI

struct TriplePantoneFeedViewItem: Equatable {
    let left: PantoneFeedViewItem
    let middle: PantoneFeedViewItem
    let right: PantoneFeedViewItem
}

struct TriplePantoneFeedView: View {
    enum Constants {
        static var countOfPantones = 3
    }
    
    let viewItem: TriplePantoneFeedViewItem
    let pantoneWidth: CGFloat
    
    var body: some View {
        HStack(spacing: 10) {
            PantoneFeedView(viewItem: viewItem.left, width: pantoneWidth)
            PantoneFeedView(viewItem: viewItem.middle, width: pantoneWidth)
            PantoneFeedView(viewItem: viewItem.right, width: pantoneWidth)
        }
    }
}
