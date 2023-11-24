//
//  SearchViewController.swift
//  chameleon
//
//  Created by Ilia Chub on 22.01.2023.
//

import UIKit

class SearchViewController: BaseHostingController<SearchView> {
    init(viewModel: SearchViewModel) {
        super.init(rootView: SearchView(viewModel: viewModel))
    }
}
