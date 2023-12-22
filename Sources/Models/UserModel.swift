//
//  UserModel.swift
//  chameleon
//
//  Created by Анита Самчук on 22.12.2023.
//

import Foundation

struct UserModel: Decodable, Identifiable {
    let id: Int
    let username: String
    let photos: [RatedPhotoModel]
    let profilePhoto: URL
    let totalPhotos: Int
    let totalRating: Int
    let currentStreak: Int

    enum CodingKeys: String, CodingKey {
        case id
        case username
        case photos
        case profilePhoto = "profile_photo_url"
        case totalPhotos = "total_photos"
        case totalRating = "total_rating"
        case currentStreak = "current_streak"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        username = try container.decodeIfPresent(String.self, forKey: .username) ?? .empty
        photos = try container.decode(Array<RatedPhotoModel>.self, forKey: .photos)
        profilePhoto = try container.decode(URL.self, forKey: .profilePhoto)
        totalPhotos = try container.decodeIfPresent(Int.self, forKey: .totalPhotos) ?? .zero
        totalRating = try container.decodeIfPresent(Int.self, forKey: .totalRating) ?? .zero
        currentStreak = try container.decodeIfPresent(Int.self, forKey: .currentStreak) ?? .zero
    }
}
