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
    var name, language, dob, gender, ssn: String?
    var latitude: Double? = 22.00
    var longitude: Double? = 22.00
    var address: String? = "123, Test Addresss, Street"
    var city: String? = "Indore"
    var state: String? = "MP"
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
