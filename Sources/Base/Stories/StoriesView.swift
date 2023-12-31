//
//  StoriesView.swift
//  chameleon
//
//  Created by Pavlentiy on 22.12.2023.
//

import SwiftUI

struct StoriesView: View {
    @ObservedObject var viewModel: PantonesStoriesViewModel
    
    private let stories: [AnyView]
    private let filledProgressColor: Color
    private let notFilledProgressColor: Color
    private let changeStoryAnimation: Animation?
    
    var body: some View {
        stories[viewModel.currentStoryNumber]
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            // contentShape modifier is needed for gesture to work correctly over the entire area
            .contentShape(Rectangle())
            .overlay(alignment: .top) {
                StoriesHeaderView(
                    progress: viewModel.progress,
                    storiesCount: stories.count,
                    filledProgressColor: filledProgressColor,
                    notFilledProgressColor: notFilledProgressColor,
                    onCloseButtonTapAction: viewModel.handleStoriesClose
                )
                .padding(.top, 92)
                .padding(.horizontal, 28)
            }
            .onDragGestureTranslation { viewModel.handleDragGesture(with: $0.width) }
            .onAppear { viewModel.handleStoriesViewAppear(storiesCount: stories.count) }
            .onDisappear(perform: viewModel.handleStoriesViewDisappear)
            .animation(changeStoryAnimation, value: viewModel.currentStoryNumber)
    }
    
    init<Data: RandomAccessCollection, Content: View>(
        _ data: Data,
        viewModel: PantonesStoriesViewModel,
        filledProgressColor: Color,
        notFilledProgressColor: Color,
        changeStoryAnimation: Animation? = nil,
        @ViewBuilder content: @escaping (Data.Element) -> Content
    ) {
        self.viewModel = viewModel
        self.stories = data.map { AnyView(content($0)) }
        self.filledProgressColor = filledProgressColor
        self.notFilledProgressColor = notFilledProgressColor
        self.changeStoryAnimation = changeStoryAnimation
    }
}

private struct StoriesHeaderView: View {
    let progress: Double
    let storiesCount: Int
    
    let filledProgressColor: Color
    let notFilledProgressColor: Color
    
    let onCloseButtonTapAction: Closure.Void
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 16) {
            Image(.ic16Close)
                .foregroundColor(filledProgressColor)
                .onTapGesture(perform: onCloseButtonTapAction)
            StoriesProgressBarView(
                progress: progress,
                storiesCount: storiesCount,
                filledProgressColor: filledProgressColor,
                notFilledProgressColor: notFilledProgressColor
            )
        }
    }
}

private struct StoriesProgressBarView: View {
    let progress: Double
    let storiesCount: Int
    
    let filledProgressColor: Color
    let notFilledProgressColor: Color
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(Int.zero..<storiesCount, id: \.self) { storyNumber in
                StoryProgressView(
                    filledProgressColor: filledProgressColor,
                    notFilledProgressColor: notFilledProgressColor,
                    progress: getProgress(for: storyNumber)
                )
            }
        }
    }
    
    private func getProgress(for storyNumber: Int) -> Double {
        return min(max(progress - Double(storyNumber), .zero), .one)
    }
}

private struct StoryProgressView: View {
    let filledProgressColor: Color
    let notFilledProgressColor: Color
    
    var progress: CGFloat
    
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(notFilledProgressColor)
                    .cornerRadius(4)
                Rectangle()
                    .frame(width: proxy.size.width * progress, alignment: .leading)
                    .foregroundColor(filledProgressColor)
                    .cornerRadius(4)
                    .animation(.easeIn(duration: 0.1), value: progress.isZero)
                    .animation(.easeIn(duration: 0.2), value: progress)
            }
        }
        .frame(height: 4)
    }
}
