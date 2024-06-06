//
//  CareGiverDetailModel.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 06/06/24.
//

import Foundation

// MARK: - Empty
struct CareGiverDetailModel: Codable {
    let success: Bool
    let message: String
    let data: CareGiverDetailData
}

// MARK: - DataClass
struct CareGiverDetailData: Codable {
    let id, profileUrl, name, yearOfExperience: String
    let language, bio: String
    let totalReviewer: Int
    let avgRating: Double

}
