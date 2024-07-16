//
//  PaymentModel.swift
//  Kryupa
//
//  Created by Hemant Singh Rajput on 10/07/24.
//

import Foundation

// MARK: - Empty
struct PaymentModel: Codable {
    let success: Bool
    let message: String
    let data: PaymentData
    
    init(jsonData:[String:Any]){
        success = jsonData["success"] as? Bool ?? false
        message = jsonData["message"] as? String ?? ""
        data = PaymentData(jsonData: jsonData["data"] as? [String:Any] ?? [String:Any]())
    }
}

// MARK: - Datum
struct PaymentData: Codable {
    let id: String
    let bookingPricing, bookingPricingForCustomer: Int
    let bookingID, approchID, name, fulladdress: String
    let profilePictureURL: String
    let pricePerHour: Int
    let isActive, isDeleted: Bool
    let updatedBy, createdBy, paymentOrderID, createdAt: String
    let updatedAt: String

    init(jsonData:[String:Any]){
        id = jsonData["id"] as? String ?? ""
        bookingPricing = jsonData["booking_pricing"] as? Int ?? 0
        bookingPricingForCustomer = jsonData["booking_pricing_for_customer"] as? Int ?? 0
        bookingID = jsonData["booking_id"] as? String ?? ""
        approchID = jsonData["approch_id"] as? String ?? ""
        name = jsonData["name"] as? String ?? ""
        fulladdress = jsonData["fulladdress"] as? String ?? ""
        profilePictureURL = jsonData["profile_picture_url"] as? String ?? ""
        pricePerHour = jsonData["price_per_hour"] as? Int ?? 0
        isActive = jsonData["is_active"] as? Bool ?? false
        isDeleted = jsonData["is_deleted"] as? Bool ?? false
        updatedBy = jsonData["updated_by"] as? String ?? ""
        createdBy = jsonData["created_by"] as? String ?? ""
        paymentOrderID = jsonData["payment_order_id"] as? String ?? ""
        createdAt = jsonData["created_at"] as? String ?? ""
        updatedAt = jsonData["updated_at"] as? String ?? ""
    }
}
