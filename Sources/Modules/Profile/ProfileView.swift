//
//  ProfileView.swift
//  chameleon
//
//  Created by Ilia Chub on 25.11.2023.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel: ProfileViewModel

    var body: some View {
        switch viewModel.viewState {
        case .loading:
            ProfileLoadingView(viewModel: viewModel)
        case .content:
            ProfileContentView(viewModel: viewModel)
        case .error:
            ProfileErrorView()
        }
    }
}
