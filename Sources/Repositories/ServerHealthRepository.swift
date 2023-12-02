//
//  ServerHealthRepository.swift
//  chameleon
//
//  Created by Ilia Chub on 02.12.2023.
//

final class ServerHealthRepository {
    private enum Constants {
        enum URLPath: String {
            case getIsHealthEndpoint = "/health"
        }
    }
    
    func getServerHealth() async -> ServerClientServiceResult<ServerHealthModel> {
        return await ServerClientService.shared.get(endpoint: Constants.URLPath.getIsHealthEndpoint.rawValue)
    }
}
