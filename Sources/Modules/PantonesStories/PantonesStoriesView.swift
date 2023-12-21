//
//  PantonesStoriesView.swift
//  chameleon
//
//  Created by Pavlentiy on 22.12.2023.
//

import SwiftUI

struct PantonesStoriesView: View {
    @ObservedObject var viewModel: PantonesStoriesViewModel

    var body: some View {
        Text("PantonesStories module created!")
    }
}

struct PantonesStoriesView_Previews: PreviewProvider {
    static var previews: some View {
        PantonesStoriesView(
            viewModel: PantonesStoriesViewModel(
                coordinator: PantonesStoriesCoordinator()
            )
        )
    }
}
