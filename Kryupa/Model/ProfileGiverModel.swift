//
//  ProfileGiverModel.swift
//  Kryupa
//
//  Created by Pooja Nenava on 25/06/24.
//

import Foundation

// MARK: - Welcome
struct ProfileGiverModel {
    let success: Bool
    let message: String
    let data: ProfileGiverDataClass
    
    init(jsonData:[String:Any]){
        self.success = jsonData["success"] as? Bool ?? false
        self.message = jsonData["message"] as? String ?? ""
        self.data = ProfileGiverDataClass(jsonData: jsonData["data"] as? [String:Any] ?? [String:Any]())
    }
}

// MARK: - DataClass
struct ProfileGiverDataClass {
    let name: String
    let profileURL: String

    init(jsonData:[String:Any]){
        name = jsonData["name"] as? String ?? ""
        profileURL = jsonData["profile_url"] as? String ?? ""
    }
}
