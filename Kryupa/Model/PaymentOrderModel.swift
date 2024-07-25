//
//  PaymentOrderModel.swift
//  Kryupa
//
//  Created by Hemant Singh Rajput on 24/07/24.
//

import Foundation

// MARK: - Welcome
struct PaymentOrderModel {
    let data: PaymentOrderData
    let success: Bool
    let message: String
    
    init(jsonData: [String:Any]){
        message = jsonData["message"] as? String ?? ""
        success = jsonData["success"] as? Bool ?? true
        data = PaymentOrderData(jsonData:jsonData["data"] as? [String:Any] ?? [String:Any]())
    }
}

// MARK: - DataClass
struct PaymentOrderData {
    let name: String
    let profilePictureURL: String
    let bookingPricingForCustomer: Int
    let approchID, fulladdress, bookingID: String
    let pricePerHour: Int
    let createdAt, updatedAt, updatedBy, createdBy: String
    let bookingPricing: Int
    let startDate, endDate, startTime, endTime: String
    let hours: String

    init(jsonData:[String:Any]){
        name = jsonData["name"] as? String ?? ""
        profilePictureURL = jsonData["profile_picture_url"] as? String ?? ""
        bookingPricingForCustomer = jsonData["booking_pricing_for_customer"] as? Int ?? 0
        approchID = jsonData["approch_id"] as? String ?? ""
        fulladdress = jsonData["fulladdress"] as? String ?? ""
        bookingID = jsonData["booking_id"] as? String ?? ""
        pricePerHour = jsonData["price_per_hour"] as? Int ?? 0
        createdAt = jsonData["created_at"] as? String ?? ""
        updatedAt = jsonData["updated_at"] as? String ?? ""
        updatedBy = jsonData["updated_by"] as? String ?? ""
        createdBy = jsonData["created_by"] as? String ?? ""
        bookingPricing = jsonData["booking_pricing"] as? Int ?? 0
        startDate = jsonData["start_date"] as? String ?? ""
        endDate = jsonData["end_date"] as? String ?? ""
        startTime = jsonData["start_time"] as? String ?? ""
        endTime = jsonData["end_time"] as? String ?? ""
        hours = jsonData["hours"] as? String ?? ""
    }
}
