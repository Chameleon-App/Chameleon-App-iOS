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
            case checkTokenEndpoint = "/api/auth/check_token/"
        }
        
        static let authenticationTokenUserDefaultsKey = "authenticationToken"
        static let authenticationHeaderPrefix = "Token "
    }
    
    private let userDefaults = UserDefaults.standard
    
    func getIsUserAuthenticated() async -> Bool {
        guard let authenticationToken = getAuthenticationToken() else {
            logout()
            
            return false
        }
        
        let parameters = CheckTokenParameters(token: authenticationToken)
        
        let checkTokenResult: ServerClientServiceResult<
            CheckAuthenticationTokenResultModel
        > = await ServerClientService.shared.post(
            endpoint: Constants.URLPath.checkTokenEndpoint.rawValue,
            parameters: parameters
        )
        
        let result: Bool
        
        switch checkTokenResult {
        case .success(let successModel):
            result = successModel.isTokenAlive
        case .failure:
            result = false
        }
        
        if result == false {
            logout()
        }
        
        return result
    }
    
    func getAuthenticationHeader() async -> String? {
        guard await getIsUserAuthenticated(), let authenticationToken = getAuthenticationToken() else {
            logout()
            
            return nil
        }
        
        return Constants.authenticationHeaderPrefix + authenticationToken
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
    
    private func getAuthenticationToken() -> String? {
        return userDefaults.string(forKey: Constants.authenticationTokenUserDefaultsKey)
    }
}

private struct LoginParameters: Encodable {
    let username: String
    let password: String
}

private struct CheckTokenParameters: Encodable {
    let token: String
}
