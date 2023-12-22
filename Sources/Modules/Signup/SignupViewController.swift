//
//  SignupViewController.swift
//  chameleon
//
//  Created by Ilia Chub on 21.12.2023.
//

final class SignupViewController: BaseHostingController<SignupView> {
    override var isNavigationBarHidden: Bool { true }
    
    init(viewModel: SignupViewModel) {
        super.init(rootView: SignupView(viewModel: viewModel))
    }
}
