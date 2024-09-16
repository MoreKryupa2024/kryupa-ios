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
    var name: String?
    var lastName: String?
    var zipError: String?
    var language, dob, gender, ssn: String?
    var latitude: Double? = 22.00
    var longitude: Double? = 22.00
    var address: String?
    var city: String?
    var state: String?
    var postalCode: String?
    var country: String?
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


// MARK: - Welcome
struct ZipCpdeModel  {
    let data: ZipCpdeData
    
    init(jsonData: [String:Any]){
        data = ZipCpdeData(jsonData: jsonData["data"] as? [String:Any] ?? [String:Any]())
    }
}

// MARK: - DataClass
struct ZipCpdeData {
    let postCode, country, countryAbbreviation: String
    let places: [Place]

    init(jsonData: [String:Any]){
        postCode = jsonData["post code"] as? String ?? ""
        country = jsonData["country"] as? String ?? ""
        countryAbbreviation = jsonData["country abbreviation"] as? String ?? ""
        places = (jsonData["places"] as? [[String:Any]] ?? [[String:Any]]()).map{Place(jsonData: $0) }
    }
}

// MARK: - Place
struct Place {
    let placeName, longitude, state, stateAbbreviation: String
    let latitude: String

    init(jsonData: [String:Any]){
        placeName = jsonData["place name"] as? String ?? ""
        longitude = jsonData["longitude"] as? String ?? ""
        state = jsonData["state"] as? String ?? ""
        stateAbbreviation = jsonData["state abbreviation"] as? String ?? ""
        latitude = jsonData["latitude"] as? String ?? ""
    }
}
