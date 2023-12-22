//
//  UserRepository.swift
//  chameleon
//
//  Created by Анита Самчук on 22.12.2023.
//

final class UserRepository {
    private enum Constants {
        enum URLPath: String {
            case getUserProlileEndpoint = "/api/profiles/me/"
        }

        static let authorizationHeaderKey = "Authorization"
    }

    func getUser(authenticationToken: String) async -> ServerClientServiceResult<UserModel> {
        let headers: ServerClientServiceRequestHeaders = [
            Constants.authorizationHeaderKey: authenticationToken
        ]

        return await ServerClientService.shared.get(
            endpoint: Constants.URLPath.getUserProlileEndpoint.rawValue,
            headers: headers
        )
    }
}
