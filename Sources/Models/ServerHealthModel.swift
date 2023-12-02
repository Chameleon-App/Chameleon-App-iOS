//
//  ServerHealthModel.swift
//  chameleon
//
//  Created by Ilia Chub on 02.12.2023.
//

struct ServerHealthModel: Decodable {
    private enum Constants {
        static let goodHealthStatus = "ok"
    }
    
    let isHealth: Bool
    
    enum CodingKeys: String, CodingKey {
        case isHealth = "health"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let healthStatus = try container.decode(String.self, forKey: .isHealth)
        
        self.isHealth = healthStatus == Constants.goodHealthStatus
    }
}
