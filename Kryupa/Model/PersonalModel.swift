//
//  PersonalModel.swift
//  Kryupa
//
//  Created by Pooja Nenava on 19/06/24.
//

import Foundation

// MARK: - Welcome
struct PersonalModel {
    let success: Bool
    let message: String
    let data: PersonalData
    
    init(jsonData: [String:Any]){
        self.success = jsonData["success"] as? Bool ?? false
        self.message = jsonData["message"] as? String ?? ""
        self.data = PersonalData(jsonData: jsonData["data"] as? [String:Any] ?? [String:Any]())
    }
}

// MARK: - WelcomeData
struct PersonalData {
    let personalinfo: Personalinfo
    let medicalinfo: Medicalinfo
    let emergencyContact: EmergencyContact
    let preferences: PreferencesModel
    
    init(jsonData: [String:Any]){
        self.personalinfo = Personalinfo(jsonData: jsonData["personalinfo"] as? [String:Any] ?? [String:Any]())
        self.medicalinfo = Medicalinfo(jsonData: jsonData["medicalinfo"] as? [String:Any] ?? [String:Any]())
        self.emergencyContact = EmergencyContact(jsonData: jsonData["emergencyContact"] as? [String:Any] ?? [String:Any]())
        self.preferences = PreferencesModel(jsonData: jsonData["preferences"] as? [String:Any] ?? [String:Any]())
    }
    
}

// MARK: - EmergencyContact
struct EmergencyContact {
    let success: Bool
    let message: String
    let data: EmergencyContactData
    
    init(jsonData: [String:Any]){
        self.success = jsonData["success"] as? Bool ?? false
        self.message = jsonData["message"] as? String ?? ""
        self.data = EmergencyContactData(jsonData: jsonData["data"] as? [String:Any] ?? [String:Any]())
    }
}

// MARK: - EmergencyContactData
struct EmergencyContactData {
    let relativeName, relation, relativeEmail, relativeMobileNo: String
    let profileID: String

    init(jsonData: [String:Any]){
        self.relativeName = jsonData["relative_name"] as? String ?? ""
        self.relation = jsonData["relation"] as? String ?? ""
        self.relativeEmail = jsonData["relative_email"] as? String ?? ""
        self.relativeMobileNo = jsonData["relative_mobile_no"] as? String ?? ""
        self.profileID = jsonData["profile_id"] as? String ?? ""
    }
}

// MARK: - Medicalinfo
struct Medicalinfo {
    let success: Bool
    let message: String
    let data: MedicalinfoData
    
    init(jsonData: [String:Any]){
        self.success = jsonData["success"] as? Bool ?? false
        self.message = jsonData["message"] as? String ?? ""
        self.data = MedicalinfoData(jsonData: jsonData["data"] as? [String:Any] ?? [String:Any]())
    }
}

// MARK: - MedicalinfoData
struct MedicalinfoData {
    let allergies, otherDiseaseType, profileID: String
    let diseaseType: [String]
//    let canHelpIn: [String]?

    init(jsonData: [String:Any]){
        self.allergies = jsonData["allergies"] as? String ?? ""
        self.otherDiseaseType = jsonData["other_disease_type"] as? String ?? ""
        self.profileID = jsonData["profile_id"] as? String ?? ""
        self.diseaseType = jsonData["disease_type"] as? [String] ?? []
//        case canHelpIn = "can_help_in"
    }
}

// MARK: - Personalinfo
struct Personalinfo {
    let success: Bool
    let message: String
    let data: PersonalinfoData
    
    init(jsonData: [String:Any]){
        self.success = jsonData["success"] as? Bool ?? false
        self.message = jsonData["message"] as? String ?? ""
        self.data = PersonalinfoData(jsonData: jsonData["data"] as? [String:Any] ?? [String:Any]())
    }
}

// MARK: - PersonalinfoData
struct PersonalinfoData {
    let name: String
    let profilePictureURL: String?
    let language, dob, gender, latitude: String
    let longitude, address, city, state: String
    let country, relation, zipcode, firstname: String
    let lastname, profileID: String

    init(jsonData: [String:Any]){
        self.name = jsonData["name"] as? String ?? ""
        self.profilePictureURL = jsonData["profile_picture_url"] as? String ?? ""
        self.language = jsonData["language"] as? String ?? ""
        self.dob = jsonData["dob"] as? String ?? ""
        self.gender = jsonData["gender"] as? String ?? ""
        self.latitude = jsonData["latitude"] as? String ?? ""
        self.longitude = jsonData["longitude"] as? String ?? ""
        self.address = jsonData["address"] as? String ?? ""
        self.city = jsonData["city"] as? String ?? ""
        self.state = jsonData["state"] as? String ?? ""
        self.country = jsonData["country"] as? String ?? ""
        self.relation = jsonData["relation"] as? String ?? ""
        self.zipcode = jsonData["zipcode"] as? String ?? ""
        self.firstname = jsonData["firstname"] as? String ?? ""
        self.lastname = jsonData["lastname"] as? String ?? ""
        self.profileID = jsonData["profile_id"] as? String ?? ""
    }
}

// MARK: - Preferences
struct PreferencesModel {
    let success: Bool
    let message: String
    let data: PreferencesData
    
    init(jsonData: [String:Any]){
        self.success = jsonData["success"] as? Bool ?? false
        self.message = jsonData["message"] as? String ?? ""
        self.data = PreferencesData(jsonData: jsonData["data"] as? [String:Any] ?? [String:Any]())
    }
}

// MARK: - PreferencesData
struct PreferencesData {
    let yearOfExperience, gender, profileID: String
    let preferredSkillType,preferredInfoType: [String]?
    let preferredServiceType, preferredLangType: [String]

    init(jsonData: [String:Any]){
        yearOfExperience = jsonData["year_of_experience"] as? String ?? ""
        gender = jsonData["gender"] as? String ?? ""
        profileID = jsonData["profile_id"] as? String ?? ""
        preferredSkillType = jsonData["preferred_skill_type"] as? [String] ?? []
        preferredServiceType = jsonData["preferred_service_type"] as? [String] ?? []
        preferredInfoType = jsonData["preferredInfoType"] as? [String] ?? []
        preferredLangType = jsonData["preferred_lang_type"] as? [String] ?? []
    }
}
