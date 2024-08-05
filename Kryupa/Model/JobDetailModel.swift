//
//  JobDetailModel.swift
//  Kryupa
//
//  Created by Pooja Nenava on 27/06/24.
//

import Foundation

// MARK: - Welcome
struct JobDetailModel {
    let message: String
    let success: Bool
    let data: JobDetailData
    
    init(jsonData:[String:Any]){
        message = jsonData["message"] as? String ?? ""
        success = jsonData["success"] as? Bool ?? false
        data = JobDetailData(jsonData: jsonData["data"] as? [String:Any] ?? [String:Any]())
    }
}

// MARK: - DataClass
struct JobDetailData {
    let id, bookingType, startDate, endDate: String
    let startTime, endTime, gender, updatedBy: String
    let isActive, isDeleted: Bool
    let createdAt, updatedAt, profileID, customerID: String
    let status, name: String
    let profilePictureURL: String
    let bookingPricing: Int
    let allergies, mobilityLevel, otherDiseaseType, contactID: String
    let caregiversID: String
    let approchStatus: String
    let diseaseType, areasOfExpertise, additionalSkills, additionalInfo: [String]
    let languages: [String]

    init(jsonData:[String:Any]){
        id = jsonData["id"] as? String ?? ""
        bookingType = jsonData["booking_type"] as? String ?? ""
        startDate = jsonData["start_date"] as? String ?? ""
        endDate = jsonData["end_date"] as? String ?? ""
        startTime = jsonData["start_time"] as? String ?? ""
        endTime = jsonData["end_time"] as? String ?? ""
        gender = jsonData["gender"] as? String ?? ""
        updatedBy = jsonData["updated_by"] as? String ?? ""
        isActive = jsonData["is_active"] as? Bool ?? false
        isDeleted = jsonData["is_deleted"] as? Bool ?? false
        createdAt = jsonData["created_at"] as? String ?? ""
        updatedAt = jsonData["updated_at"] as? String ?? ""
        profileID = jsonData["profile_id"] as? String ?? ""
        customerID = jsonData["customer_id"] as? String ?? ""
        status = jsonData["status"] as? String ?? ""
        name = jsonData["name"] as? String ?? ""
        profilePictureURL = jsonData["profile_picture_url"] as? String ?? ""
        bookingPricing = jsonData["booking_pricing"] as? Int ?? 0
        allergies = jsonData["allergies"] as? String ?? ""
        mobilityLevel = jsonData["mobility_level"] as? String ?? ""
        otherDiseaseType = jsonData["other_disease_type"] as? String ?? ""
        contactID = jsonData["contact_id"] as? String ?? ""
        caregiversID = jsonData["caregivers_id"] as? String ?? ""
        approchStatus = jsonData["approch_status"] as? String ?? ""
        diseaseType = jsonData["disease_type"] as? [String] ?? []
        areasOfExpertise = jsonData["areas_of_expertise"] as? [String] ?? []
        additionalSkills = jsonData["additional_skills"] as? [String] ?? []
        additionalInfo = jsonData["additional_info"] as? [String] ?? []
        languages = jsonData["languages"] as? [String] ?? []
    }
}
