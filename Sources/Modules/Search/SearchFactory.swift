//
//  SearchFactory.swift
//  chameleon
//
//  Created by Ilia Chub on 22.01.2023.
//

final class SearchFactory {
    static func createSearchViewController() -> SearchViewController {
        let coordinator = SearchCoordinator()
        let viewModel = SearchViewModel(coordinator: coordinator)
        let viewController = SearchViewController(viewModel: viewModel)

        coordinator.router = viewController
        
        return viewController
    }
}
