//
//  CalendarFactory.swift
//  chameleon
//
//  Created by Ilia Chub on 22.01.2023.
//

final class CalendarFactory {
    static func createCalendarViewController() -> CalendarViewController {
        let coordinator = CalendarCoordinator()
        let viewModel = CalendarViewModel(coordinator: coordinator)
        let viewController = CalendarViewController(viewModel: viewModel)

        coordinator.router = viewController
        
        return viewController
    }
}
