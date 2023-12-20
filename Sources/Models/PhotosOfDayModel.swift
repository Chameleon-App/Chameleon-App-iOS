//
//  PhotosOfDayModel.swift
//  chameleon
//
//  Created by Ilia Chub on 21.12.2023.
//

struct PhotosOfDayModel: Decodable {
    let pantones: [PantoneModel]
    let photos: [RatedPhotoModel]
    
    enum CodingKeys: String, CodingKey {
        case pantones = "colors"
        case photos
    }
}
