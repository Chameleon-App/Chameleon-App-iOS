//
//  CalendarCoordinator.swift
//  chameleon
//
//  Created by Ilia Chub on 22.01.2023.
//

final class CalendarCoordinator {
    weak var router: (PresentationRouter & RootRouter)?
    
    func openLoginScreen() {
        let viewController = LoginFactory.createLoginViewController()
        
        router?.updateRootViewController(viewController: viewController)
    }
    
    func openPantonesStories(pantonesOfDay: PantonesOfDayModel) {
        let viewController = PantonesStoriesFactory.createPantonesStoriesController()
        viewController.modalPresentationStyle = .fullScreen
        
        router?.present(controller: viewController, completion: nil)
    }
}
