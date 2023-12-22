//
//  LaunchViewController.swift
//  chameleon
//
//  Created by Ilia Chub on 23.01.2023.
//

final class LaunchViewController: BaseHostingController<LaunchView> {
    init(viewModel: LaunchViewModel) {
        super.init(rootView: LaunchView(viewModel: viewModel))
    }
}
