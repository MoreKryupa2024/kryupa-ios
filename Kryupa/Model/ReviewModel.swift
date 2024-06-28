//
//  ReviewSeekerModel.swift
//  Kryupa
//
//  Created by Pooja Nenava on 25/06/24.
//

import Foundation

// MARK: - Welcome
struct ReviewModel: Codable {
    let success: Bool
    let message: String?
    let data: [ReviewData]
    let pageNumber, pageLimit: Int?
}

// MARK: - Datum
struct ReviewData: Codable {
    let reviewid, createdAt, review, rating: String
    let approchID, customerId, caregiverID, name, relation: String?
    let profilePictureUrl: String?

    enum CodingKeys: String, CodingKey {
        case reviewid
        case createdAt = "created_at"
        case review, rating
        case approchID = "approch_id"
        case customerId = "customer_id"
        case caregiverID = "caregiver_id"
        case name, relation
        case profilePictureUrl = "profile_picture_url"
    }
}
