//
//  NavigationBarModel.swift
//  chameleon
//
//  Created by Ilia Chub on 24.11.2023.
//

struct NavigationBarModel {
    static let `default` = Self()

    var centralItemModel: NavigationBarCentralItemModel
    var leftItemModel: NavigationBarSideItemModel
    var rightItemsModels: [NavigationBarSideItemModel]
    var isLargeTitle: Bool

    init(
        centralItemModel: NavigationBarCentralItemModel = .init(type: .empty),
        leftItemModel: NavigationBarSideItemModel = .init(type: .empty),
        rightItemsModels: [NavigationBarSideItemModel] = [],
        isLargeTitle: Bool = false
    ) {
        self.centralItemModel = centralItemModel
        self.leftItemModel = leftItemModel
        self.rightItemsModels = rightItemsModels
        self.isLargeTitle = isLargeTitle
    }
}
