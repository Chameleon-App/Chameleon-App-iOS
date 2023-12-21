//
//  LaunchView.swift
//  chameleon
//
//  Created by Ilia Chub on 23.01.2023.
//

import SwiftUI

struct LaunchView: View {
    @ObservedObject var viewModel: LaunchViewModel
    
    var body: some View {
        VStack {
            ProgressView()
                .controlSize(.large)
        }
            .background(Color(.backgroundPrimary))
            .onAppear { viewModel.handleViewDidAppear() }
    }
}
