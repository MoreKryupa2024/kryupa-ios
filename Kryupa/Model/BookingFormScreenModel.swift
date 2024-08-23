//
//  BookingFormScreenModel.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 31/05/24.
//

import Foundation


// MARK: - Empty
struct RelativeModel: Codable {
    let success: Bool
    let message: String
    let data: [RelativeDataModel]
}

// MARK: - Datum
struct RelativeDataModel: Codable {
    let id, name: String
}

// MARK: - Empty
struct BookingsListModel {
    let success: Bool
    let message: String
    let data: [BookingsListData]
    
    init(jsondata:[String:Any]) {
        message = jsondata["message"] as? String ?? ""
        success = jsondata["success"] as? Bool ?? false
        data =  (jsondata["data"] as? [[String:Any]] ?? [[String:Any]]()).map{BookingsListData(jsonData: $0)}
    }
}

// MARK: - Datum
struct BookingsListData {
    let id, caregiverID, startDate, endDate,customerID: String
    let startTime, endTime, bookingID, status: String
    let name: String
    let profilePictureURL: String
    let relation: String
    let price: Double
    let arrayAgg: [String]
    
    init(jsonData:[String:Any]) {
        id = jsonData["id"] as? String ?? ""
        caregiverID = jsonData["caregiver_id"] as? String ?? ""
        customerID = jsonData["customer_id"] as? String ?? ""
        startDate = jsonData["start_date"] as? String ?? ""
        endDate = jsonData["end_date"] as? String ?? ""
        startTime = jsonData["start_time"] as? String ?? ""
        endTime = jsonData["end_time"] as? String ?? ""
        bookingID = jsonData["booking_id"] as? String ?? ""
        status = jsonData["status"] as? String ?? ""
        name = jsonData["name"] as? String ?? ""
        profilePictureURL = jsonData["profile_picture_url"] as? String ?? ""
        relation = jsonData["relation"] as? String ?? ""
        price = jsonData["price"] as? Double ?? 0.0
        arrayAgg = jsonData["array_agg"] as? [String] ?? []
    }
}


// MARK: - Empty
struct BookingIDModel {
    let success: Bool
    let message: String
    let data: BookingIDData
    
    init(jsondata:[String:Any]) {
        message = jsondata["message"] as? String ?? ""
        success = jsondata["success"] as? Bool ?? false
        data = BookingIDData(jsondata: jsondata["data"] as? [String:Any] ?? [String:Any]())
    }
}

// MARK: - Datum
struct BookingIDData {
    let id, bookingType, startDate, endDate: String
    let startTime, endTime, gender, updatedBy: String
    let isActive, isDeleted: Bool
    let createdAt, updatedAt, profileID, customerID: String
    let status, yearsOfExprience: String
    let areasOfExpertise, additionalSkills, languages: [String]
    
    init(jsondata:[String:Any]) {
        id = jsondata["id"] as? String ?? ""
        bookingType = jsondata["booking_type"] as? String ?? ""
        startDate = jsondata["start_date"] as? String ?? ""
        endDate = jsondata["end_date"] as? String ?? ""
        startTime = jsondata["start_time"] as? String ?? ""
        endTime = jsondata["end_time"] as? String ?? ""
        gender = jsondata["gender"] as? String ?? ""
        updatedBy = jsondata["updated_by"] as? String ?? ""
        isActive = jsondata["is_active"] as? Bool ?? false
        isDeleted = jsondata["is_deleted"] as? Bool ?? false
        createdAt = jsondata["created_at"] as? String ?? ""
        updatedAt = jsondata["updated_at"] as? String ?? ""
        profileID = jsondata["profile_id"] as? String ?? ""
        customerID = jsondata["customer_id"] as? String ?? ""
        status = jsondata["status"] as? String ?? ""
        yearsOfExprience = jsondata["years_of_exprience"] as? String ?? ""
        areasOfExpertise = jsondata["areas_of_expertise"] as? [String] ?? []
        additionalSkills = jsondata["additional_skills"] as? [String] ?? []
        languages = jsondata["languages"] as? [String] ?? []
    }
}


struct RecommendedBookingModel {
    let data: RecommendedBookingData
    let success: Bool
    let message: String
    
    init(jsonData:[String:Any]){
        message = jsonData["message"] as? String ?? ""
        success = jsonData["success"] as? Bool ?? false
        data = RecommendedBookingData(jsonData: jsonData["data"] as? [String:Any] ?? [String:Any]())
    }
}

// MARK: - DataClass
struct RecommendedBookingData {
    let customerID: String
    let preference: RecommendedUserBookingData

    init(jsonData:[String:Any]){
        customerID = jsonData["customer_id"] as? String ?? ""
        preference = RecommendedUserBookingData(jsonData: jsonData["preference"] as? [String:Any] ?? [String:Any]())
    }
}

// MARK: - Preference
struct RecommendedUserBookingData {
    let yearOfExperience, gender: String
    let preferredLang, preferredServiceType: [String]

    init(jsonData:[String:Any]){
        yearOfExperience = jsonData["year_of_experience"] as? String ?? ""
        gender = jsonData["gender"] as? String ?? ""
        preferredLang = (jsonData["preferred_lang"] as? [String] ?? []).sorted(by: { $0 < $1 })
        preferredServiceType = (jsonData["preferred_service_type"] as? [String] ?? []).sorted(by: { $0 < $1 })
    }
}



// MARK: - Welcome
struct CancelSeriveDetailModel {
    let success: Bool
    let message: String
    let data: CancelSeriveDetailData
    
    init(jsonData:[String:Any]){
        message = jsonData["message"] as? String ?? ""
        success = jsonData["success"] as? Bool ?? false
        data = CancelSeriveDetailData(jsonData: jsonData["data"] as? [String:Any] ?? [String:Any]())
    }
}

// MARK: - DataClass
struct CancelSeriveDetailData {
    let id, status, bookingID: String
    let isActive, isDeleted: Bool
    let updatedBy, createdAt, updatedAt, caregiverID: String
    let customerID: String
    let bookingPricing, bookingPricingForCustomer, hours: Double
    let payChatID, startDate, endDate, startTime: String
    let endTime,bookingType: String
    let areasOfExpertise: [String]
    let name, address, yearsOfExprienceInNo: String
    let pricePerHour: Double
    let rating: String
    

    init(jsonData:[String:Any]){
        id = jsonData["id"] as? String ?? ""
        status = jsonData["status"] as? String ?? ""
        bookingType = jsonData["booking_type"] as? String ?? ""
        bookingID = jsonData["booking_id"] as? String ?? ""
        isActive = jsonData["is_active"] as? Bool ?? false
        isDeleted = jsonData["is_deleted"] as? Bool ?? false
        updatedBy = jsonData["updated_by"] as? String ?? ""
        createdAt = jsonData["created_at"] as? String ?? ""
        updatedAt = jsonData["updated_at"] as? String ?? ""
        caregiverID = jsonData["caregiver_id"] as? String ?? ""
        customerID = jsonData["customer_id"] as? String ?? ""
        bookingPricing = jsonData["booking_pricing"] as? Double ?? Double(jsonData["booking_pricing"] as? Int ?? Int(jsonData["booking_pricing"] as? String ?? "") ?? 0)
        bookingPricingForCustomer = (jsonData["booking_pricing_for_customer"] as? Double ?? Double(jsonData["booking_pricing_for_customer"] as? Int ?? Int(jsonData["booking_pricing_for_customer"] as? String ?? "") ?? 0))
        payChatID = jsonData["pay_chat_id"] as? String ?? ""
        startDate = jsonData["start_date"] as? String ?? ""
        endDate = jsonData["end_date"] as? String ?? ""
        startTime = jsonData["start_time"] as? String ?? ""
        endTime = jsonData["end_time"] as? String ?? ""
        areasOfExpertise = jsonData["areas_of_expertise"] as? [String] ?? []
        hours = jsonData["hours"] as? Double ?? Double(jsonData["hours"] as? Int ?? Int(jsonData["hours"] as? String ?? "") ?? 0)
        
        name = jsonData["name"] as? String ?? ""
        address = jsonData["address"] as? String ?? ""
        rating = jsonData["rating"] as? String ?? ""
        pricePerHour = jsonData["price_per_hour"] as? Double ?? Double(jsonData["price_per_hour"] as? Int ?? Int(jsonData["price_per_hour"] as? String ?? "") ?? 0)
        
        yearsOfExprienceInNo = jsonData["years_of_exprience_in_no"] as? String ?? ""
    }
}
