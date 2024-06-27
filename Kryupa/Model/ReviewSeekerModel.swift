//
//  ReviewSeekerModel.swift
//  Kryupa
//
//  Created by Pooja Nenava on 25/06/24.
//

import Foundation

// MARK: - Welcome
struct ReviewSeekerModel: Codable {
    let success: Bool
    let message: String?
    let data: [ReviewSeekerData]
    let pageNumber: Int
}

// MARK: - Datum
struct ReviewSeekerData: Codable {
    let reviewid, createdAt, review, rating: String
    let approchID, caregiverID, name: String
    let profilePictureUrl: String?

    enum CodingKeys: String, CodingKey {
        case reviewid
        case createdAt = "created_at"
        case review, rating
        case approchID = "approch_id"
        case caregiverID = "caregiver_id"
        case name
        case profilePictureUrl = "profile_picture_url"
    }
}
