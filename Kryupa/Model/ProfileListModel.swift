//
//  ProfileListModel.swift
//  Kryupa
//
//  Created by Pooja Nenava on 18/06/24.
//

import Foundation

// MARK: - Welcome
struct ProfileListModel: Codable {
    let success: Bool
    let message: String?
    let data: ProfileListData
}

// MARK: - DataClass
struct ProfileListData: Codable {
    let profiles: [String]
}
