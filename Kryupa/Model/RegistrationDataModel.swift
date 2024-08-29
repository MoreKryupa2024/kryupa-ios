//
//  RegistrationDataModel.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 23/05/24.
//

import Foundation


// MARK: - ExprienceAndSkills
struct ExprienceAndSkills {
    var bio, yearsOfExprience: String?
    var areaOfExpertise: [String]?
    var certificateAndDocuments: [String]?
}

// MARK: - PersonalInfo
struct PersonalInfo {
    var name: String? = Defaults().fullName
    var language, dob, gender, ssn: String?
    var latitude: Double? = 22.00
    var longitude: Double? = 22.00
    var address: String? = "123, Test Addresss, Street"
    var city: String? = "Indore"
    var state: String? = "MP"
    var postalCode: String? = "12345"
    var country: String? = "India"
}

// MARK: - PreferenceList
struct PreferenceList {
    var weight, mobilityLevel, language, distance: String?
}


// MARK: - Preferences
struct Preferences {
    let yearOfExperience, gender, startDate, endDate: String?
    let startTime, endTime: String?
    let preferredServiceType, preferredLanguageType: [String]?
}

// MARK: - MedicalInfo
struct MedicalInfo {
    let allergies, mobilityLevel: String?
    let diseaseType: [String]?
}


// MARK: - Empty
struct SendOTPModel {
    let success: Bool
    let message: String
    let data: SendOTPData
    
    init(jsonData: [String:Any]){
        success = jsonData["success"] as? Bool ?? false
        message = jsonData["message"] as? String ?? ""
        data = SendOTPData(jsonData: jsonData["data"] as? [String:Any] ?? [String:Any]())
    }
}


// MARK: - Send OTP Data
struct SendOTPData {
    let requestID, type: String

    init(jsonData: [String:Any]){
        requestID = jsonData["request_id"] as? String ?? ""
        type = jsonData["type"] as? String ?? ""
    }
}
