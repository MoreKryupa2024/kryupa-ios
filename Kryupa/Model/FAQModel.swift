//
//  FAQModel.swift
//  Kryupa
//
//  Created by Hemant Singh Rajput on 02/08/24.
//

import Foundation


// MARK: - Welcome
struct FAQModel {
    let success: Bool
    let message: String
    let data: FAQModelData
    
    init(jsonData:[String:Any]) {
        message = jsonData["message"] as? String ?? ""
        success = jsonData["success"] as? Bool ?? false
        data = FAQModelData(jsonData: jsonData["data"] as? [String:Any] ?? [String:Any]())
    }
    
    
}

// MARK: - DataClass
struct FAQModelData {
    let contactID: String
    let userId: String
    let adminId: String
    var allConversation: [AllConversationData]

    init(jsonData:[String:Any]) {
        contactID = jsonData["contactId"] as? String ?? ""
        userId = jsonData["user_id"] as? String ?? ""
        adminId = jsonData["admin_id"] as? String ?? ""
        allConversation =  (jsonData["allConversation"] as? [[String:Any]] ?? [[String:Any]]()).map{AllConversationData(jsonData: $0)}
    }
}

// MARK: - AllConversation
struct AllConversationData {
    let id, helpTicketInboxID, sender, recipient: String
    let message: String
    let isActionBtn: Bool
    let status, createdAt, updatedAt: String

    init(jsonData:[String:Any]) {
        id = jsonData["id"] as? String ?? ""
        helpTicketInboxID = jsonData["help_ticket_inbox_id"] as? String ?? ""
        sender = jsonData["sender"] as? String ?? ""
        recipient = jsonData["recipient"] as? String ?? ""
        message = jsonData["message"] as? String ?? ""
        isActionBtn = jsonData["is_action_btn"] as? Bool ?? false
        status = jsonData["status"] as? String ?? ""
        createdAt = jsonData["created_at"] as? String ?? ""
        updatedAt = jsonData["updated_at"] as? String ?? ""
    }
}
