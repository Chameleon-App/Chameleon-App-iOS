//
//  LaunchViewController.swift
//  polkadot-mobile
//
//  Created by Ilia Chub on 23.01.2023.
//

final class LaunchViewController: HostingController<LaunchView> {
    init(viewModel: LaunchViewModel) {
        super.init(rootView: LaunchView(viewModel: viewModel))
    }
}
