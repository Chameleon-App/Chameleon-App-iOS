//
//  ProfileContentView.swift
//  chameleon
//
//  Created by Анита Самчук on 22.12.2023.
//

import SwiftUI

private enum Constants {
    enum Layout {
        static let horizonalPadding: CGFloat = 10
        static let verticalPadding: CGFloat = 25
        static let statisticSpacing: CGFloat = 40
        static let statisticsHeight: CGFloat = 19
        static let profilePhotoSize: CGFloat = 75
    }

    enum Localization {
        static let streak = "streak"
        static let rating = "rating"
        static let photos = "photos"
    }
}

struct ProfileContentView: View {
    let viewModel: ProfileViewModel
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 1),
        GridItem(.flexible(), spacing: 1),
        GridItem(.flexible())
    ]

    var body: some View {
        ScrollView {
            VStack {
                ProfileHeaderView(viewModel: viewModel)
                LazyVGrid(columns: columns, spacing: 1) {
                    ForEach(viewModel.photos) {
                        EvaluatedImageFeedView(viewItem: $0)
                            .aspectRatio(1, contentMode: .fit)
                    }
                }
                .padding(.bottom, 20)
            }
        }
        .padding(.horizontal, 1)
    }
}

struct ProfileHeaderView: View {
    let viewModel: ProfileViewModel

    var body: some View {
        HStack {
            AsyncImageView(url: viewModel.profilePhoto, rounding: .max)
                .frame(width: Constants.Layout.profilePhotoSize, height: Constants.Layout.profilePhotoSize)
            Spacer()
            VStack(alignment: .leading, spacing: 7) {
                Text(viewModel.username)
                    .font(.headingPrimary)
                TripleProfileStaticticsView(viewItem: getTripleProfileStatisticsViewItem())
            }
            .frame(width: 280)

        }
        .padding(.horizontal, Constants.Layout.horizonalPadding)
        .padding(.vertical, Constants.Layout.verticalPadding)
    }

    private func getTripleProfileStatisticsViewItem() -> TripleProfileStatisticsViewItem {
        let streakString = String(localized: String.LocalizationValue(Constants.Localization.streak))
        let ratingString = String(localized: String.LocalizationValue(Constants.Localization.rating))
        let photosString = String(localized: String.LocalizationValue(Constants.Localization.photos))
        let streak = ProfileStatisticViewItem(name: streakString, score: viewModel.currentStreak)
        let rating = ProfileStatisticViewItem(name: ratingString, score: viewModel.totalRating)
        let photos = ProfileStatisticViewItem(name: photosString, score: viewModel.totalPhotos)
        return TripleProfileStatisticsViewItem(streak: streak, rating: rating, photos: photos)
    }
}


struct TripleProfileStatisticsViewItem: Equatable {
    let streak: ProfileStatisticViewItem
    let rating: ProfileStatisticViewItem
    let photos: ProfileStatisticViewItem
}

struct TripleProfileStaticticsView: View {
    let viewItem: TripleProfileStatisticsViewItem

    var body: some View {
        HStack(alignment: .center, spacing: Constants.Layout.statisticSpacing) {
            ProfileStasticsView(viewItem: viewItem.streak)
            ProfileStasticsView(viewItem: viewItem.rating)
            ProfileStasticsView(viewItem: viewItem.photos)
        }
    }
}

struct ProfileStatisticViewItem: Equatable {
    let name: String
    let score: String

    init(name: String, score: String) {
        self.name = name
        self.score = score
    }
}

struct ProfileStasticsView: View {
    let viewItem: ProfileStatisticViewItem
    var body: some View {
        VStack(spacing: 1) {
            Text(viewItem.score)
                .font(.titlePrimary)
                .lineLimit(1)
                .multilineTextAlignment(.center)
                .frame(height: Constants.Layout.statisticsHeight)

            Text(viewItem.name)
                .font(.bodySmall)
                .lineLimit(3)
                .multilineTextAlignment(.center)
        }
    }
}


