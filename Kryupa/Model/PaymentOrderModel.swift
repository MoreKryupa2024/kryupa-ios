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
        walletBalance = (jsonData["wallet_balance"] as? Double ?? Double(jsonData["wallet_balance"] as? Int ?? Int(jsonData["wallet_balance"] as? String ?? "") ?? 0))
        profilePictureURL = jsonData["profile_picture_url"] as? String ?? ""
        bookingPricingForCustomer = (jsonData["booking_pricing_for_customer"] as? Double ?? Double(jsonData["booking_pricing_for_customer"] as? Int ?? Int(jsonData["booking_pricing_for_customer"] as? String ?? "") ?? 0))
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



// MARK: - Welcome
struct OrderListModel {
    let data: [OrderListData]
    let message: String
    let success: Bool
    
    init(jsonData:[String:Any]){
        success = jsonData["success"] as? Bool ?? false
        message = jsonData["message"] as? String ?? ""
        data = (jsonData["data"] as? [[String:Any]] ?? [[String:Any]]()).map{ OrderListData(jsonData: $0)}
    }
}

// MARK: - Datum
struct OrderListData {
    let id: String
    let bookingPricing: Int
    let bookingPricingForCustomer: Double
    let bookingID, approchID: String
    let name: String
    let fulladdress: String
    let profilePictureURL: String
    let pricePerHour: Int
    let isActive, isDeleted: Bool
    let updatedBy, createdBy, paymentOrderID, createdAt: String
    let updatedAt: String
    let status: Bool
    let caregiverID, customerID, profileID, startDate: String
    let endDate, startTime, endTime: String

    init(jsonData:[String:Any]){
        id = jsonData["id"] as? String ?? ""
        bookingPricing = jsonData["booking_pricing"] as? Int ?? 0
        bookingPricingForCustomer = jsonData["booking_pricing_for_customer"] as? Double ?? 0
        bookingID = jsonData["booking_id"] as? String ?? ""
        approchID = jsonData["approch_id"] as? String ?? ""
        name = jsonData["name"] as? String ?? ""
        fulladdress = jsonData["fulladdress"] as? String ?? ""
        profilePictureURL = jsonData["profile_picture_url"] as? String ?? ""
        pricePerHour = jsonData["price_per_hour"] as? Int ?? 0
        isActive = jsonData["is_active"] as? Bool ?? true
        isDeleted = jsonData["is_deleted"] as? Bool ?? true
        updatedBy = jsonData["updated_by"] as? String ?? ""
        createdBy = jsonData["created_by"] as? String ?? ""
        paymentOrderID = jsonData["payment_order_id"] as? String ?? ""
        createdAt = jsonData["created_at"] as? String ?? ""
        updatedAt = jsonData["updated_at"] as? String ?? ""
        status = jsonData["status"] as? Bool ?? true
        caregiverID = jsonData["caregiver_id"] as? String ?? ""
        customerID = jsonData["customer_id"] as? String ?? ""
        profileID = jsonData["profile_id"] as? String ?? ""
        startDate = jsonData["start_date"] as? String ?? ""
        endDate = jsonData["end_date"] as? String ?? ""
        startTime = jsonData["start_time"] as? String ?? ""
        endTime = jsonData["end_time"] as? String ?? ""
    }
}
