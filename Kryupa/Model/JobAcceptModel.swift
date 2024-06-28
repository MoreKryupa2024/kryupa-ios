//
//  JobAcceptModel.swift
//  Kryupa
//
//  Created by Pooja Nenava on 27/06/24.
//

import Foundation

// MARK: - Welcome
struct JobAcceptModel: Codable {
    let data: [JobAcceptData]
    let message: String
    let success: Bool
}

// MARK: - Datum
struct JobAcceptData: Codable {
    let id, status, bookingID: String
    let isActive, isDeleted: Bool
    let updatedBy, createdAt, updatedAt, caregiverID: String
    let customerID: String
    let bookingPricing, bookingPricingForCustomer: Double

    enum CodingKeys: String, CodingKey {
        case id, status
        case bookingID = "booking_id"
        case isActive = "is_active"
        case isDeleted = "is_deleted"
        case updatedBy = "updated_by"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case caregiverID = "caregiver_id"
        case customerID = "customer_id"
        case bookingPricing = "booking_pricing"
        case bookingPricingForCustomer = "booking_pricing_for_customer"
    }
}
