//
//  PantonesOfDayModel.swift
//  chameleon
//
//  Created by Ilia Chub on 11.12.2023.
//

import Foundation

struct PantonesOfDayModel: Decodable {
    let pantones: [PantoneModel]
    
    enum CodingKeys: String, CodingKey {
        case pantones = "colors"
    }
}
