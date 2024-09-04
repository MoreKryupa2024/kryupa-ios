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
    let areaOfExperties: [String]
    let bio: String
    var showBookNow: Bool
    let totalReviewer: Int
    let pricePerHour: Int
    let avgRating: Double
    let reviewList: [ReviewListData]
    
    init(jsonData:[String:Any]){
        showBookNow = jsonData["show_book_now"] as? Bool ?? false
        id = jsonData["id"] as? String ?? ""
        profileURL = jsonData["profile_url"] as? String ?? ""
        language = jsonData["language"] as? [String] ?? []
        areaOfExperties = jsonData["area_of_experties"] as? [String] ?? []
        yearOfExperience = jsonData["year_of_experience"] as? Int ?? 0
        name = jsonData["name"] as? String ?? ""
        bio = jsonData["bio"] as? String ?? ""
        totalReviewer = jsonData["total_reviewer"] as? Int ?? 0
        pricePerHour = jsonData["price_per_hour"] as? Int ?? 0
        avgRating = jsonData["avg_rating"] as? Double ?? 0.0
        reviewList = (jsonData["reviewList"] as? [[String:Any]] ?? [[String:Any]]()).map{ ReviewListData(jsonData:$0)}
    }
}

// MARK: - ReviewList
struct ReviewListData {
    let reviewID, reviewedBy, reviewedByName: String
    let reviewedByProfilePictureURL: String
    let rating: Double
    let review, createdAt, updatedAt: String

    init(jsonData:[String:Any]){
        reviewID = jsonData["review_id"] as? String ?? ""
        reviewedBy = jsonData["reviewed_by"] as? String ?? ""
        reviewedByName = jsonData["reviewed_by_name"] as? String ?? ""
        //
        reviewedByProfilePictureURL = jsonData["reviewed_by_profile_picture_url"] as? String ?? jsonData["profile_picture"] as? String ?? ""
        rating = jsonData["rating"] as? Double ?? 0.0
        review = jsonData["review"] as? String ?? ""
        createdAt = jsonData["created_at"] as? String ?? ""
        updatedAt = jsonData["updated_at"] as? String ?? ""
    }
}
