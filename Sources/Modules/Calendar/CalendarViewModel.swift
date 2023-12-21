//
//  CalendarViewModel.swift
//  chameleon
//
//  Created by Ilia Chub on 22.01.2023.
//

import SwiftUI
import PhotosUI

class CalendarViewModel: ObservableObject {
    private enum Constants {
        static let defaultPantoneTitleKey = "defaultPantoneTitle"
    }
    
    @Published var isPhotoLoadingErrorAlertPresented: Bool
    @Published var isNeedToShowSuccessPhotoLoadingSheet: Bool
    
    @Published private(set) var viewState: CalendarViewState
    @Published private(set) var isActivityIndicatorPresented: Bool
    @Published private(set) var lastLoadedPhotoPoints: Int
    
    private let pantonesRepository: PantonesRepository
    private let photosRepository: PhotosRepository
    private let authenticationRepository: AuthenticationRepository
    
    private var coordinator: CalendarCoordinator

    init(coordinator: CalendarCoordinator) {
        self.pantonesRepository = PantonesRepository()
        self.photosRepository = PhotosRepository()
        self.authenticationRepository = AuthenticationRepository()
        self.coordinator = coordinator
        self.isPhotoLoadingErrorAlertPresented = false
        self.isActivityIndicatorPresented = false
        self.isNeedToShowSuccessPhotoLoadingSheet = false
        self.lastLoadedPhotoPoints = .zero
        
        let pantoneTitle = String(localized: String.LocalizationValue(Constants.defaultPantoneTitleKey))
        let pantoneOfDayPlaceholder = PantoneFeedViewItem(color: Color(.placeholderPrimary), name: pantoneTitle)
        
        let calendarLoadingViewItem = CalendarLoadingViewItem(
            pantonesOfDay: TriplePantoneFeedViewItem(
                left: pantoneOfDayPlaceholder,
                middle: pantoneOfDayPlaceholder,
                right: pantoneOfDayPlaceholder
            )
        )
        
        self.viewState = .loading(calendarLoadingViewItem)
    }
    
    func handleViewDidAppear() {
        Task { await configurePantonesOfDayAndPhotosBydays() }
    }
    
    func handlePhotoLoadingErrorAlertButtonDidTap() {
        isPhotoLoadingErrorAlertPresented = false
    }
    
    func handleSuccessPhotoLoadingSheetButtonDidTap() {
        isNeedToShowSuccessPhotoLoadingSheet = false
    }
    
    private func configurePantonesOfDayAndPhotosBydays() async {
        guard let authenticationToken = await authenticationRepository.getAuthenticationHeader() else {
            return openLoginScreen()
        }
        
        async let getPantonesOfDayResult = pantonesRepository.getPantonesOfDay()
        async let getPhotosByDaysResult = photosRepository.getPhotosByDays(authenticationToken: authenticationToken)
        
        switch await (getPantonesOfDayResult, getPhotosByDaysResult) {
        case (.success(let pantonesOfDay), .success(let photosByDays)):
            handleSeccessResult(pantonesOfDay: pantonesOfDay, photosByDays: photosByDays)
        case (.failure(let error), _), (_, .failure(let error)):
            handleError(error)
        }
    }
    
    private func handleSeccessResult(pantonesOfDay: PantonesOfDayModel, photosByDays: [PhotosOfDayModel]) {
        guard let pantonesOfDayViewItem = mapPantonesToTriplePantoneFeedViewItem(
            pantones: pantonesOfDay.pantones,
            isNeedDoAddNames: true
        ) else {
            return handleError(ServerClientServiceError(.unknown))
        }
        
        let calendarContentCells = mapPhotosByDaysToCalendarContentCells(photosByDays)
        
        let contentViewItem = CalendarContentViewItem(
            pantonesOfDay: pantonesOfDayViewItem,
            cells: calendarContentCells,
            selectPhotoHandleClosure: { [weak self] in
                return await self?.getImage(from: $0)
            },
            cropPhotoHandleClosure: { [weak self] croppedImage in
                self?.handlePhotoDidCrop(image: croppedImage)
            }
        )
        let contentViewState = CalendarViewState.content(contentViewItem)
        
        updateViewState(to: contentViewState)
    }
    
    private func mapPhotosByDaysToCalendarContentCells(
        _ photosByDays: [PhotosOfDayModel]
    ) -> [CalendarContentCellViewItem] {
        let sortedPhotosByDats = photosByDays.sorted(by: { $0.date > $1.date })
        
        return sortedPhotosByDats.compactMap {
            guard let dateString = DateService.getFormattedDate(
                date: $0.date,
                format: .monthAndDate,
                isNeedToFormatToday: true
            ) else {
                return nil
            }
            
            let isToday = DateService.getIsToday(date: $0.date)
            let triplePantoneFeed = isToday
            ? nil
            : mapPantonesToTriplePantoneFeedViewItem(
                pantones: $0.pantones,
                isNeedDoAddNames: false
            )
            let photos = $0.photos.map { mapPhotoToEvaluationFeedImage($0) }
            
            return CalendarContentCellViewItem(
                dateString: dateString,
                triplePantoneFeed: triplePantoneFeed,
                photos: photos,
                isToday: isToday
            )
        }
    }
    
    private func handleError(_ error: ServerClientServiceError) {
        let errorViewState = CalendarViewState.error
        
        updateViewState(to: errorViewState)
    }
    
    private func updateViewState(to newViewState: CalendarViewState) {
        Task { @MainActor in self.viewState = newViewState }
    }
    
    private func mapPantonesToTriplePantoneFeedViewItem(
        pantones: [PantoneModel],
        isNeedDoAddNames: Bool
    ) -> TriplePantoneFeedViewItem? {
        if pantones.count != TriplePantoneFeedView.Constants.countOfPantones {
            return nil
        }
        
        let leftPantone = pantones[0]
        let leftPantoneViewItem = PantoneFeedViewItem(
            hex: leftPantone.hex,
            name: isNeedDoAddNames ? leftPantone.name : nil
        )
        let middlePantone = pantones[1]
        let middlePantoneViewItem = PantoneFeedViewItem(
            hex: middlePantone.hex,
            name: isNeedDoAddNames ? middlePantone.name : nil
        )
        let rightPantone = pantones[2]
        let rightPantoneViewItem = PantoneFeedViewItem(
            hex: rightPantone.hex,
            name: isNeedDoAddNames ? rightPantone.name : nil
        )
        
        return TriplePantoneFeedViewItem(
            left: leftPantoneViewItem,
            middle: middlePantoneViewItem,
            right: rightPantoneViewItem
        )
    }
    
    private func mapPhotoToEvaluationFeedImage(_ photo: RatedPhotoModel) -> EvaluationFeedImageViewItem {
        return EvaluationFeedImageViewItem(
            id: photo.id,
            url: photo.url,
            points: photo.points,
            date: nil,
            authorImageUrl: nil
        )
    }
    
    private func getImage(from selectedPhoto: PhotosPickerItem) async -> UIImage? {
        guard
            let imageData = try? await selectedPhoto.loadTransferable(type: Data.self),
            let image = UIImage(data: imageData)
        else {
            handlePhotoLoadingError()
            
            return nil
        }
        
        return image
    }
    
    private func handlePhotoDidCrop(image: UIImage?) {
        Task {
            guard let authenticationToken = await authenticationRepository.getAuthenticationHeader() else {
                return openLoginScreen()
            }
            
            guard let image, let jpegData = image.jpegData(compressionQuality: .one) else {
                return handlePhotoLoadingError()
            }
            
            Task { @MainActor in isActivityIndicatorPresented = true }
            
            let photoUploadingResult = await photosRepository.uploadPhoto(
                jpegData: jpegData,
                authenticationToken: authenticationToken
            )
            
            Task { @MainActor in isActivityIndicatorPresented = false }
            
            switch photoUploadingResult {
            case .success(let successModel):
                await configurePantonesOfDayAndPhotosBydays()
                Task { @MainActor in
                    self.lastLoadedPhotoPoints = successModel.points
                    self.isNeedToShowSuccessPhotoLoadingSheet = true
                }
            case .failure:
                handlePhotoLoadingError()
            }
        }
    }
    
    private func handlePhotoLoadingError() {
        Task { @MainActor in isPhotoLoadingErrorAlertPresented = true }
    }
    
    private func openLoginScreen() {
        Task { @MainActor in coordinator.openLoginScreen() }
    }
}
