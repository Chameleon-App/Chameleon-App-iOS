//
//  RegistrationViewController.swift
//  chameleon
//
//  Created by Ilia Chub on 21.12.2023.
//

final class RegistrationViewController: BaseHostingController<RegistrationView> {
    init(viewModel: RegistrationViewModel) {
        super.init(rootView: RegistrationView(viewModel: viewModel))
    }
}
