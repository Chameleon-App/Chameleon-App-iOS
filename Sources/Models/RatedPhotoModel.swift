//
//  RatedPhotoModel.swift
//  chameleon
//
//  Created by Ilia Chub on 15.12.2023.
//

import Foundation

struct RatedPhotoModel: Decodable, Identifiable {
    let id: Int
    let url: URL?
    let date: Date
    let points: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case url = "image_url"
        case date
        case points = "rating"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        url = try container.decodeIfPresent(URL.self, forKey: .url)
        points = try container.decode(Int.self, forKey: .points)

        let dateString = try container.decode(String.self, forKey: .date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateService.Constants.backendDateFormat
        
        guard let dateDecoded = dateFormatter.date(from: dateString) else {
            throw DecodingError.dataCorruptedError(forKey: .date, in: container, debugDescription: .empty)
        }
        
        date = dateDecoded
    }
}
