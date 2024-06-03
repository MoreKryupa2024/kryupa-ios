//
//  GoogleSignupModel.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 15/05/24.
//

import Foundation


// MARK: - Empty
struct Empty: Codable {
    let success: Bool
    let message: String
    let data: DataClass
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
struct DataClass: Codable {
    let accessToken, refrenceToken: String
    let userInfo: UserInfo
    let userTypes, verificationStatus: String

    enum CodingKeys: String, CodingKey {
        case accessToken, refrenceToken, userInfo
        case userTypes = "UserTypes"
        case verificationStatus
    }
}

// MARK: - UserInfo
struct UserInfo: Codable {
    let id, email, name: String
    let verifiedEmail: Bool
    let fcmToken, role: String

    enum CodingKeys: String, CodingKey {
        case id, email, name
        case verifiedEmail
        case fcmToken, role
    }
}


// MARK: - Empty
struct UploadDocumentModel: Codable {
    let success: Bool
    let message: String
    let data: [String]
}
