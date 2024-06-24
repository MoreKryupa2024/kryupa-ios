//
//  PersonalModel.swift
//  Kryupa
//
//  Created by Pooja Nenava on 19/06/24.
//

import Foundation

// MARK: - Welcome
struct PersonalModel: Codable {
    let success: Bool
    let message: String?
    var data: PersonalData
}

// MARK: - DataClass
struct PersonalData: Codable {
    var customersid, email, profileid, profileName: String?
    var language, dob, gender, address: String?
    var city, state, country, relation: String?
    var medicalinfo: Medicalinfo?
    var preferences: PreferencesData?
    var emergencycontact: Emergencycontact?

    enum CodingKeys: String, CodingKey {
        case customersid, email, profileid
        case profileName = "profile_name"
        case language, dob, gender, address, city, state, country, relation, medicalinfo, preferences, emergencycontact
    }
}

// MARK: - Emergencycontact
struct Emergencycontact: Codable {
    var emergencyContactID, relativeName, relation, relativeEmail: String?
    var relativeMobileNo: String?

    enum CodingKeys: String, CodingKey {
        case emergencyContactID = "emergencyContactId"
        case relativeName, relation, relativeEmail, relativeMobileNo
    }
}

// MARK: - Medicalinfo
struct Medicalinfo: Codable {
    var diseaseTypes: [String]?
    var medicalID, allergies, otherDisease, mobility: String?

    enum CodingKeys: String, CodingKey {
        case diseaseTypes
        case medicalID = "medicalId"
        case allergies
        case otherDisease = "other_disease"
        case mobility
    }
}

// MARK: - Preferences
struct PreferencesData: Codable {
    var preferenceID: String?
    var preferredLanguages, preferredServices: [String]?

    enum CodingKeys: String, CodingKey {
        case preferenceID = "preferenceId"
        case preferredLanguages, preferredServices
    }
}
