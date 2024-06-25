//
//  CareGiverDetailModel.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 06/06/24.
//

import Foundation

// MARK: - Empty
struct CareGiverDetailModel {
    let success: Bool
    let message: String
    let data: CareGiverDetailData
    init(jsonData:[String:Any]){
        success = jsonData["success"] as? Bool ?? false
        message = jsonData["message"] as? String ?? ""
        data = CareGiverDetailData(jsonData: jsonData["data"] as? [String:Any] ?? [String:Any]())
    }
    
}

// MARK: - DataClass
struct CareGiverDetailData {
    let id: String
    let profileURL: String
    let name: String
    let yearOfExperience: Int
    let language: [String]
    let bio: String
    let totalReviewer: Int
    let pricePerHour: Int
    let avgRating: Double
    let reviewList: [String]
    
    init(jsonData:[String:Any]){
        id = jsonData["id"] as? String ?? ""
        profileURL = jsonData["profile_url"] as? String ?? ""
        language = jsonData["language"] as? [String] ?? []
        yearOfExperience = jsonData["year_of_experience"] as? Int ?? 0
        name = jsonData["name"] as? String ?? ""
        bio = jsonData["bio"] as? String ?? ""
        totalReviewer = jsonData["total_reviewer"] as? Int ?? 0
        pricePerHour = jsonData["price_per_hour"] as? Int ?? 0
        avgRating = jsonData["avg_rating"] as? Double ?? 0.0
        reviewList = jsonData["reviewList"] as? [String] ?? []
    }

}
