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
    case error
    
    static func == (lhs: CalendarViewState, rhs: CalendarViewState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading), (.error, .error):
            return true
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
    let cells: [CalendarContentCellViewItem]
    let selectPhotoHandleClosure: ((PhotosPickerItem) async -> UIImage?)?
    let cropPhotoHandleClosure: Closure.Generic<UIImage?>?
    
    static func == (lhs: CalendarContentViewItem, rhs: CalendarContentViewItem) -> Bool {
        return lhs.pantonesOfDay == rhs.pantonesOfDay && lhs.cells == rhs.cells
    }
}

struct CalendarContentCellViewItem: Identifiable, Equatable {
    var id: String { dateString }
    
    let dateString: String
    let triplePantoneFeed: TriplePantoneFeedViewItem?
    let photos: [EvaluationFeedImageViewItem]
    let isToday: Bool
}

struct CalendarView: View {
    private enum Constants {
        static let photoLoadingErrorTitleKey = "defaultErrorTitle"
        static let photoLoadingButtonTitleKey = "defaultErrorButtonTitle"
        static let photoLoadingDescriptionKey = "defaultErrorDescription"
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
            case .error:
                CalendarErrorView()
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
        .sheet(isPresented: $viewModel.isNeedToShowSuccessPhotoLoadingSheet) {
            CalendarSuccessPhotoLoadingSheetView(
                points: viewModel.lastLoadedPhotoPoints,
                buttonDidTapClosure: viewModel.handleSuccessPhotoLoadingSheetButtonDidTap
            )
        }
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
                cropPhotoHandleClosure: nil
            )
            Spacer()
            ProgressView()
            Spacer()
        }
    }
}

private struct CalendarContentView: View {
    private enum Constants {
        static let emptyDescriptionKey = "calendarEmptyDescription"
    }
    
    let viewItem: CalendarContentViewItem
    let isActivityIndicatorPresented: Bool
    
    var body: some View {
        Group {
            if viewItem.cells.isEmpty {
                VStack(spacing: 0) {
                    CalendarHeaderView(
                        pantonesOfDay: viewItem.pantonesOfDay,
                        selectPhotoHandleClosure: viewItem.selectPhotoHandleClosure,
                        cropPhotoHandleClosure: viewItem.cropPhotoHandleClosure
                    )
                    Spacer()
                    Image(.ic64Fireworks)
                    Spacer()
                        .frame(height: 16)
                    Text(String(localized: String.LocalizationValue(Constants.emptyDescriptionKey)))
                        .foregroundStyle(Color(.textPrimary))
                        .font(.bodyBig)
                    Spacer()
                }
            } else {
                ZStack {
                    ScrollView {
                        VStack(spacing: 0) {
                            CalendarHeaderView(
                                pantonesOfDay: viewItem.pantonesOfDay,
                                selectPhotoHandleClosure: viewItem.selectPhotoHandleClosure,
                                cropPhotoHandleClosure: viewItem.cropPhotoHandleClosure
                            )
                            ForEach(viewItem.cells) {
                                CalendarContentCellView(viewItem: $0)
                                    .padding(.top, 10)
                            }
                            Spacer()
                                .frame(height: 20)
                        }
                    }
                    if isActivityIndicatorPresented {
                        Color(.backgroundCommon)
                            .opacity(isActivityIndicatorPresented ? 0.35 : 1)
                        VStack {
                            ProgressView()
                                .controlSize(.large)
                        }
                    }
                }
            }
        }
        .animation(.default, value: isActivityIndicatorPresented)
        .animation(.default, value: viewItem)
    }
}

private struct CalendarContentCellView: View {
    let viewItem: CalendarContentCellViewItem
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 1),
        GridItem(.flexible(), spacing: 1),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            HStack {
                Text(viewItem.dateString)
                    .foregroundStyle(Color(.textPrimary))
                    .font(viewItem.isToday ? .titlePrimary : .bodyBig)
                Spacer()
                if let triplePantoneFeed = viewItem.triplePantoneFeed {
                    TriplePantoneFeedView(viewItem: triplePantoneFeed, pantoneWidth: 25)
                }
            }
            .padding(.horizontal, 8)
            LazyVGrid(columns: columns, spacing: 1) {
                ForEach(viewItem.photos) {
                    EvaluatedImageFeedView(viewItem: $0)
                        .aspectRatio(1, contentMode: .fit)
                }
            }
            .padding(.horizontal, 1)
        }
    }
}

private struct CalendarHeaderView: View {
    let pantonesOfDay: TriplePantoneFeedViewItem
    let selectPhotoHandleClosure: ((PhotosPickerItem) async -> UIImage?)?
    let cropPhotoHandleClosure: Closure.Generic<UIImage?>?
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
                .frame(height: 50)
            HStack(alignment: .top) {
                Group {
                    if let selectPhotoHandleClosure, let cropPhotoHandleClosure {
                        CalendarAddPhotoView(
                            selectPhotoHandleClosure: selectPhotoHandleClosure,
                            cropPhotoHandleClosure: cropPhotoHandleClosure
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
    
    let selectPhotoHandleClosure: ((PhotosPickerItem) async -> UIImage?)
    let cropPhotoHandleClosure: Closure.Generic<UIImage?>
    
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
                self.selectedImage = await selectPhotoHandleClosure(selectedPhotoItem)
                
                if selectedImage != nil {
                    self.selectedPhotoItem = nil
                    self.isCropViewPresented = true
                }
            }
        }
        .fullScreenCover(isPresented: $isCropViewPresented) {
            if let selectedImage {
                SwiftyCropView(imageToCrop: selectedImage, maskShape: .square) {
                    self.isCropViewPresented = false
                    self.cropPhotoHandleClosure($0)
                    self.selectedImage = nil
                }
            }
        }
    }
}

private struct CalendarErrorView: View {
    private enum Constants {
        static let errorTitleKey = "defaultErrorTitle"
    }
    
    var body: some View {
        VStack(spacing: 16) {
            Image(.ic64ExclamationmarkCircle)
            Text(String(localized: String.LocalizationValue(Constants.errorTitleKey)))
        }
    }
}

private struct CalendarSuccessPhotoLoadingSheetView: View {
    private enum Constants {
        static let chameleonButtonTitleKey = "chameleonTitle"
        static let goodPhotoTitleKey = "calendarGoodPhotoTitle"
    }
    
    @State private var pointsDisplayString: String = .empty
    
    private let presentationDetent: PresentationDetent
    private let points: Int
    private let buttonDidTapClosure: Closure.Void
    
    init(points: Int, buttonDidTapClosure: @escaping Closure.Void) {
        let sheetHeight: CGFloat = 291
        
        self.presentationDetent = .height(sheetHeight)
        self.points = points
        self.buttonDidTapClosure = buttonDidTapClosure
    }
    
    var body: some View {
        VStack(spacing: 16) {
            Image(.ic64CheckmarkCircle)
            Text(String(localized: String.LocalizationValue(Constants.goodPhotoTitleKey)))
                .foregroundStyle(Color(.textPrimary))
                .font(.titlePrimary)
            Text(pointsDisplayString)
                .foregroundStyle(Color(.textPrimary))
                .font(.headingPrimary)
                .animation(.default, value: pointsDisplayString)
            ButtonView(
                styleType: .primary,
                content: String(localized: String.LocalizationValue(Constants.chameleonButtonTitleKey)),
                action: buttonDidTapClosure
            )
        }
        .padding(.horizontal, 46)
        .padding(.top, 48)
        .padding(.bottom, 12)
        .presentationDragIndicator(.hidden)
        .presentationDetents([presentationDetent])
        .onAppear {
            (0...points).enumerated().forEach { offset, element in
                Task {
                    try? await Task.sleep(nanoseconds: UInt64(offset * 30_000_000))
                    self.pointsDisplayString = String(element)
                }
            }
        }
    }
}
