//
//  ProfileListModel.swift
//  Kryupa
//
//  Created by Pooja Nenava on 18/06/24.
//

import Foundation

// MARK: - Welcome
struct ProfileListModel: Codable {
    let success: Bool
    let message: String?
    let data: ProfileListData
}

// MARK: - DataClass
struct ProfileListData: Codable {
    let profiles: [String]
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
    
    init(jsonData:[String:Any]){
        skilles = jsonData["skilles"] as? [String] ?? []
        areaOfExperties = jsonData["areaOfExperties"] as? [String] ?? []
    }
}
