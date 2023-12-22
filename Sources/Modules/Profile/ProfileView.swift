//
//  ProfileView.swift
//  chameleon
//
//  Created by Ilia Chub on 25.11.2023.
//

import SwiftUI

enum ProfileViewState {
    case loading
    case content
    case error
}

private enum Constants {
    enum Layout {
        static let horizonalPadding: CGFloat = 10
        static let verticalPadding: CGFloat = 25
        static let statisticSpacing: CGFloat = 40
        static let statisticsHeight: CGFloat = 19
        static let profilePhotoSize: CGFloat = 75
    }

    enum Localization {
        static let streak = "streak"
        static let rating = "rating"
        static let photos = "photos"
    }
}

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
