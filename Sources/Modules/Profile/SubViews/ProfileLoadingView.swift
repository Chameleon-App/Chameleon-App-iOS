//
//  ProfileLoadingView.swift
//  chameleon
//
//  Created by Анита Самчук on 22.12.2023.
//

import SwiftUI

struct ProfileLoadingView: View {
    let viewModel: ProfileViewModel
    var body: some View {
        VStack {
            ProfileHeaderView(viewModel: viewModel)
            ProgressView()
        }
    }
}
