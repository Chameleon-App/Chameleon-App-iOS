//
//  EvaluatedImageFeedView.swift
//  chameleon
//
//  Created by Ilia Chub on 15.12.2023.
//

import SwiftUI

struct EvaluationFeedImageViewItem: Identifiable, Equatable {
    let id: Int
    let url: URL?
    let points: Int
    let date: Date?
    let authorImageUrl: URL?
}

struct EvaluatedImageFeedView: View {
    let viewItem: EvaluationFeedImageViewItem
    
    var body: some View {
        ZStack {
            AsyncImageView(url: viewItem.url)
            HStack {
                Spacer()
                VStack {
                    Spacer()
                    Text(String(viewItem.points))
                        .font(.bodySmall)
                        .foregroundStyle(Color(.textSecondary))
                        .padding(.horizontal, 4)
                        .padding(.vertical, 1)
                        .background(.ultraThinMaterial)
                        .cornerRadius(5)
                        .padding(.all, 5)
                }
            }
            HStack {
                VStack {
                    if let authorImageUrl = viewItem.authorImageUrl {
                        AsyncImageView(url: authorImageUrl, rounding: .max)
                            .frame(width: 32, height: 32)
                            .padding(.all, 3)
                    } else if let date = viewItem.date {
                        Text(DateService.getFormattedDate(date: date, format: .monthAndDate) ?? .empty)
                            .font(.bodySmall)
                            .foregroundStyle(Color(.textSecondary))
                            .padding(.horizontal, 4)
                            .padding(.vertical, 1)
                            .background(.ultraThinMaterial)
                            .cornerRadius(5)
                            .padding(.all, 5)
                    }
                    Spacer()
                }
                Spacer()
            }
        }
    }
}
