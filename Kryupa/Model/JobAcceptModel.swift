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

// MARK: - Welcome
struct ServiceStartModel {
    let success: Bool
    let message: String
    let data: [ServiceStartData]
    let dataTwo: ServiceStartData
    
    init(jsonData:[String:Any]){
        success = jsonData["success"] as? Bool ?? false
        message = jsonData["message"] as? String ?? ""
        data = (jsonData["data"] as? [[String : Any]] ?? [[String : Any]]()).map{ServiceStartData(jsonData: $0)}
        dataTwo = ServiceStartData(jsonData: jsonData["data"] as? [String : Any] ?? [String : Any]())
    }
}

// MARK: - DataClass
struct ServiceStartData {
    let id, serviceStatus,name: String

    init(jsonData:[String:Any]){
        id = jsonData["id"] as? String ?? ""
        serviceStatus = jsonData["service_status"] as? String ?? ""
        name = jsonData["name"] as? String ?? ""
    }
}


// MARK: - Welcome
struct BannerModel {
    let success: Bool
    let data: [BannerDataModel]
    let message: String
    
    init(jsonData:[String:Any]){
        success = jsonData["success"] as? Bool ?? false
        message = jsonData["message"] as? String ?? ""
        data = (jsonData["data"] as? [[String : Any]] ?? [[String : Any]]()).map{BannerDataModel(jsonData: $0)}
    }
}

// MARK: - Datum
struct BannerDataModel {
    let id: String
    let bannerURL: String
    let title, userType, screenName, createdAt: String
    let updatedAt: String

    init(jsonData:[String:Any]){
        id = jsonData["id"] as? String ?? ""
        bannerURL = jsonData["banner_url"] as? String ?? ""
        title = jsonData["title"] as? String ?? ""
        userType = jsonData["user_type"] as? String ?? ""
        screenName = jsonData["screen_name"] as? String ?? ""
        createdAt = jsonData["created_at"] as? String ?? ""
        updatedAt = jsonData["updated_at"] as? String ?? ""
    }
}
