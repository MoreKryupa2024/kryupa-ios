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
        data =  (jsondata["data"] as? [[String:Any]] ?? [[String:Any]]()).map{BookingsListData(jsondata: $0)}
    }
}

// MARK: - Datum
struct BookingsListData {
    let id, customerID, startDate, endDate: String
    let startTime, endTime, bookingID, status: String
    let name: String
    let profilePictureURL: String
    let price: Int
    let arrayAgg: [String]
    
    init(jsondata:[String:Any]) {
        id = jsondata["id"] as? String ?? ""
        customerID = jsondata["customer_id"] as? String ?? ""
        startDate = jsondata["start_date"] as? String ?? ""
        endDate = jsondata["end_date"] as? String ?? ""
        startTime = jsondata["start_time"] as? String ?? ""
        endTime = jsondata["end_time"] as? String ?? ""
        bookingID = jsondata["booking_id"] as? String ?? ""
        status = jsondata["status"] as? String ?? ""
        name = jsondata["name"] as? String ?? ""
        profilePictureURL = jsondata["profile_picture_url"] as? String ?? ""
        price = jsondata["price"] as? Int ?? 0
        arrayAgg = jsondata["array_agg"] as? [String] ?? []
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
