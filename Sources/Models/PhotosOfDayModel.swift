//
//  PhotosOfDayModel.swift
//  chameleon
//
//  Created by Ilia Chub on 21.12.2023.
//

import Foundation

struct PhotosOfDayModel: Decodable {
    let date: Date
    let pantones: [PantoneModel]
    let photos: [RatedPhotoModel]
    
    enum CodingKeys: String, CodingKey {
        case date
        case pantones = "colors"
        case photos
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let dateString = try container.decode(String.self, forKey: .date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateService.Constants.backendDateFormat
        
        guard let dateDecoded = dateFormatter.date(from: dateString) else {
            throw DecodingError.dataCorruptedError(forKey: .date, in: container, debugDescription: .empty)
        }
        
        self.date = dateDecoded
        self.pantones = try container.decode(Array<PantoneModel>.self, forKey: .pantones)
        self.photos = try container.decode(Array<RatedPhotoModel>.self, forKey: .photos)
    }
}
