//
//  CalendarView.swift
//  chameleon
//
//  Created by Ilia Chub on 25.11.2023.
//

import SwiftUI
import PhotosUI
import SwiftyCrop

enum CalendarViewState: Equatable {
    case loading(CalendarLoadingViewItem)
    case content(CalendarContentViewItem)
    case error(CalendarErrorViewItem)
    
    static func == (lhs: CalendarViewState, rhs: CalendarViewState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading):
            return true
        case (.error(let lhsError), .error(let rhsError)):
            return lhsError.message == rhsError.message
        case (.content(let lhsContent), .content(let rhsContent)):
            return lhsContent == rhsContent
        default:
            return false
        }
    }
}

struct CalendarLoadingViewItem: Equatable {
    let pantonesOfDay: TriplePantoneFeedViewItem
}

struct CalendarContentViewItem: Equatable {
    let pantonesOfDay: TriplePantoneFeedViewItem
    let selectPhotoHandleClosure: ((PhotosPickerItem?) async -> UIImage?)?
    let croppPhotoHandleClosure: Closure.Generic<UIImage?>?
    
    static func == (lhs: CalendarContentViewItem, rhs: CalendarContentViewItem) -> Bool {
        return lhs.pantonesOfDay == rhs.pantonesOfDay
    }
}

struct CalendarErrorViewItem {
    let message: String
}

struct CalendarView: View {
    private enum Constants {
        static let photoLoadingErrorTitleKey = "loginErrorTitle"
        static let photoLoadingButtonTitleKey = "loginErrorButtonTitle"
        static let photoLoadingDescriptionKey = "loginErrorDescription"
    }
    
    @ObservedObject var viewModel: CalendarViewModel
    
    var body: some View {
        Group {
            switch viewModel.viewState {
            case .loading(let loadingViewItem):
                CalendarLoaingView(viewItem: loadingViewItem)
            case .content(let contentViewItem):
                CalendarContentView(
                    viewItem: contentViewItem,
                    isActivityIndicatorPresented: viewModel.isActivityIndicatorPresented
                )
            case .error(let errorViewItem):
                Text(errorViewItem.message)
            }
        }
        .alert(
            String(localized: String.LocalizationValue(Constants.photoLoadingErrorTitleKey)),
            isPresented: $viewModel.isPhotoLoadingErrorAlertPresented,
            actions: {
                Button(
                    String(localized: String.LocalizationValue(Constants.photoLoadingButtonTitleKey)),
                    role: .none,
                    action: viewModel.handlePhotoLoadingErrorAlertButtonDidTap
                )
            },
            message: {
                Text(String(localized: String.LocalizationValue(Constants.photoLoadingDescriptionKey)))
                    .foregroundColor(Color(.textPrimary))
            }
        )
        .animation(.default, value: viewModel.viewState)
        .onAppear { viewModel.handleViewDidAppear() }
    }
}

private struct CalendarLoaingView: View {
    let viewItem: CalendarLoadingViewItem
    
    var body: some View {
        VStack(spacing: 0) {
            CalendarHeaderView(
                pantonesOfDay: viewItem.pantonesOfDay,
                selectPhotoHandleClosure: nil,
                croppPhotoHandleClosure: nil
            )
            Spacer()
            ProgressView()
            Spacer()
        }
    }
}

private struct CalendarContentView: View {
    let viewItem: CalendarContentViewItem
    let isActivityIndicatorPresented: Bool
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                CalendarHeaderView(
                    pantonesOfDay: viewItem.pantonesOfDay,
                    selectPhotoHandleClosure: viewItem.selectPhotoHandleClosure,
                    croppPhotoHandleClosure: viewItem.croppPhotoHandleClosure
                )
                Spacer()
            }
            .opacity(isActivityIndicatorPresented ? 0.25 : 1)
            if isActivityIndicatorPresented {
                VStack {
                    ProgressView()
                        .controlSize(.large)
                }
            }
        }
        .animation(.default, value: isActivityIndicatorPresented)
    }
}

private struct CalendarHeaderView: View {
    let pantonesOfDay: TriplePantoneFeedViewItem
    let selectPhotoHandleClosure: ((PhotosPickerItem?) async -> UIImage?)?
    let croppPhotoHandleClosure: Closure.Generic<UIImage?>?
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
                .frame(height: 50)
            HStack(alignment: .top) {
                Group {
                    if let selectPhotoHandleClosure, let croppPhotoHandleClosure {
                        CalendarAddPhotoView(
                            selectPhotoHandleClosure: selectPhotoHandleClosure,
                            croppPhotoHandleClosure: croppPhotoHandleClosure
                        )
                    } else {
                        Spacer()
                    }
                }
                .frame(width: 75)
                Spacer()
                    .frame(width: 18)
                Color(.borderPrimary)
                    .frame(width: 1, height: 75)
                Spacer()
                    .frame(width: 18)
                TriplePantoneFeedView(viewItem: pantonesOfDay, pantoneWidth: 75)
            }
            .padding(.horizontal, 10)
            Spacer()
                .frame(height: 10)
            Color(.borderPrimary)
                .frame(height: 1)
        }
    }
}

private struct CalendarAddPhotoView: View {
    private enum Constants {
        static let addPhotosTitleKey = "addPhotoTitle"
    }
    
    let selectPhotoHandleClosure: ((PhotosPickerItem?) async -> UIImage?)
    let croppPhotoHandleClosure: Closure.Generic<UIImage?>
    
    @State private var selectedPhotoItem: PhotosPickerItem?
    @State private var selectedImage: UIImage?
    @State private var isCropViewPresented = false
    
    var body: some View {
        PhotosPicker(selection: $selectedPhotoItem, matching: .images) {
            VStack(spacing: 5) {
                ZStack {
                    Circle()
                        .stroke(Color(.borderPrimary), lineWidth: 2)
                        .aspectRatio(1, contentMode: .fit)
                    Image(.ic32Camera)
                }
                Text(String(localized: String.LocalizationValue(Constants.addPhotosTitleKey)))
                    .foregroundStyle(Color(.textPrimary))
                    .font(.bodySmall)
                    .lineLimit(3)
                    .multilineTextAlignment(.center)
            }
        }
        .photosPickerDisabledCapabilities(.collectionNavigation)
        .onChange(of: selectedPhotoItem) {
            guard let selectedPhotoItem else {
                return
            }
            
            Task {
                selectedImage = await selectPhotoHandleClosure(selectedPhotoItem)
                
                if selectedImage != nil {
                    self.selectedPhotoItem = nil
                    isCropViewPresented = true
                }
            }
        }
        .fullScreenCover(isPresented: $isCropViewPresented) {
            if let selectedImage {
                SwiftyCropView(imageToCrop: selectedImage, maskShape: .square) {
                    self.isCropViewPresented = false
                    self.croppPhotoHandleClosure($0)
                    self.selectedImage = nil
                }
            }
        }
    }
}
