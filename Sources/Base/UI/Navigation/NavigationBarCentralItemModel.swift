//
//  NavigationBarCentralItemModel.swift
//  chameleon
//
//  Created by Ilia Chub on 24.11.2023.
//

import UIKit

struct NavigationBarCentralItemModel {
    enum ItemType {
        case title(String)
        case customView(UIView)
        case empty
    }

    let type: ItemType
    var isLayoutWithAnimation = false
    var onTapAction: Closure.Void?
}
