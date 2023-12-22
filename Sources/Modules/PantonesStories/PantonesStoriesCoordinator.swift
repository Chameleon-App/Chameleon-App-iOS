//
//  PantonesStoriesCoordinator.swift
//  chameleon
//
//  Created by Pavlentiy on 22.12.2023.
//

final class PantonesStoriesCoordinator {
    weak var router: PresentationRouter?
    
    func dismiss() {
        router?.dismiss()
    }
}
