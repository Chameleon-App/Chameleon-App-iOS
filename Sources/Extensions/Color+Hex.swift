//
//  Color+Hex.swift
//  chameleon
//
//  Created by Ilia Chub on 11.12.2023.
//

import UIKit
import SwiftUI

extension Color {
    init?(hex: String) {
        guard let uiColor = UIColor(hex: hex) else {
            return nil
        }
        
        self = Color(uiColor: uiColor)
    }
}
