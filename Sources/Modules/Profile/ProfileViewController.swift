//
//  ProfileViewController.swift
//  chameleon
//
//  Created by Ilia Chub on 22.01.2023.
//

import UIKit

final class ProfileViewController: BaseHostingController<ProfileView> {
    init(viewModel: ProfileViewModel) {
        super.init(rootView: ProfileView(viewModel: viewModel))
    }
}
