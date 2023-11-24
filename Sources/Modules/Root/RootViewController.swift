//
//  RootViewController.swift
//  chameleon
//
//  Created by Ilia Chub on 22.01.2023.
//

import UIKit

class RootViewController: BaseViewController {
    let viewModel: RootViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.openLaunchScreen()
    }
    
    init(viewModel: RootViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }
}
