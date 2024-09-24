//
//  PersonalGiverModel.swift
//  Kryupa
//
//  Created by Pooja Nenava on 25/06/24.
//

import Foundation

// MARK: - Welcome
struct PersonalGiverModel {
    let success: Bool
    let message: String?
    let data: PersonalGiverData
    
    init(jsonData:[String:Any]){
        success = jsonData["success"] as? Bool ?? false
        message = jsonData["message"] as? String ?? ""
        data = PersonalGiverData(jsonData: jsonData["data"] as? [String:Any] ?? [String:Any]())
    }
}

// MARK: - DataClass
struct PersonalGiverData {
    let id, caregiverID, profileID, name, email, dob, language, distance: String
    let gender, ssnVerificationStatus, interviewStatus, bgvStatus, profilePictureUrl: String?
    var expertise: Expertise
    let additionalRequirements, preferredLanguages, canHelpIn: [String]

    init(jsonData:[String:Any]){
        id = jsonData["id"] as? String ?? ""
        email = jsonData["email"] as? String ?? ""
        language = jsonData["language"] as? String ?? ""
        distance = jsonData["distance"] as? String ?? ""
        dob = jsonData["dob"] as? String ?? ""
        caregiverID = jsonData["caregiver_id"] as? String ?? ""
        profileID = jsonData["profile_id"] as? String ?? ""
        name = jsonData["name"] as? String ?? ""
        gender = jsonData["gender"] as? String ?? ""
        profilePictureUrl = jsonData["profile_picture_url"] as? String ?? ""
        ssnVerificationStatus = jsonData["ssn_verification_status"] as? String ?? ""
        interviewStatus = jsonData["interview_status"] as? String ?? ""
        bgvStatus = jsonData["bgv_status"] as? String ?? ""
        expertise = Expertise(jsonData: jsonData["expertise"] as? [String:Any] ?? [String:Any]())
        additionalRequirements = jsonData["additional_requirements"]  as? [String] ?? []
        preferredLanguages = jsonData["preferred_languages"] as? [String] ?? []
        canHelpIn = jsonData["can_help_in"] as? [String] ?? []
    }
}

// MARK: - Expertise
struct Expertise {
    var bio: String
    var exprience: Int
    
    init(jsonData:[String:Any]){
        bio = jsonData["bio"] as? String ?? ""
        exprience = jsonData["exprience"] as? Int ?? 0
    }
}
