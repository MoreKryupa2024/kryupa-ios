//
//  GoogleSignupModel.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 15/05/24.
//

import Foundation


// MARK: - Empty
struct Empty{
    let success: Bool
    let message: String
    let data: DataClass
    
    init(jsonData:[String:Any]){
        self.success = jsonData["success"] as? Bool ?? false
        self.message = jsonData["message"] as? String ?? ""
        self.data = DataClass(jsonData: jsonData["data"] as? [String:Any] ?? [String:Any]())
        
    }
}

// MARK: - Empty
struct EmptyRegister: Codable {
    let success: Bool
    let message: String
}

// MARK: - Empty
struct EmptyCareGiverRegister: Codable {
    let satus: Bool
    let message: String
}

// MARK: - DataClass
struct DataClass {
    let accessToken, refrenceToken: String
    let userInfo: UserInfo
    let userTypes, verificationStatus: String
    let is_active: Bool

    init(jsonData:[String:Any]){
        accessToken = jsonData["accessToken"] as? String ?? ""
        refrenceToken = jsonData["refrenceToken"] as? String ?? ""
        userInfo = UserInfo(jsonData: jsonData["userInfo"] as? [String:Any] ?? [String:Any]())
        userTypes = jsonData["UserTypes"] as? String ?? ""
        verificationStatus = jsonData["verificationStatus"] as? String ?? ""
        is_active = jsonData["is_active"] as? Bool ?? false
    }
}

// MARK: - UserInfo
struct UserInfo {
    let id, email, name: String
    let verifiedEmail: Bool
    let fcmToken, role: String

    init(jsonData:[String:Any]){
        id = jsonData["id"] as? String ?? ""
        email = jsonData["email"] as? String ?? ""
        name = jsonData["name"] as? String ?? ""
        verifiedEmail = jsonData["verified_email"] as? Bool ?? false
        fcmToken = jsonData["fcmToken"] as? String ?? ""
        role = jsonData["role"] as? String ?? ""
    }
}

// MARK: - Empty
struct UserStatusModel {
    let data: UserStatusData
    let success: Bool
    let message: String
    init(jsonData:[String:Any]){
        success = jsonData["success"] as? Bool ?? false
        message = jsonData["message"] as? String ?? ""
        data = UserStatusData(jsonData: (jsonData["data"] as? [String:Any] ?? [String:Any]()))
    }
    
}

// MARK: - DataClass
struct UserStatusData {
    let id, email: String
    let zoomID: String
    let isActive: Bool
    let providertype, role, status, fcmToken: String
    let updatedBy: String
    let createdAt, updatedAt, identificationID: String

    init(jsonData:[String:Any]){
        id = jsonData["id"] as? String ?? ""
        email = jsonData["email"] as? String ?? ""
        zoomID = jsonData["zoom_id"] as? String ?? ""
        isActive = jsonData["is_active"] as? Bool ?? false
        providertype = jsonData["providertype"] as? String ?? ""
        role = jsonData["role"] as? String ?? ""
        status = jsonData["status"] as? String ?? ""
        fcmToken = jsonData["fcm_token"] as? String ?? ""
        updatedBy = jsonData["updated_by"] as? String ?? ""
        createdAt = jsonData["created_at"] as? String ?? ""
        updatedAt = jsonData["updated_at"] as? String ?? ""
        identificationID = jsonData["identification_id"] as? String ?? ""
    }
}


// MARK: - Empty
struct UploadDocumentModel: Codable {
    let success: Bool
    let message: String
    let data: [String]
}
