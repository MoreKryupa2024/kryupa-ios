//
//  JobDetailModel.swift
//  Kryupa
//
//  Created by Pooja Nenava on 27/06/24.
//

import Foundation

// MARK: - Welcome
struct JobDetailModel: Codable {
    let message: String
    let success: Bool
    let data: JobDetailData
}

// MARK: - DataClass
struct JobDetailData: Codable {
    let id, bookingType, startDate, endDate: String
    let startTime, endTime, gender, updatedBy: String
    let isActive, isDeleted: Bool
    let createdAt, updatedAt, profileID, customerID: String
    let status, name, profilePictureUrl: String
    let bookingPricing: Int
    let allergies, mobilityLevel, otherDiseaseType: String
    let diseaseType, areasOfExpertise, additionalSkills, additionalInfo: [String]?
    let languages: [String]

    enum CodingKeys: String, CodingKey {
        case id
        case bookingType = "booking_type"
        case startDate = "start_date"
        case endDate = "end_date"
        case startTime = "start_time"
        case endTime = "end_time"
        case gender
        case updatedBy = "updated_by"
        case isActive = "is_active"
        case isDeleted = "is_deleted"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case profileID = "profile_id"
        case customerID = "customer_id"
        case status, name
        case profilePictureUrl = "profile_picture_url"
        case bookingPricing = "booking_pricing"
        case allergies
        case mobilityLevel = "mobility_level"
        case otherDiseaseType = "other_disease_type"
        case diseaseType = "disease_type"
        case areasOfExpertise = "areas_of_expertise"
        case additionalSkills = "additional_skills"
        case additionalInfo = "additional_info"
        case languages
    }
}
