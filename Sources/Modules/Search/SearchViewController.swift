//
//  SearchViewController.swift
//  chameleon
//
//  Created by Ilia Chub on 22.01.2023.
//

import UIKit

final class SearchViewController: BaseHostingController<SearchView> {
    override var isNavigationBarHidden: Bool { true }
    
    init(viewModel: SearchViewModel) {
        super.init(rootView: SearchView(viewModel: viewModel))
    }
}
