//
//  SearchViewModel.swift
//  chameleon
//
//  Created by Ilia Chub on 22.01.2023.
//

import SwiftUI

final class SearchViewModel: ObservableObject {
    private enum Constants {
        static let photosLimit = 50
    }
    
    @Published var viewState: SearchViewState
    
    private let coordinator: SearchCoordinator
    private let photosRepository: PhotosRepository

    init(coordinator: SearchCoordinator) {
        self.viewState = .loading
        self.coordinator = coordinator
        self.photosRepository = PhotosRepository()
        
        configureUserInterface()
    }
    
    private func configureUserInterface() {
        Task {
            switch await getPhotos() {
            case .success(let photos):
                let photoViewItems = photos.map { getPhotoViewItem(from: $0) }
                let contentViewItem = SearchContentViewItem(photos: photoViewItems)
                
                Task { @MainActor in viewState = .content(contentViewItem) }
            case .failure:
                Task { @MainActor in viewState = .error }
            }
        }
    }
    
    private func getPhotos() async -> ServerClientServiceResult<[RatedPhotoModel]> {
        return await photosRepository.getTopPhotos(limit: Constants.photosLimit)
    }
    
    private func getPhotoViewItem(from photo: RatedPhotoModel) -> EvaluationFeedImageViewItem {
        return EvaluationFeedImageViewItem(
            id: photo.id,
            url: photo.url,
            points: photo.rating,
            date: photo.date,
            authorImageUrl: nil
        )
    }
}
