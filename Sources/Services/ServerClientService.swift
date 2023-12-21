//
//  ServerClientService.swift
//  chameleon
//
//  Created by Ilia Chub on 02.12.2023.
//

import Foundation
import Alamofire

typealias ServerClientServiceError = URLError
typealias ServerClientServiceResult<ReturnValue> = Result<ReturnValue, ServerClientServiceError>
typealias ServerClientServiceRequestParameters = Encodable
typealias ServerClientServiceRequestHeaders = HTTPHeaders

struct EmptyParameters: Codable {}

final class ServerClientService {
    private enum Constants {
        static let uploadingPhotoKey = "photo"
        static let uploadingPhotoFileName = "file.jpeg"
        static let uploadingPhotoMimeType = "image/jpeg"
    }
    
    static let shared = ServerClientService()
    
    private let serverBaseUrl: String
    
    init() {
        serverBaseUrl = EnvironmentModel.serverBaseUrl
    }
    
    func get<ReturnValue: Decodable, Parameters: ServerClientServiceRequestParameters>(
        endpoint: String,
        parameters: Parameters = EmptyParameters(),
        headers: ServerClientServiceRequestHeaders? = nil
    ) async -> ServerClientServiceResult<ReturnValue> {
        return await performRequest(
            endpoint: endpoint,
            method: .get,
            parameters: parameters,
            encoder: URLEncodedFormParameterEncoder.default,
            headers: headers
        )
    }
    
    func post<ReturnValue: Decodable, Parameters: ServerClientServiceRequestParameters>(
        endpoint: String,
        parameters: Parameters = EmptyParameters(),
        headers: ServerClientServiceRequestHeaders? = nil
    ) async -> ServerClientServiceResult<ReturnValue> {
        return await performRequest(
            endpoint: endpoint,
            method: .post,
            parameters: parameters,
            encoder: JSONParameterEncoder.default,
            headers: headers
        )
    }
    
    func upload<ReturnValue: Decodable>(
        endpoint: String,
        jpegData: Data,
        headers: ServerClientServiceRequestHeaders? = nil
    ) async -> ServerClientServiceResult<ReturnValue> {
        let url = getUrlString(endpoint: endpoint)
        
        return await withCheckedContinuation { continuation in
            AF.upload(
                multipartFormData: {
                    $0.append(
                        jpegData,
                        withName: Constants.uploadingPhotoKey,
                        fileName: Constants.uploadingPhotoFileName,
                        mimeType: Constants.uploadingPhotoMimeType
                    )
                },
                to: url,
                headers: headers
            )
            .responseDecodable(of: ReturnValue.self) { [weak self] response in
                guard let result = self?.getResult(from: response.result) else {
                    return
                }
                
                continuation.resume(returning: result)
            }
        }
    }
    
    private func performRequest<ReturnValue: Decodable, Parameters: ServerClientServiceRequestParameters>(
        endpoint: String,
        method: HTTPMethod,
        parameters: Parameters? = nil,
        encoder: ParameterEncoder,
        headers: ServerClientServiceRequestHeaders?
    ) async -> ServerClientServiceResult<ReturnValue> {
        let url = getUrlString(endpoint: endpoint)
        
        let rawResult = await AF.request(
            url,
            method: method,
            parameters: parameters,
            encoder: encoder,
            headers: headers
        )
        .serializingDecodable(ReturnValue.self)
        .result
        
        if case .failure = rawResult {
            print(ReturnValue.self)
        }
        
        return getResult(from: rawResult)
    }
    
    private func getUrlString(endpoint: String) -> String {
        return serverBaseUrl + endpoint
    }
    
    private func getResult<ReturnValue: Decodable>(
        from rawResult: Result<ReturnValue, AFError>
    ) -> ServerClientServiceResult<ReturnValue> {
        switch rawResult {
        case .success(let returnValue):
            return .success(returnValue)
        case .failure(let rawError):
            let error = getError(from: rawError)
            
            return .failure(error)
        }
    }
    
    private func getError(from rawError: AFError) -> ServerClientServiceError {
        print(String(describing: rawError))
        
        let errorCode: ServerClientServiceError.Code
        
        if let rawErrorCode = rawError.responseCode {
            errorCode = ServerClientServiceError.Code(rawValue: rawErrorCode)
        } else {
            errorCode = .unknown
        }
        
        let error = ServerClientServiceError(errorCode)

        return error
    }
}
