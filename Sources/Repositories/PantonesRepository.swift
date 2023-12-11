//
//  PantonesRepository.swift
//  chameleon
//
//  Created by Ilia Chub on 11.12.2023.
//

final class PantonesRepository {
    private enum Constants {
        enum URLPath: String {
            case getPantonesOfDayEndpoint = "/api/colors/today/"
        }
    }
    
    func getPantonesOfDay() async -> ServerClientServiceResult<PantonesOfDayModel> {
        return await ServerClientService.shared.get(endpoint: Constants.URLPath.getPantonesOfDayEndpoint.rawValue)
    }
}
