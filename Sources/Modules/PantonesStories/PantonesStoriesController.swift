//
//  PantonesStoriesController.swift
//  chameleon
//
//  Created by Pavlentiy on 22.12.2023.
//

final class PantonesStoriesController: BaseHostingController<PantonesStoriesView> {
    init(viewModel: PantonesStoriesViewModel) {
        super.init(rootView: PantonesStoriesView(viewModel: viewModel))
    }
}
