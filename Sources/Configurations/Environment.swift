//
//  Environment.swift
//  chameleon
//
//  Created by Ilia Chub on 02.12.2023.
//

final class Environment {
    enum ConfigKey: String, CaseIterable {
        case serverBaseUrl = "SERVER_BASE_URL"
    }

    static var serverBaseUrl: String { value(for: .serverBaseUrl) ?? .empty }
    
    static func value<T: LosslessStringConvertible>(for key: Environment.ConfigKey) -> T? {
        return try? EnvironmentConfiguration.value(for: key.rawValue)
    }
}
