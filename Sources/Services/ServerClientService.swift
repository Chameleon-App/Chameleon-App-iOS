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

final class ServerClientService {
    let serverBaseUrl: String
    
    init() {
        serverBaseUrl = Environment.serverBaseUrl
    }

    func get<ReturnValue: Decodable, Parameters: ServerClientServiceRequestParameters>(
        endpoint: String,
        parameters: Parameters? = nil,
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
        parameters: Parameters? = nil,
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
    
    private func performRequest<ReturnValue: Decodable, Parameters: ServerClientServiceRequestParameters>(
        endpoint: String,
        method: HTTPMethod,
        parameters: Parameters?,
        encoder: ParameterEncoder,
        headers: ServerClientServiceRequestHeaders?
    ) async -> ServerClientServiceResult<ReturnValue> {
        let url = serverBaseUrl + endpoint
        
        let response = await AF.request(
            url,
            method: method,
            parameters: parameters,
            encoder: encoder,
            headers: headers
        )
        .serializingDecodable(ReturnValue.self)
        .result
        
        switch response {
        case .success(let returnValue):
            return .success(returnValue)
        case .failure(let rawError):
            let errorCode: ServerClientServiceError.Code
            
            if let rawErrorCode = rawError.responseCode {
                errorCode = ServerClientServiceError.Code(rawValue: rawErrorCode)
            } else {
                errorCode = .unknown
            }
            
            let error = ServerClientServiceError(errorCode)

            return .failure(error)
        }
    }
}
