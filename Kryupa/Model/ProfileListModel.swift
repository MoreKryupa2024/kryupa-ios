//
//  ProfileListModel.swift
//  Kryupa
//
//  Created by Pooja Nenava on 18/06/24.
//

import Foundation

// MARK: - Welcome
struct ProfileListModel {
    let success: Bool
    let message: String?
    let data: [Profile]
    
    init(jsonData:[String:Any]){
        success = jsonData["success"] as? Bool ?? false
        message = jsonData["message"] as? String ?? ""
        data = (jsonData["data"] as? [[String:Any]] ?? []).map{Profile(jsonData: $0)}
    }
}

struct Profile {
    let id: String
    let name: String
    
    init(jsonData:[String:Any]){
        id = jsonData["id"] as? String ?? ""
        name = jsonData["name"] as? String ?? ""
    }
}

// MARK: - Welcome
struct MyServiceModel {
    let success: Bool
    let data: MyServiceData
    let message: String
    
    init(jsonData:[String:Any]){
        message = jsonData["message"] as? String ?? ""
        success = jsonData["success"] as? Bool ?? false
        data = MyServiceData(jsonData: jsonData["data"] as? [String:Any] ?? [String:Any]())
    }
}

// MARK: - DataClass
struct MyServiceData {
    let skilles: [String]
    let areaOfExperties: [String]
    let additionalrequirement: [String]
    let preferences: MyPreferencesData
    
    init(jsonData:[String:Any]){
        skilles = jsonData["skilles"] as? [String] ?? []
        areaOfExperties = jsonData["area_of_experties"] as? [String] ?? []
        additionalrequirement = jsonData["additionalrequirement"] as? [String] ?? []
        preferences = MyPreferencesData(jsonData: jsonData["preferences"] as? [String:Any] ?? [String:Any]())
    }
}



struct DistanceModel: Codable {
    let success: Bool
    let data: [DistanceData]
    let message: String
    
    init(jsonData:[String:Any]){
        message = jsonData["message"] as? String ?? ""
        success = jsonData["success"] as? Bool ?? false
        data = (jsonData["data"] as? [[String:Any]] ?? []).map{DistanceData(jsonData: $0)}
    }
    
}


struct DistanceData: Codable {
    let id, adminID, distanceInMiles: String
    let isActive: Bool
    let createdAt, updatedAt: String

    init(jsonData:[String:Any]){
        self.id = jsonData["id"] as? String ?? ""
        self.adminID = jsonData["admin_id"] as? String ?? ""
        self.distanceInMiles = jsonData["distance_in_miles"] as? String ?? ""
        self.isActive = jsonData["is_active"] as? Bool ?? false
        self.createdAt = jsonData["created_at"] as? String ?? ""
        self.updatedAt = jsonData["updated_at"] as? String ?? ""
    }
}


struct MyPreferencesData {
    let mobilityLevel: String
    let distance: String
    let language: [String]
    
    init(jsonData:[String:Any]){
        mobilityLevel = jsonData["mobility_level"] as? String ?? ""
        distance = jsonData["distance"] as? String ?? ""
        language = jsonData["language"] as? [String] ?? ["English"]
    }
}
