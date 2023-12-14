//
//  SkeletonView.swift
//  chameleon
//
//  Created by Ilia Chub on 14.12.2023.
//

import SwiftUI

struct SkeletonView: View {
    private var gradientColors = [
        Color(.backgroundPrimary),
        Color(.placeholderGradient),
        Color(.backgroundPrimary)
    ]
    
    @State private var startPoint: UnitPoint = .init(x: -2, y: 1)
    @State private var endPoint: UnitPoint = .init(x: 0, y: 1)
    
    var body: some View {
        LinearGradient(colors: gradientColors, startPoint: startPoint, endPoint: endPoint)
            .onAppear {
                withAnimation(
                    .easeInOut(duration: 1.5)
                    .repeatForever(autoreverses: false)
                ) {
                    startPoint = .init(x: 1, y: 1)
                    endPoint = .init(x: 2, y: 1)
                }
            }
    }
}
