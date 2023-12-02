//
//  CalendarViewModel.swift
//  chameleon
//
//  Created by Ilia Chub on 22.01.2023.
//

import SwiftUI

class CalendarViewModel: ObservableObject {
    @Published private(set) var viewState: CalendarViewState
    
    private let serverHealthRepository: ServerHealthRepository
    
    private var coordinator: CalendarCoordinator

    init(coordinator: CalendarCoordinator) {
        self.serverHealthRepository = ServerHealthRepository()
        self.coordinator = coordinator
        self.viewState = .loading
    }
    
    func handleViewDidAppear() {
        Task { await configureIsServerHealth() }
    }
    
    private func configureIsServerHealth() async {
        switch await serverHealthRepository.getServerHealth() {
        case .success(let serverHealth):
            handleSeccessResult(serverHealth: serverHealth)
        case .failure(let error):
            handleError(error)
        }
    }
    
    private func handleSeccessResult(serverHealth successResult: ServerHealthModel) {
        let contentViewItem = CalendarContentViewItem(isServerHealth: successResult.isHealth)
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
}
