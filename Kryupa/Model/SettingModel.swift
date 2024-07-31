//
//  SettingModel.swift
//  Kryupa
//
//  Created by Hemant Singh Rajput on 31/07/24.
//

import Foundation

// MARK: - Welcome
struct SettingNotificationModel {
    let success: Bool
    let message: String
    let data: SettingNotificationData
    
    init(jsonData:[String:Any]){
        message = jsonData["message"] as? String ?? ""
        success = jsonData["success"] as? Bool ?? false
        data = SettingNotificationData(jsonData: jsonData["data"] as? [String:Any] ?? [String:Any]())
    }
}

// MARK: - DataClass
struct SettingNotificationData {
    let id, userID, userType: String
    let getNotificationAboutOurLatestUpdates, getSMSAlert, subscribeToOurNewsletter, whatsappNotification: Bool
    let createdAt, updatedAt, createdBy, updatedBy: String
    let isActive, isDeleted: Bool

    init(jsonData:[String:Any]){
        id = jsonData["id"] as? String ?? ""
        userID = jsonData["user_id"] as? String ?? ""
        userType = jsonData["user_type"] as? String ?? ""
        getNotificationAboutOurLatestUpdates = jsonData["get_notification_about_our_latest_updates"] as? Bool ?? false
        getSMSAlert = jsonData["get_sms_alert"] as? Bool ?? false
        subscribeToOurNewsletter = jsonData["subscribe_to_our_newsletter"] as? Bool ?? false
        whatsappNotification = jsonData["whatsapp_notification"] as? Bool ?? false
        createdAt = jsonData["created_at"] as? String ?? ""
        updatedAt = jsonData["updated_at"] as? String ?? ""
        createdBy = jsonData["created_by"] as? String ?? ""
        updatedBy = jsonData["updated_by"] as? String ?? ""
        isActive = jsonData["is_active"] as? Bool ?? false
        isDeleted = jsonData["is_deleted"] as? Bool ?? false
    }
}
