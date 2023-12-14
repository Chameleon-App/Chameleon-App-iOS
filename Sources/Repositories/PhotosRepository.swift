//
//  PhotosRepository.swift
//  chameleon
//
//  Created by Ilia Chub on 15.12.2023.
//

struct GetPhotosParameters: Codable {
    let limit: Int
}

final class PhotosRepository {
    private enum Constants {
        enum URLPath: String {
            case getTopPhotosEndpoint = "/api/photos/top/"
        }
    }
    
    func getTopPhotos(limit: Int) async -> ServerClientServiceResult<[RatedPhotoModel]> {
        let parameters = GetPhotosParameters(limit: limit)
        
        return await ServerClientService.shared.get(
            endpoint: Constants.URLPath.getTopPhotosEndpoint.rawValue,
            parameters: parameters
        )
    }
}
