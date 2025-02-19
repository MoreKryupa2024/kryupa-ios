//
//  SocketFile.swift
//  Kryupa
//
//  Created by Hemant Singh Rajput on 06/02/25.
//

import Foundation
import SocketIO

final class SocketSingleClass{
    
    private var manager: SocketManager!
    private var socket: SocketIOClient!
    
    static let shared = SocketSingleClass()
    
    private init() {
        setUpSocket()
    }
    
    func checkLobbyStatus(){
        let param = ["userID":Defaults().userId]
        self.socket.emit("bgv_done_by_admin", with: [param]){
            NotificationCenter.default.post(name: .checkLobby, object: nil, userInfo: nil)
        }
    }
    
    func setUpSocket(){
        self.manager = SocketManager(socketURL: URL(string: APIConstant.chatURL)!, config: [.log(true), .compress])
        self.socket = self.manager?.defaultSocket
        self.connect()
    }
    
    func updateInboxListSockit(reloadAction: @escaping () -> Void){
        socket.on("update_inbox_list") { data, _ in
            print("********************* socket inbox Connected")
            reloadAction()
        }
    }
    
    func receiveMessageFAQ(faqModelData: FAQModelData, completion: @escaping (AllConversationData) -> Void) {
        socket.on("message_receive") { data, _ in
            if let typeDict = data[0] as? NSDictionary {
                
                let message = typeDict.value(forKey: "message") as? String ?? ""
                let id = typeDict.value(forKey: "id") as? String ?? ""
                HapticManager.sharde.impact(style: .heavy)
                let msgData = AllConversationData(jsonData: [
                    "id": id,
                    "message": message,
                    "sender":faqModelData.adminId,
                    "recipient":faqModelData.userId,
                ])
                completion(msgData)
            }
        }
    }
    
    
    func sendMessageFAQ(_ message: String,faqModelData: FAQModelData, completion: @escaping (AllConversationData) -> Void) {
        let id  = "\(UUID())"
        let msgData = AllConversationData(jsonData: [
            "id": id,
            "message": message,
            "sender":faqModelData.userId,
            "recipient":faqModelData.adminId
        ])
        let param = ["contact_Id":faqModelData.contactID,
                     "id": id,
                     "sender_id":faqModelData.userId,
                     "recipient_id":faqModelData.adminId,
                     "Authorization": "bearer \(Defaults().accessToken)",
                     "message":message]
        
        socket.emit("help_chat", with: [param]) {
            completion(msgData)
            
        }
    }
    func connect() {
        socket.on(clientEvent: .connect) { data, ack in
            print("*********************socket Connected")
        }
        let param = ["Authorization": "bearer \(Defaults().accessToken)"]
        socket.connect(withPayload: param)
    }
    
    
    func chatWindowFocus(contactId: String){
        let param = ["contactId":contactId]
        self.socket?.emit("chat_window_focus", with: [param]){}
    }
    
    func chatWindowUnfocus(contactId: String){
        let param = ["contactId":contactId]
        self.socket?.emit("chat_window_unfocus", with: [param]){}
    }
    
    func receiveMessage(_ completion: @escaping (MessageData) -> Void,selectedChat: ChatListData) {
        socket.on("message_receive") { [weak self] data, _ in
            guard let self else { return }
            if let typeDict = data[0] as? NSDictionary {
                print(typeDict)
                var senderId = String()
                var recipientId = String()
                if Defaults().userType == AppConstants.GiveCare{
                    recipientId = selectedChat.giverId
                    senderId = selectedChat.seekerId
                }else{
                    senderId = selectedChat.giverId
                    recipientId = selectedChat.seekerId
                }
                let message = typeDict.value(forKey: "message") as? String ?? ""
                let id = typeDict.value(forKey: "id") as? String ?? ""
                let actionButton = typeDict.value(forKey: "is_action_btn") as? Bool ?? false
                HapticManager.sharde.impact(style: .heavy)
                let msgData = MessageData(jsonData: [
                    "id": id,
                    "message": message,
                    "sender":senderId,
                    "recipient":recipientId,
                    "is_action_btn":actionButton,
                    "date_time": Date().formattedDateString(format: "EEE, dd MMM yyyy HH:mm:ss zzz")
                ])
                completion(msgData)
            }
        }
    }
    
    func sendMessage(_ message: String,selectedChat: ChatListData, completion: @escaping (MessageData) -> Void) {
        var senderId = String()
        var recipientId = String()
        if Defaults().userType == AppConstants.GiveCare{
            senderId = selectedChat.giverId
            recipientId = selectedChat.seekerId
        }else{
            recipientId = selectedChat.giverId
            senderId = selectedChat.seekerId
        }
        let id  = "\(UUID())"
        
        let msgData = MessageData(jsonData: [
            "id": id,
            "message": message,
            "sender":senderId,
            "recipient":recipientId,
            "date_time": Date().formattedDateString(format: "EEE, dd MMM yyyy HH:mm:ss zzz")
        ])
        let param = ["contact_Id":selectedChat.id,
                     "id": id,
                     "sender_id":senderId,
                     "recipient_id":recipientId,
                     "Authorization": "bearer \(Defaults().accessToken)",
                     "message":message]
        print("---message_send Called")
        socket?.emit("message_send", with: [param]) {
            completion(msgData)
        }
    }
}
