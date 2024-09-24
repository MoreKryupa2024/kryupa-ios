//
//  JobsModel.swift
//  Kryupa
//
//  Created by Pooja Nenava on 12/06/24.
//

import Foundation

struct JobsModel {
    let data: JobsData
    let message: String
    let success: Bool
    
    init(jsonData:[String:Any]){
        data = JobsData(jsonData: jsonData["data"] as? [String:Any] ?? [String:Any]())
        message = jsonData["message"] as? String ?? ""
        success = jsonData["success"] as? Bool ?? false
    }
}

// MARK: - DataClass
struct JobsData {
    let jobPost: [JobPost]
    let isexist: Isexist

    init(jsonData:[String:Any]){
        jobPost = (jsonData["job_post"] as? [[String:Any]] ?? [[String:Any]]()).map{JobPost(jsonData: $0)}
        isexist = Isexist(jsonData: jsonData["isexist"] as? [String:Any] ?? [String:Any]())
    }
}


// MARK: - Isexist
struct Isexist {
    let inExpertise, inRequirements, inPreferences: Bool

    init(jsonData:[String:Any]){
        inExpertise = jsonData["in_expertise"] as? Bool ?? false
        inRequirements = jsonData["in_requirements"] as? Bool ?? false
        inPreferences = jsonData["in_preferences"] as? Bool ?? false
    }
}

// MARK: - JobPost
struct JobPost {
    let customerInfo: CustomerInfo
    let bookingDetails: BookingDetails
    let jobID: String

    init(jsonData:[String:Any]){
        customerInfo = CustomerInfo(jsonData: jsonData["customerInfo"] as? [String:Any] ?? [String:Any]())
        bookingDetails = BookingDetails(jsonData: jsonData["bookingDetails"] as? [String:Any] ?? [String:Any]())
        jobID = jsonData["job_id"] as? String ?? ""
    }
}

// MARK: - BookingDetails
struct BookingDetails {
    let areaOfExpertise: [String]
    let bookingType, startDate, endDate, startTime: String
    let endTime: String

    init(jsonData:[String:Any]){
        areaOfExpertise = jsonData["area_of_expertise"] as? [String] ?? []
        bookingType = jsonData["booking_type"] as? String ?? ""
        startDate = jsonData["start_date"] as? String ?? ""
        endDate = jsonData["end_date"] as? String ?? ""
        startTime = jsonData["start_time"] as? String ?? ""
        endTime = jsonData["end_time"] as? String ?? ""
    }
}

// MARK: - CustomerInfo
struct CustomerInfo {
    let name, gender, profilePictureUrl: String
    let price: Int
    let diseaseType: [String]

    init(jsonData:[String:Any]){
        name = jsonData["name"] as? String ?? ""
        gender = jsonData["gender"] as? String ?? ""
        profilePictureUrl = jsonData["profile_picture_url"] as? String ?? ""
        price = jsonData["price"] as? Int ?? 0
        diseaseType = jsonData["disease_type"] as? [String] ?? []
    }
}
