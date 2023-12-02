//
//  CalendarView.swift
//  chameleon
//
//  Created by Ilia Chub on 25.11.2023.
//

import SwiftUI

enum CalendarViewState {
    case loading
    case content(CalendarContentViewItem)
    case error(CalendarErrorViewItem)
}

struct CalendarContentViewItem {
    let isServerHealth: Bool
}

struct CalendarErrorViewItem {
    let message: String
}

struct CalendarView: View {
    @ObservedObject var viewModel: CalendarViewModel
    
    var body: some View {
        VStack {
            switch viewModel.viewState {
            case .loading:
                ProgressView()
            case .content(let contentViewItem):
                Group {
                    if contentViewItem.isServerHealth {
                        Color.green
                    } else {
                        Color.red
                    }
                }
                .ignoresSafeArea()
            case .error(let errorViewItem):
                Text(errorViewItem.message)
            }
        }
        .onAppear { viewModel.handleViewDidAppear() }
    }
}
