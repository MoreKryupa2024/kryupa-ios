//
//  ChatModel.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 03/07/24.
//

import Foundation

// MARK: - Empty
struct ChatListModel {
    let success: Bool
    let message: String
    let data: [ChatListData]
    
    init(jsonData: [String:Any]){
        message = jsonData["message"] as? String ?? ""
        success = jsonData["success"] as? Bool ?? false
        data = (jsonData["data"] as? [[String:Any]] ?? [[String:Any]]()).map{ ChatListData(jsonData:$0)}
    }
}


struct RecommendGiverModel {
    let success: Bool
    let message: String
    let data: ChatListData
    
    init(jsonData: [String:Any]){
        message = jsonData["message"] as? String ?? ""
        success = jsonData["success"] as? Bool ?? false
        data = ChatListData(jsonData:jsonData["data"] as? [String:Any] ?? [String:Any]())
    }
}

// MARK: - DataClass
struct ChatListData {
    let id: String
    let isBlocked: Bool
    let createdAt, updatedAt, giverId, seekerId: String
    let cpID, name: String
    let profilePictureURL: String

    init(jsonData:[String:Any]){
        id = jsonData["id"] as? String ?? ""
        isBlocked = jsonData["is_blocked"] as? Bool ?? false
        createdAt = jsonData["created_at"] as? String ?? ""
        updatedAt = jsonData["updated_at"] as? String ?? ""
        giverId = jsonData["user2_id"] as? String ?? ""
        seekerId = jsonData["user1_id"] as? String ?? ""
        cpID = jsonData["cp_id"] as? String ?? ""
        name = jsonData["name"] as? String ?? ""
        profilePictureURL = jsonData["profile_picture_url"] as? String ?? ""
    }
}

// MARK: - Empty
struct MessageModel {
    let success: Bool
    let data: [MessageData]
    
    init(jsonData: [String:Any]){
        success = jsonData["success"] as? Bool ?? false
        data = (jsonData["data"] as? [[String:Any]] ?? [[String:Any]]()).map{ MessageData(jsonData:$0)}
    }
}

// MARK: - Datum
struct MessageData {
    let id, contactListID, sender, recipient: String
    let message: String
    let status: String
    let createdAt, updatedAt: String
    let isActionBtn: Bool

    init(jsonData: [String:Any]){
        id = jsonData["id"] as? String ?? ""
        contactListID = jsonData["contact_list_id"] as? String ?? ""
        sender = jsonData["sender"] as? String ?? ""
        recipient = jsonData["recipient"] as? String ?? ""
        message = jsonData["message"] as? String ?? ""
        status = jsonData["status"] as? String ?? ""
        createdAt = jsonData["created_at"] as? String ?? ""
        updatedAt = jsonData["updated_at"] as? String ?? ""
        isActionBtn = jsonData["is_action_btn"] as? Bool ?? false
    }
}

struct SpecialMessageData {
    let approchId, btnTitle, content, type: String
    
    init(jsonData:[String:Any]){
        approchId = jsonData["approch_id"] as? String ?? ""
        btnTitle = jsonData["btn_title"] as? String ?? ""
        content = jsonData["content"] as? String ?? ""
        type = jsonData["type"] as? String ?? ""
    }
}
