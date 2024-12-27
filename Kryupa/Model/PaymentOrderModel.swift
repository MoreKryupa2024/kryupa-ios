//
//  PaymentOrderModel.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 24/07/24.
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

// MARK: - Datum
struct Datum: Codable {
    let amountPerDayCaregiver: Int
    let amountPerDayCustomer: Double
    let amountPerHourCaregiver, amountPerHourCustomer: String

    enum CodingKeys: String, CodingKey {
        case amountPerDayCaregiver = "amount_per_day_caregiver"
        case amountPerDayCustomer = "amount_per_day_customer"
        case amountPerHourCaregiver = "amount_per_hour_caregiver"
        case amountPerHourCustomer = "amount_per_hour_customer"
    }
}

// MARK: - DataClass
struct PaymentOrderData {
    let name: String
    let profilePictureURL: String
    let bookingPricingForCustomer: Double
    let approchID, fulladdress, bookingID: String
    let pricePerHour: Double
    let startDate, startTime, endTime: String
    let hours: Double
    let areasOfExpertise: String

    init(jsonData:[String:Any]){
        name = jsonData["name"] as? String ?? ""
        profilePictureURL = jsonData["profile_picture_url"] as? String ?? ""
        bookingPricingForCustomer = (jsonData["amount_per_day_customer"] as? Double ?? Double(jsonData["amount_per_day_customer"] as? Int ?? Int(jsonData["booking_pricing_for_customer"] as? String ?? "") ?? 0))
        approchID = jsonData["approch_id"] as? String ?? ""
        fulladdress = jsonData["address"] as? String ?? ""
        bookingID = jsonData["booking_id"] as? String ?? ""
        pricePerHour = Double(jsonData["amount_per_hour_customer"] as? String ?? "") ?? 0.0
        startDate = jsonData["serviceDate"] as? String ?? ""
        startTime = jsonData["service_start_time"] as? String ?? ""
        endTime = jsonData["service_end_time"] as? String ?? ""
        hours = Double(jsonData["number_of_hours"] as? String ?? "") ?? 0
        areasOfExpertise = jsonData["area_of_experties"] as? String ?? ""
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
        let createdAt, updatedAt, stripACNo, stripeBankNo: String

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
        createdAt = jsonData["created_at"] as? String ?? ""
        updatedAt = jsonData["updated_at"] as? String ?? ""
        stripACNo = jsonData["strip_ac_no"] as? String ?? ""
        stripeBankNo = jsonData["stripe_bank_no"] as? String ?? ""
    }
}

/* {"id":"91d70d97-ac60-4334-a1db-c20c4260d2d0","user_id":"a923a440-a841-4f4c-9c54-fd7610165f2a","user_type":"caregiver","routing_number":"110000000","account_number":"000999999991","bank_name":"hh","is_primary":true,"is_active":true,"is_deleted":false,"updated_by":null,"created_at":"2024-12-18 06:24:03.648904+00","updated_at":"2024-12-18 06:24:03.648904+00","strip_ac_no":"acct_1QXGfsGdx3etm3oR","stripe_bank_no":"ba_1QXGfuGdx3etm3oRyBrmiUy2"}*/


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
    let bookingPricing: Double
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
        bookingPricing = jsonData["booking_pricing"] as? Double ?? Double(jsonData["booking_pricing"] as? Int ?? Int(jsonData["booking_pricing"] as? String ?? "") ?? 0)
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
