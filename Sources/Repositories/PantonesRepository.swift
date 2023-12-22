//
//  PantonesRepository.swift
//  chameleon
//
//  Created by Ilia Chub on 11.12.2023.
//

import Foundation

final class PantonesRepository {
    private enum Constants {
        enum URLPath: String {
            case getPantonesOfDayEndpoint = "/api/colors/today/"
        }
        
        static let lastShowDateUserDefaultsKey = "lastShowDate"
    }
    
    private let userDefaults = UserDefaults.standard
    
    var lastShowDate: Date {
        get { userDefaults.object(forKey: Constants.lastShowDateUserDefaultsKey) as? Date ?? Date.distantPast }
        set { userDefaults.setValue(newValue, forKey: Constants.lastShowDateUserDefaultsKey) }
    }
    
    func getPantonesOfDay() async -> ServerClientServiceResult<PantonesOfDayModel> {
        return await ServerClientService.shared.get(endpoint: Constants.URLPath.getPantonesOfDayEndpoint.rawValue)
    }
}
