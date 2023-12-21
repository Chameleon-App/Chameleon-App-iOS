//
//  UploadPhotoSuccessResultModel.swift
//  chameleon
//
//  Created by Ilia Chub on 20.12.2023.
//

import Foundation

struct UploadPhotoSuccessResultModel: Decodable {
    let id: Int
    let points: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case points = "rating"
    }
}
