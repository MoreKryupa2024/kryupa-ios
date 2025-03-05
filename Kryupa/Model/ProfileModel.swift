//
//  ProfileModel.swift
//  Kryupa
//
//  Created by Pooja Nenava on 18/06/24.
//

import Foundation

// MARK: - Welcome
struct ProfileModel {
    let success: Bool
    let message: String
    let data: ProfileData
    
    init(jsonData:[String:Any]){
        self.success = jsonData["success"] as? Bool ?? false
        self.message = jsonData["message"] as? String ?? ""
        self.data = ProfileData(jsonData: jsonData["data"] as? [String:Any] ?? [String:Any]())
    }
}

// MARK: - DataClass
struct ProfileData: Codable {
    let customerName: String
    let profilePic: String?
    let relation: String

    init(jsonData:[String:Any]){
        customerName = jsonData["customer_name"] as? String ?? ""
        profilePic = jsonData["profile_pic"] as? String ?? ""
        relation = jsonData["relation"] as? String ?? ""
    }
}
