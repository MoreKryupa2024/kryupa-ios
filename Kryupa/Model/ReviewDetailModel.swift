//
//  ReviewDetailModel.swift
//  Kryupa
//
//  Created by Pooja Nenava on 26/06/24.
//

import Foundation

// MARK: - Welcome
struct ReviewDetailModel: Codable {
    let success: Bool
    let message: String?
    let data: ReviewDetailData
}

// MARK: - DataClass
struct ReviewDetailData: Codable {
    let reviewid, rating, averageRating, review: String
    let approchID, reviewTo, reviwedBy, approchid: String
    let bookingPricingForCustomer: Double
    let status, customerID, caregiverID, bookingid, startDate: String?
    let endDate, startTime, endTime, name, relation: String?
    let profilePictureURL: String?
    let yearsOfExprience: String?
    let cid, ratePerHours: String?
    let totalHours: Int

    enum CodingKeys: String, CodingKey {
        case reviewid, rating
        case averageRating = "average_rating"
        case review
        case approchID = "approch_id"
        case reviewTo = "review_to"
        case reviwedBy = "reviwed_by"
        case approchid
        case bookingPricingForCustomer = "booking_pricing_for_customer"
        case status
        case customerID = "customer_id"
        case caregiverID = "caregiver_id"
        case bookingid
        case startDate = "start_date"
        case endDate = "end_date"
        case startTime = "start_time"
        case endTime = "end_time"
        case name, relation
        case profilePictureURL = "profile_picture_url"
        case yearsOfExprience = "years_of_exprience"
        case cid
        case ratePerHours = "rate_per_hours"
        case totalHours = "total_hours"
    }
}
