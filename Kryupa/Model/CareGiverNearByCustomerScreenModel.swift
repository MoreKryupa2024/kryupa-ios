//
//  CareGiverNearByCustomerScreenModel.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 05/06/24.
//

import Foundation

// MARK: - Empty
struct  CareGiverNearByCustomerScreenModel {
    let success: Bool
    let message: String
    let data: [CareGiverNearByCustomerScreenData]
    
    init(jsonData: [String:Any]){
        success = jsonData["success"] as? Bool ?? false
        message = jsonData["message"] as? String ?? ""
        data = (jsonData["data"] as? [[String:Any]] ?? [[String:Any]]()).map{CareGiverNearByCustomerScreenData(jsonData: $0)}
    }
}
// MARK: - Datum
struct  CareGiverNearByCustomerScreenData {
    let id, name, email,profile: String
    let zoomID: String
    let isActive: Bool
    let price: Int
    let yearsOfExprience: Int
    let providertype, role, status, fcmToken: String
    let updatedBy: String
    let createdAt, updatedAt: String
    
    init(jsonData:[String:Any]){
        id = jsonData["id"] as? String ?? ""
        profile = jsonData["profile_picture_url"] as? String ?? ""
        email = jsonData["email"] as? String ?? ""
        price = jsonData["price_per_hour"] as? Int ?? 0
        yearsOfExprience = jsonData["years_of_exprience_in_no"] as? Int ?? 0
        zoomID = jsonData["zoom_id"] as? String ?? ""
        isActive = jsonData["is_active"] as? Bool ?? false
        providertype = jsonData["providertype"] as? String ?? ""
        role = jsonData["role"] as? String ?? ""
        status = jsonData["status"] as? String ?? ""
        name = jsonData["name"] as? String ?? ""
        fcmToken = jsonData["fcm_token"] as? String ?? ""
        updatedBy = jsonData["updated_by"] as? String ?? ""
        createdAt = jsonData["created_at"] as? String ?? ""
        updatedAt = jsonData["updated_at"] as? String ?? ""
    }

}
