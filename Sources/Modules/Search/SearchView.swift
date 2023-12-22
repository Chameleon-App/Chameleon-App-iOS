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
        Group {
            switch viewModel.viewState {
            case .loading:
                SearchLoadingView()
            case .content(let contentViewItem):
                SearchContentView(viewItem: contentViewItem)
            case .error:
                SearchErrorView()
            }
        }
        .onAppear { viewModel.handleViewDidAppear() }
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
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 1),
        GridItem(.flexible(), spacing: 1),
        GridItem(.flexible())
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 1) {
                ForEach(viewItem.photos) {
                    EvaluatedImageFeedView(viewItem: $0)
                        .aspectRatio(1, contentMode: .fit)
                }
            }
            .padding(.bottom, 20)
            .animation(.default, value: viewItem.photos.count)
        }
        .padding(.horizontal, 1)
    }
}

private struct SearchErrorView: View {
    var body: some View {
        VStack {
            Image(.ic64NetworkError)
        }
    }
}
