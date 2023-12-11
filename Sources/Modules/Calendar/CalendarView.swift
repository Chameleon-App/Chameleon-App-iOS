//
//  CalendarView.swift
//  chameleon
//
//  Created by Ilia Chub on 25.11.2023.
//

import SwiftUI

enum CalendarViewState: Equatable {
    case loading(CalendarLoadingViewItem)
    case content(CalendarContentViewItem)
    case error(CalendarErrorViewItem)
    
    static func == (lhs: CalendarViewState, rhs: CalendarViewState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading):
            return true
        case (.error(let lhsError), .error(let rhsError)):
            return lhsError.message == rhsError.message
        case (.content(let lhsContent), .content(let rhsContent)):
            return lhsContent == rhsContent
        default:
            return false
        }
    }
}

struct CalendarLoadingViewItem: Equatable {
    let pantonesOfDay: TriplePantoneFeedViewItem
}

struct CalendarContentViewItem: Equatable {
    let pantonesOfDay: TriplePantoneFeedViewItem
}

struct CalendarErrorViewItem {
    let message: String
}

struct CalendarView: View {
    @ObservedObject var viewModel: CalendarViewModel
    
    var body: some View {
        Group {
            switch viewModel.viewState {
            case .loading(let loadingViewItem):
                CalendarLoaingView(viewItem: loadingViewItem)
            case .content(let contentViewItem):
                CalendarContentView(viewItem: contentViewItem)
            case .error(let errorViewItem):
                Text(errorViewItem.message)
            }
        }
        .animation(.default, value: viewModel.viewState)
        .onAppear { viewModel.handleViewDidAppear() }
    }
}

private struct CalendarLoaingView: View {
    let viewItem: CalendarLoadingViewItem
    
    var body: some View {
        VStack(spacing: 0) {
            CalendarHeaderView(pantonesOfDay: viewItem.pantonesOfDay)
            Spacer()
            ProgressView()
            Spacer()
        }
    }
}

private struct CalendarContentView: View {
    let viewItem: CalendarContentViewItem
    
    var body: some View {
        VStack(spacing: 0) {
            CalendarHeaderView(pantonesOfDay: viewItem.pantonesOfDay)
            Spacer()
        }
    }
}

private struct CalendarHeaderView: View {
    let pantonesOfDay: TriplePantoneFeedViewItem
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
                .frame(height: 50)
            HStack(alignment: .top) {
                Spacer()
                Color(.placeholderPrimary)
                    .frame(width: 1, height: 75)
                Spacer()
                    .frame(width: 18)
                TriplePantoneFeedView(viewItem: pantonesOfDay, pantoneWidth: 75)
            }
            .padding(.horizontal, 10)
            Spacer()
                .frame(height: 10)
            Color(.placeholderPrimary)
                .frame(height: 1)
        }
    }
}
