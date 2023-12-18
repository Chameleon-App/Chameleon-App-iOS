//
//  AuthenticationRepository.swift
//  chameleon
//
//  Created by Ilia Chub on 18.12.2023.
//

final class AuthenticationRepository {
    private enum Constants {
        static let authenticationKeyUserDefaultsKey = "authenticationKey"
    }
    
    private let userDefaults = UserDefaults.standard
    
    func getIsUserAuthenticated() -> Bool {
        return getAuthenticationKey() != nil
    }
    
    func getAuthenticationKey() -> String? {
        return userDefaults.string(forKey: Constants.authenticationKeyUserDefaultsKey)
    }
}
