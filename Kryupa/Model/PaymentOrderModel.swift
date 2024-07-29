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
    let bookingPricingForCustomer: Double
    let approchID, fulladdress, bookingID: String
    let pricePerHour: Double
    let diffrenceAmount: Double
    let createdAt, updatedAt, updatedBy, createdBy: String
    let bookingPricing: Int
    let startDate, endDate, startTime, endTime: String
    let hours: Double
    let walletBalance: Double
    let areasOfExpertise: [String]

    init(jsonData:[String:Any]){
        name = jsonData["name"] as? String ?? ""
        walletBalance = (Double(jsonData["wallet_balance"] as? Int ?? 0))
        profilePictureURL = jsonData["profile_picture_url"] as? String ?? ""
        bookingPricingForCustomer = Double(jsonData["booking_pricing_for_customer"] as? Int ?? 0)
        approchID = jsonData["approch_id"] as? String ?? ""
        fulladdress = jsonData["fulladdress"] as? String ?? ""
        bookingID = jsonData["booking_id"] as? String ?? ""
        pricePerHour = Double(jsonData["price_per_hour"] as? Int ?? 0)
        createdAt = jsonData["created_at"] as? String ?? ""
        updatedAt = jsonData["updated_at"] as? String ?? ""
        updatedBy = jsonData["updated_by"] as? String ?? ""
        createdBy = jsonData["created_by"] as? String ?? ""
        bookingPricing = jsonData["booking_pricing"] as? Int ?? 0
        startDate = jsonData["start_date"] as? String ?? ""
        endDate = jsonData["end_date"] as? String ?? ""
        startTime = jsonData["start_time"] as? String ?? ""
        endTime = jsonData["end_time"] as? String ?? ""
        hours = Double(jsonData["hours"] as? String ?? "") ?? 0
        diffrenceAmount = bookingPricingForCustomer - walletBalance
        areasOfExpertise = jsonData["areas_of_expertise"] as? [String] ?? []
    }
}

// MARK: - Welcome
struct BankListModel {
    let success: Bool
    let message: String
    let data: [BankListData]
    
    init(jsonData:[String:Any]){
        success = jsonData["success"] as? Bool ?? false
        message = jsonData["message"] as? String ?? ""
        data = (jsonData["data"] as? [[String:Any]] ?? [[String:Any]]()).map{ BankListData(jsonData: $0)}
    }
}

// MARK: - Datum
struct BankListData {
    let id, userID, userType, routingNumber: String
    let accountNumber, bankName: String
    let isPrimary, isActive, isDeleted: Bool
    let updatedBy: String?
    let createdAt, updatedAt: String

    init(jsonData:[String:Any]){
        id = jsonData["id"] as? String ?? ""
        userID = jsonData["user_id"] as? String ?? ""
        userType = jsonData["user_type"] as? String ?? ""
        routingNumber = jsonData["routing_number"] as? String ?? ""
        accountNumber = jsonData["account_number"] as? String ?? ""
        bankName = jsonData["bank_name"] as? String ?? ""
        isPrimary = jsonData["is_primary"] as? Bool ?? false
        isActive = jsonData["is_active"] as? Bool ?? false
        isDeleted = jsonData["is_deleted"] as? Bool ?? false
        updatedBy = jsonData["updated_by"] as? String ?? ""
        createdAt = jsonData["created_at"] as? String ?? ""
        updatedAt = jsonData["updated_at"] as? String ?? ""
    }
}
