//
//  TodayPantonesModel.swift
//  chameleon
//
//  Created by Ilia Chub on 11.12.2023.
//

import Foundation

struct TodayPantonesModel: Decodable {
    let pantones: [PantoneModel]
    let date: Date
    
    enum CodingKeys: String, CodingKey {
        case pantones = "colors"
        case date
    }
}
