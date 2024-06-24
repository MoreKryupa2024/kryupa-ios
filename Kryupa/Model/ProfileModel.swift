//
//  ProfileModel.swift
//  Kryupa
//
//  Created by Pooja Nenava on 18/06/24.
//

import Foundation

// MARK: - Welcome
struct ProfileModel: Codable {
    let success: Bool
    let message: String?
    let data: ProfileData
}

// MARK: - DataClass
struct ProfileData: Codable {
    let customerName: String
    let profilePic: String?
    let relation: String

    enum CodingKeys: String, CodingKey {
        case customerName = "customer_name"
        case profilePic = "profile_pic"
        case relation
    }
}
