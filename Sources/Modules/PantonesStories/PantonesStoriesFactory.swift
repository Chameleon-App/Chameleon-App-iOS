//
//  PantonesStoriesFactory.swift
//  chameleon
//
//  Created by Pavlentiy on 22.12.2023.
//

enum PantonesStoriesFactory {
    static func createPantonesStoriesController(pantonesOfDay: PantonesOfDayModel) -> PantonesStoriesController {
        let coordinator = PantonesStoriesCoordinator()
        let viewModel = PantonesStoriesViewModel(coordinator: coordinator, pantonesOfDay: pantonesOfDay)
        let controller = PantonesStoriesController(viewModel: viewModel)
        coordinator.router = controller
        
        return controller
    }
}
