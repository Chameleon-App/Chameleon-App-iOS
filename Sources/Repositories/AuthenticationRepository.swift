//
//  AuthenticationRepository.swift
//  chameleon
//
//  Created by Ilia Chub on 18.12.2023.
//

import Foundation

final class AuthenticationRepository {
    private enum Constants {
        enum URLPath: String {
            case loginEndpoint = "/api/auth/token/"
        }
        
        static let authenticationTokenUserDefaultsKey = "authenticationToken"
    }
    
    private let userDefaults = UserDefaults.standard
    
    func getIsUserAuthenticated() -> Bool {
        return getAuthenticationToken() != nil
    }
    
    func getAuthenticationToken() -> String? {
        return userDefaults.string(forKey: Constants.authenticationTokenUserDefaultsKey)
    }
    
    func login(username: String, password: String) async -> ServerClientServiceResult<Void> {
        let parameters = LoginParameters(username: username, password: password)
        
        let result: ServerClientServiceResult<AuthenticationTokenModel> = await ServerClientService.shared.post(
            endpoint: Constants.URLPath.loginEndpoint.rawValue,
            parameters: parameters
        ) 
        
        switch result {
        case .success(let token):
            saveAuthenticationToken(token.token)
            
            return .success(Void())
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func logout() {
        userDefaults.removeObject(forKey: Constants.authenticationTokenUserDefaultsKey)
    }
    
    private func saveAuthenticationToken(_ token: String) {
        userDefaults.setValue(token, forKey: Constants.authenticationTokenUserDefaultsKey)
    }
}

private struct LoginParameters: Encodable {
    let username: String
    let password: String
}
