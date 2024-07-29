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



// MARK: - Welcome
struct PaypalOrderModel {
    let success: Bool
    let message: String
    let data: PaypalOrderData
    
    
    init(jsonData:[String:Any]){
        success = jsonData["success"] as? Bool ?? false
        message = jsonData["message"] as? String ?? ""
        data = PaypalOrderData(jsonData: jsonData["data"] as? [String:Any] ?? [String:Any]())
    }
}

// MARK: - DataClass
struct PaypalOrderData {
    let orderID: String
//    let links: [Link]

    init(jsonData:[String:Any]){
        orderID = jsonData["order_id"] as? String ?? ""
//        links = jsonData["links"]
    }
}


// MARK: - Welcome
struct WalletAmountModel: Codable {
    let success: Bool
    let message: String
    let data: WalletAmountData
    
    init(jsonData:[String:Any]){
        success = jsonData["success"] as? Bool ?? false
        message = jsonData["message"] as? String ?? ""
        data = WalletAmountData(jsonData: jsonData["data"] as? [String:Any] ?? [String:Any]())
    }
}

// MARK: - DataClass
struct WalletAmountData: Codable {
    let id: String
    let mainAmount: Int
    let userID, userType: String
    let partialAmount: Int
    let isActive, isDeleted: Bool

    init(jsonData:[String:Any]){
        id = jsonData["id"] as? String ?? ""
        mainAmount = jsonData["main_amount"] as? Int ?? 0
        userID = jsonData["user_id"] as? String ?? ""
        userType = jsonData["user_type"] as? String ?? ""
        partialAmount = jsonData["partial_amount"] as? Int ?? 0
        isActive = jsonData["is_active"] as? Bool ?? false
        isDeleted = jsonData["is_deleted"] as? Bool ?? false
    }
}



// MARK: - Welcome
struct TransectionListModel {
    let success: Bool
    let message: String
    let data: [TransectionListData]
    
    init(jsonData:[String:Any]){
        success = jsonData["success"] as? Bool ?? false
        message = jsonData["message"] as? String ?? ""
        data = (jsonData["data"] as? [[String:Any]] ?? [[String:Any]]()).map{ TransectionListData(jsonData: $0)}
    }
}

// MARK: - Datum
struct TransectionListData: Codable {
    let id: String
    let tnxamount: Int
    let walletid, tnxnumber, tnxstatus, tnxtype: String
    let paymentmode, createdAt: String

    init(jsonData:[String:Any]){
        id = jsonData["id"] as? String ?? ""
        tnxamount = jsonData["tnxamount"] as? Int ?? 0
        walletid = jsonData["walletid"] as? String ?? ""
        tnxnumber = jsonData["tnxnumber"] as? String ?? ""
        tnxstatus = jsonData["tnxstatus"] as? String ?? ""
        tnxtype = jsonData["tnxtype"] as? String ?? ""
        paymentmode = jsonData["paymentmode"] as? String ?? ""
        createdAt = jsonData["created_at"] as? String ?? ""
    }
}
