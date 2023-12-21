//
//  PhotosRepository.swift
//  chameleon
//
//  Created by Ilia Chub on 15.12.2023.
//

import Foundation

final class PhotosRepository {
    private enum Constants {
        enum URLPath: String {
            case getTopPhotosEndpoint = "/api/photos/top/"
            case uploadPhotoEndpoint = "/api/photos/rate/"
            case getPhotosByDaysEndpoint = "/api/days/"
        }
        
        static let authorizationHeaderKey = "Authorization"
    }
    
    func getPhotosByDays(authenticationToken: String) async -> ServerClientServiceResult<[PhotosOfDayModel]> {
        let headers: ServerClientServiceRequestHeaders = [
            Constants.authorizationHeaderKey: authenticationToken
        ]
        
        return await ServerClientService.shared.get(
            endpoint: Constants.URLPath.getPhotosByDaysEndpoint.rawValue,
            headers: headers
        )
    }
    
    func getTopPhotos(limit: Int) async -> ServerClientServiceResult<[RatedPhotoModel]> {
        let parameters = GetPhotosParameters(limit: limit)
        
        return await ServerClientService.shared.get(
            endpoint: Constants.URLPath.getTopPhotosEndpoint.rawValue,
            parameters: parameters
        )
    }
    
    func uploadPhoto(jpegData: Data, authenticationToken: String) async -> ServerClientServiceResult<Void> {
        let headers: ServerClientServiceRequestHeaders = [
            Constants.authorizationHeaderKey: authenticationToken
        ]
        
        let result: ServerClientServiceResult<UploadPhotoSuccessResultModel> = await ServerClientService.shared.upload(
            endpoint: Constants.URLPath.uploadPhotoEndpoint.rawValue,
            jpegData: jpegData,
            headers: headers
        )
        
        switch result {
        case .success:
            return .success(Void())
        case .failure(let error):
            return .failure(error)
        }
    }
}

private struct GetPhotosParameters: Encodable {
    let limit: Int
}
