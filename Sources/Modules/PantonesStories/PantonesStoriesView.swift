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
        StoriesView(
            viewModel.pantonesOfDay.pantones,
            viewModel: viewModel,
            filledProgressColor: Color(.backgroundPrimary),
            notFilledProgressColor: Color(.backgroundPrimary).opacity(0.5),
            content: { PantoneStoryView(pantone: $0) }
        )
        .ignoresSafeArea()
    }
}

private struct PantoneStoryView: View {
    let pantone: PantoneModel
    
    var body: some View {
        Color(hex: pantone.hex)
    }
}

struct PantonesStoriesView_Previews: PreviewProvider {
    static let pantonesOfDay = PantonesOfDayModel(
        pantones: [
            PantoneModel(name: "Малиновый", number: "закат", hex: "#EF9CDA"),
            PantoneModel(name: "Стекает", number: "по стене", hex: "#32CBFF")
        ]
    )
    
    static var previews: some View {
        PantonesStoriesView(
            viewModel: PantonesStoriesViewModel(
                coordinator: PantonesStoriesCoordinator(), 
                pantonesOfDay: pantonesOfDay
            )
        )
    }
}
