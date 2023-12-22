//
//  DeeplinkService.swift
//  chameleon
//
//  Created by Ilia Chub on 18.12.2023.
//

import UIKit

final class DeeplinkService {
    static func openAppSettings() {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        
        UIApplication.shared.open(settingsUrl, options: [:], completionHandler: nil)
    }
}
