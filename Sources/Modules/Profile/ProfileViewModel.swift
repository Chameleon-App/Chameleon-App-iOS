//
//  ProfileViewModel.swift
//  chameleon
//
//  Created by Ilia Chub on 22.01.2023.
//

import SwiftUI

final class ProfileViewModel: ObservableObject {
    @Published var viewState: ProfileViewState

    @Published var id: Int?
    @Published var username: String = ""
    @Published var profilePhoto: URL?
    @Published var totalPhotos: String = ""
    @Published var totalRating: String = ""
    @Published var currentStreak: String = ""
    @Published var photos: [EvaluationFeedImageViewItem] = []

    private var coordinator: ProfileCoordinator
    private let photosRepository = PhotosRepository()
    private let userRepository = UserRepository()
    private let authenticationRepository = AuthenticationRepository()

    init(coordinator: ProfileCoordinator) {
        self.viewState = .loading
        self.coordinator = coordinator

        configureUserInterface()
    }

    private func configureUserInterface() {
        Task {
            guard let authenticationToken = await authenticationRepository.getAuthenticationHeader() else {
                return openLoginScreen()
            }
            switch await getUser(authenticationToken: authenticationToken) {
            case .success(let profile):
                let sortedPhotos = profile.photos.sorted(by: { $0.date > $1.date })
                let photoViewItems = sortedPhotos.map { getPhotoViewItem(from: $0) }

                updateViewModel(with: profile, photoViewItems: photoViewItems)

                Task { @MainActor in viewState = .content }
            case .failure:
                Task { @MainActor in viewState = .error }
            }
        }
    }

    private func getUser(authenticationToken: String) async -> ServerClientServiceResult<UserModel> {
        return await userRepository.getUser(authenticationToken: authenticationToken)
    }

    private func getPhotoViewItem(from photo: RatedPhotoModel) -> EvaluationFeedImageViewItem {
        return EvaluationFeedImageViewItem(
            id: photo.id,
            url: photo.url,
            points: photo.points,
            date: photo.date,
            authorImageUrl: nil
        )
    }

    private func updateViewModel(with profile: UserModel, photoViewItems: [EvaluationFeedImageViewItem]) {
        id = profile.id
        username = profile.username
        profilePhoto = profile.profilePhoto
        totalPhotos = String(profile.totalPhotos)
        totalRating = String(profile.totalRating)
        currentStreak = String(profile.currentStreak)
        photos = photoViewItems
    }

    private func openLoginScreen() {
        Task { @MainActor in coordinator.openLoginScreen() }
    }
}
