//
//  ProfileContentView.swift
//  chameleon
//
//  Created by Анита Самчук on 22.12.2023.
//

import SwiftUI

struct ProfileContentView: View {
    private enum Constants {
        static let gridBottomPadding: CGFloat = 20
        static let horizontalPadding: CGFloat = 1
    }

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
                .padding(.bottom, Constants.gridBottomPadding)
                .animation(.default, value: viewModel.photos.count)
            }
        }
        .padding(.horizontal, Constants.horizontalPadding)
    }
}

struct ProfileHeaderView: View {
    private enum Constants {
        enum Layout {
            static let horizonalPadding: CGFloat = 10
            static let verticalPadding: CGFloat = 25
            static let profilePhotoSize: CGFloat = 75
            static let hStachSpacing: CGFloat = 10
            static let vStachSpacing: CGFloat = 7
        }

        enum Localization {
            static let streak = "streakTitle"
            static let rating = "ratingTitle"
            static let photos = "photosTitle"
        }
    }

    let viewModel: ProfileViewModel

    var body: some View {
        HStack(alignment: .top, spacing: Constants.Layout.hStachSpacing) {
            AsyncImageView(url: viewModel.profilePhoto, rounding: .max)
                .frame(width: Constants.Layout.profilePhotoSize, height: Constants.Layout.profilePhotoSize)
            VStack(alignment: .leading, spacing: Constants.Layout.vStachSpacing) {
                Text(viewModel.username)
                    .font(.headingPrimary)
                TripleProfileStaticticsView(viewItem: getTripleProfileStatisticsViewItem())
            }
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
    private enum Constants {
        static let stackSpacing: CGFloat = 40
    }
    let viewItem: TripleProfileStatisticsViewItem

    var body: some View {
        HStack(spacing: Constants.stackSpacing) {
            ProfileStasticsView(viewItem: viewItem.streak)
            ProfileStasticsView(viewItem: viewItem.rating)
            ProfileStasticsView(viewItem: viewItem.photos)
        }
        .frame(maxWidth: .infinity)
    }
}

struct ProfileStatisticViewItem: Equatable {
    let name: String
    let score: String
}

struct ProfileStasticsView: View {
    private enum Constants {
        static let stackSpacing: CGFloat = 1
        static let statisticsHeight: CGFloat = 19
    }
    let viewItem: ProfileStatisticViewItem
    var body: some View {
        VStack(spacing: Constants.stackSpacing) {
            Text(viewItem.score)
                .font(.titlePrimary)
                .lineLimit(1)
                .multilineTextAlignment(.center)
                .frame(height: Constants.statisticsHeight)
            Text(viewItem.name)
                .font(.bodySmall)
                .lineLimit(3)
                .multilineTextAlignment(.center)
        }
    }
}
