//
//  AsyncImageView.swift
//  chameleon
//
//  Created by Илья Чуб on 15.12.2023.
//

import SwiftUI

enum AsyncImageRounding {
    case radius(Double)
    case max
}

struct AsyncImageView: View {
    let url: URL?
    let rounding: AsyncImageRounding?
    
    var body: some View {
        AsyncImage(url: url) {
            $0
                .resizable()
        } placeholder: {
            SkeletonView()
        }
        .cornerRadius(getCornerRadius())
    }
    
    private func getCornerRadius() -> CGFloat {
        switch rounding {
        case .radius(let radius):
            return radius
        case .max:
            return CGFloat(Int.max)
        case .none:
            return .zero
        }
    }
}
