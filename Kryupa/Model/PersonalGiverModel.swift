//
//  PersonalGiverModel.swift
//  Kryupa
//
//  Created by Pooja Nenava on 25/06/24.
//

import Foundation

// MARK: - Welcome
struct PersonalGiverModel: Codable {
    let success: Bool
    let message: String?
    let data: PersonalGiverData
}

// MARK: - DataClass
struct PersonalGiverData: Codable {
    let id, caregiverID, profileID, name: String
    let gender, ssnVerificationStatus, interviewStatus, bgvStatus, profilePictureUrl: String?
    var expertise: Expertise
    let additionalRequirements, preferredLanguages: [String]

    enum CodingKeys: String, CodingKey {
        case id
        case caregiverID = "caregiver_id"
        case profileID = "profile_id"
        case name, gender
        case profilePictureUrl = "profile_picture_url"
        case ssnVerificationStatus = "ssn_verification_status"
        case interviewStatus = "interview_status"
        case bgvStatus = "bgv_status"
        case expertise
        case additionalRequirements = "additional_requirements"
        case preferredLanguages = "preferred_languages"
    }
}

// MARK: - Expertise
struct Expertise: Codable {
    var bio: String
    var exprience: Int
}
