//
//  LoginViewController.swift
//  chameleon
//
//  Created by Ilia Chub on 18.12.2023.
//

final class LoginViewController: BaseHostingController<LoginView> {
    init(viewModel: LoginViewModel) {
        super.init(rootView: LoginView(viewModel: viewModel))
    }
}
