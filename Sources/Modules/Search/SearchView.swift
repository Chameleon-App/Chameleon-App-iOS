//
//  CalendarView.swift
//  chameleon
//
//  Created by Ilia Chub on 25.11.2023.
//

import SwiftUI

enum SearchViewState {
    case loading
    case content(SearchContentViewItem)
    case error
}

struct SearchContentViewItem {
    let photos: [EvaluationFeedImageViewItem]
}

struct SearchView: View {
    @ObservedObject var viewModel: SearchViewModel
    
    var body: some View {
        switch viewModel.viewState {
        case .loading:
            SearchLoadingView()
        case .content(let contentViewItem):
            SearchContentView(viewItem: contentViewItem)
        case .error:
            Color.red
        }
    }
}

private struct SearchLoadingView: View {
    var body: some View {
        VStack {
            ProgressView()
        }
    }
}

private struct SearchContentView: View {
    let viewItem: SearchContentViewItem

    var body: some View {
        let columns: [GridItem] = [
            GridItem(.flexible(), spacing: 1),
            GridItem(.flexible(), spacing: 1),
            GridItem(.flexible())
        ]

        ScrollView {
            LazyVGrid(columns: columns, spacing: 2) {
                ForEach(viewItem.photos) {
                    EvaluatedImageFeedView(viewItem: $0)
                        .aspectRatio(1, contentMode: .fit)
                }
            }
        }
        .padding(.horizontal, 1)
    }
}
