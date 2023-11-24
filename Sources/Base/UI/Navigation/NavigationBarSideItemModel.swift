//
//  NavigationBarSideItemModel.swift
//  chameleon
//
//  Created by Ilia Chub on 24.11.2023.
//

import UIKit

struct NavigationBarSideItemModel {
    enum ItemType {
        case icon(UIImage)
        case title(String)
        case customView(UIView)
        case empty
    }
    
    let type: ItemType
    let isEnabled: Bool
    let onTapAction: Closure.Void?
    
    init(type: ItemType, isEnabled: Bool = true, onTapAction: Closure.Void? = nil) {
        self.type = type
        self.onTapAction = onTapAction
        self.isEnabled = isEnabled
    }
}
