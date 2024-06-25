//
//  ProfileGiverModel.swift
//  Kryupa
//
//  Created by Pooja Nenava on 25/06/24.
//

import Foundation

// MARK: - Welcome
struct ProfileGiverModel: Codable {
    let success: Bool
    let message: String?
    let data: ProfileGiverDataClass
}

// MARK: - DataClass
struct ProfileGiverDataClass: Codable {
    let name: String
    let profileURL: String

    enum CodingKeys: String, CodingKey {
        case name
        case profileURL = "profile_url"
    }
}
