//
//  TriplePantoneFeedView.swift
//  chameleon
//
//  Created by Ilia Chub on 11.12.2023.
//

import SwiftUI

struct TriplePantoneFeedViewItem {
    let left: PantoneFeedViewItem
    let middle: PantoneFeedViewItem
    let right: PantoneFeedViewItem
}

struct TriplePantoneFeedView: View {
    let viewItem: TriplePantoneFeedViewItem
    
    var body: some View {
        HStack(spacing: 10) {
            PantoneFeedView(viewItem: viewItem.left)
            PantoneFeedView(viewItem: viewItem.middle)
            PantoneFeedView(viewItem: viewItem.right)
        }
    }
}
