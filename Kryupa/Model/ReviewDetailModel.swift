//
//  ReviewDetailModel.swift
//  Kryupa
//
//  Created by Pooja Nenava on 26/06/24.
//

import Foundation

// MARK: - Welcome
struct ReviewDetailModel {
    let success: Bool
    let message: String
    let data: ReviewDetailData
    
    init(jsonData:[String:Any]){
        success = jsonData["success"] as? Bool ?? false
        message = jsonData["message"] as? String ?? ""
        data = ReviewDetailData(jsonData: jsonData["data"] as? [String:Any] ?? [String:Any]())
    }
}

// MARK: - DataClass
struct ReviewDetailData {
    let reviewid, rating, averageRating, review: String
    let approchID, reviewTo, reviwedBy, approchid: String
    let bookingPricingForCustomer: Double
    let status, customerID, caregiverID, bookingid, startDate: String?
    let endDate, startTime, endTime, name, relation: String?
    let profilePictureURL: String
    let yearsOfExprience: String
    let cid, ratePerHours: String
    let totalHours: Int

    init(jsonData:[String:Any]){
        reviewid = jsonData["reviewid"] as? String ?? ""
        rating = jsonData["rating"] as? String ?? ""
        averageRating = jsonData["average_rating"] as? String ?? ""
        review = jsonData["review"] as? String ?? ""
        approchID = jsonData["approch_id"] as? String ?? ""
        reviewTo = jsonData["review_to"] as? String ?? ""
        reviwedBy = jsonData["reviwed_by"] as? String ?? ""
        approchid = jsonData["approchid"] as? String ?? ""
        bookingPricingForCustomer = jsonData["booking_pricing_for_customer"] as? Double ?? 0
        status = jsonData["status"] as? String ?? ""
        customerID = jsonData["customer_id"] as? String ?? ""
        caregiverID = jsonData["caregiver_id"] as? String ?? ""
        bookingid = jsonData["bookingid"] as? String ?? ""
        startDate = jsonData["start_date"] as? String ?? ""
        endDate = jsonData["end_date"] as? String ?? ""
        startTime = jsonData["start_time"] as? String ?? ""
        endTime = jsonData["end_time"] as? String ?? ""
        name = jsonData["name"] as? String ?? ""
        relation = jsonData["relation"] as? String ?? ""
        profilePictureURL = jsonData["profile_picture_url"] as? String ?? ""
        yearsOfExprience = jsonData["years_of_exprience"] as? String ?? ""
        cid = jsonData["cid"] as? String ?? ""
        ratePerHours = jsonData["rate_per_hours"] as? String ?? ""
        totalHours = jsonData["total_hours"] as? Int ?? 0
    }
}
