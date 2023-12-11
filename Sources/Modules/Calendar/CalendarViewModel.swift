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
    
    @Published private(set) var viewState: CalendarViewState
    
    private let pantonesRepository: PantonesRepository
    
    private var coordinator: CalendarCoordinator

    init(coordinator: CalendarCoordinator) {
        self.pantonesRepository = PantonesRepository()
        self.coordinator = coordinator
        
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
        Task { await configurePantonesOfDay() }
    }
    
    private func configurePantonesOfDay() async {
        switch await pantonesRepository.getPantonesOfDay() {
        case .success(let pantonesOfDay):
            handleSeccessResult(pantonesOfDay: pantonesOfDay)
        case .failure(let error):
            handleError(error)
        }
    }
    
    private func handleSeccessResult(pantonesOfDay successResult: PantonesOfDayModel) {
        guard let pantonesOfDayViewItem = mapPantonesOfDayToTriplePantoneFeedViewItem(
            pantonesOfDay: successResult
        ) else {
            return handleError(ServerClientServiceError(.unknown))
        }
        
        let contentViewItem = CalendarContentViewItem(
            pantonesOfDay: pantonesOfDayViewItem,
            addPhotoHandleClosure: { [weak self] in
                self?.handleAddPhotoButtonDidTap(selectedPhoto: $0)
            }
        )
        let contentViewState = CalendarViewState.content(contentViewItem)
        
        updateViewState(to: contentViewState)
    }
    
    private func handleError(_ error: ServerClientServiceError) {
        let errorMessage = error.localizedDescription
        let errorViewItem = CalendarErrorViewItem(message: errorMessage)
        let errorViewState = CalendarViewState.error(errorViewItem)
        
        updateViewState(to: errorViewState)
    }
    
    private func updateViewState(to newViewState: CalendarViewState) {
        Task { @MainActor in self.viewState = newViewState }
    }
    
    private func mapPantonesOfDayToTriplePantoneFeedViewItem(
        pantonesOfDay: PantonesOfDayModel
    ) -> TriplePantoneFeedViewItem? {
        if pantonesOfDay.pantones.count != TriplePantoneFeedView.Constants.countOfPantones {
            return nil
        }
        
        let leftPantone = pantonesOfDay.pantones[0]
        let leftPantoneViewItem = PantoneFeedViewItem(hex: leftPantone.hex, name: leftPantone.name)
        let middlePantone = pantonesOfDay.pantones[1]
        let middlePantoneViewItem = PantoneFeedViewItem(hex: middlePantone.hex, name: middlePantone.name)
        let rightPantone = pantonesOfDay.pantones[2]
        let rightPantoneViewItem = PantoneFeedViewItem(hex: rightPantone.hex, name: rightPantone.name)
        
        return TriplePantoneFeedViewItem(
            left: leftPantoneViewItem,
            middle: middlePantoneViewItem,
            right: rightPantoneViewItem
        )
    }
    
    private func handleAddPhotoButtonDidTap(selectedPhoto: PhotosPickerItem?) {
        guard let selectedPhoto else {
            return
        }
        
        Task {
            await handleAddPhotoButtonDidTap(selectedPhoto: selectedPhoto)
        }
    }
    
    // TODO: Add error handling when a photo loading is ready
    private func handleAddPhotoButtonDidTap(selectedPhoto: PhotosPickerItem) async {
        do {
            guard let imageData = try await selectedPhoto.loadTransferable(type: Data.self) else {
                return
            }
            
            print(imageData.base64EncodedString())
        } catch {
            print(error)
        }
    }
}
