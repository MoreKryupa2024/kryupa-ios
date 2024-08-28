//
//  ChatScreenViewModel.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 02/07/24.
//

import Foundation
import SocketIO


class ChatScreenViewModel: ObservableObject{
    
    private let manager: SocketManager!
    private let socket: SocketIOClient!
    var selectedChat: ChatListData?
    
    @Published var messageList = [MessageData]()
    static let shared = ChatScreenViewModel()
    var meetingTokenData: BGVInterviewMeetingTokenData?
    @Published var isLoading = Bool()
    @Published var isRecommended = Bool()
    @Published var normalBooking = Bool()
    let notificatioSsetBookingId = NotificationCenter.default
    @Published var paySpecialMessageData: SpecialMessageData?
    @Published var bookingId = String()
    @Published var pagination: Bool = true
    @Published var pageNumber = 1
    @Published var isPresented = false
    
    init(){
        self.manager = SocketManager(socketURL: URL(string: "\(APIConstant.baseURL)/")!, config: [.log(true), .compress])
        self.socket = self.manager.defaultSocket
        connect()
        receiveMessage { msgData, str in
            self.messageList = [msgData] + self.messageList
        }
        notificatioSsetBookingId.addObserver(forName: .setBookingId, object: nil, queue: nil,
                                                     using: self.setBookingIds)
    }
    
    private func setBookingIds(_ notification: Notification) {
        if let bookingid = notification.userInfo?["bookingId"] as? String {
            bookingId = bookingid
            isRecommended = false
            sendRequestForBookCaregiver()
        }
    }
    
    func sendRequestForBookCaregiver(){
        let param = ["caregiver_id":selectedChat?.giverId ?? "",
                     "booking_id":bookingId]
        isLoading = true
        NetworkManager.shared.sendRequestForBookCaregiver(params:param) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result{
                case .success(_):
//                    self?.selectedChat = data.data
                    self?.getChatHistory()
                case .failure(let error):
                    print(error.getMessage())
                }
            }
        }
    }

    func connect() {
        socket.on(clientEvent: .connect) {data, ack in
            print("socket connected")
            //Call your first socket here
        }
        let param = ["Authorization": "bearer \(Defaults().accessToken)"]
        socket.connect(withPayload: param)
    }

    func disconnect() {
        socket.disconnect()
    }
    
    func getChatHistory(){
        guard let contactId = selectedChat?.id else {return}
        if (selectedChat?.id ?? "") == ""{
            return
        }
        isLoading = true
        let param:[String:Any] = ["contactId": contactId,"pageSize":20]
        
        /* let param:[String:Any] = ["contactId": contactId,
         "pageNumber":pageNumber,
         "pageSize":20]*/
        NetworkManager.shared.getChatHistory(params: param) { [weak self] result in
            guard let self else {
                self?.isLoading = false
                return
            }
            DispatchQueue.main.async {
                self.isLoading = false
                switch result{
                case .success(let data):
                    self.messageList = data.data.filter({ MessageData in
                        if MessageData.message.contains("video_call"){
//                            self.showVideoCallView = false
                            return false
//                        }else if MessageData.message.contains("pay_now"){
//                            self.paySpecialMessageData = SpecialMessageData(jsonData: (MessageData.message.toJSON() as? [String : Any] ?? [String : Any]()))
//                            self.showPayViewView = true
//                            return false
                        }else{
                            return true
                        }
                    })
                    
                    /*
                     if self.pageNumber > 1{
                         self.messageList += data.data.filter({ MessageData in
                             if MessageData.message.contains("video_call"){
                                 self.showVideoCallView = false
                                 return false
     //                        }else if MessageData.message.contains("pay_now"){
     //                            self.paySpecialMessageData = SpecialMessageData(jsonData: (MessageData.message.toJSON() as? [String : Any] ?? [String : Any]()))
     //                            self.showPayViewView = true
     //                            return false
                             }else{
                                 return true
                             }
                         })
                     }else{
                         self.messageList = data.data.filter({ MessageData in
                             if MessageData.message.contains("video_call"){
                                 self.showVideoCallView = false
                                 return false
     //                        }else if MessageData.message.contains("pay_now"){
     //                            self.paySpecialMessageData = SpecialMessageData(jsonData: (MessageData.message.toJSON() as? [String : Any] ?? [String : Any]()))
     //                            self.showPayViewView = true
     //                            return false
                             }else{
                                 return true
                             }
                         })
                     }
                     self.pagination = data.data.count != 0*/
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func chatVideoCallData(){
        guard let contactId = selectedChat?.id else {return}
        if (selectedChat?.id ?? "") == ""{
            return
        }
        var senderId = String()
        var recipientId = String()
        if Defaults().userType == AppConstants.GiveCare{
            senderId = selectedChat?.giverId ?? ""
            recipientId = selectedChat?.seekerId ?? ""
        }else{
            recipientId = selectedChat?.giverId ?? ""
            senderId = selectedChat?.seekerId ?? ""
        }
        isLoading = true
        let param:[String:Any] = ["contact_Id": contactId,
                                  "received_by":recipientId,
                                  "started_by":senderId]
        
        NetworkManager.shared.chatVideoCall(params: param) { [weak self] result in
            guard let self else {
                self?.isLoading = false
                return
            }
            DispatchQueue.main.async {
                self.isLoading = false
                switch result{
                case .success(let data):
                    if self.isPresented == false{
                        self.meetingTokenData = data.data
                        self.isPresented = true
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func VideoCallData(){
        guard let videoCallId = selectedChat?.videoCallId else {return}
        if (selectedChat?.videoCallId ?? "") == ""{
            return
        }
        
        isLoading = true
        let param:[String:Any] = ["video_call_id": videoCallId]
        
        NetworkManager.shared.chatVideoCallID(params: param) { [weak self] result in
            guard let self else {
                self?.isLoading = false
                return
            }
            DispatchQueue.main.async {
                self.isLoading = false
                switch result{
                case .success(let data):
                    if self.isPresented == false{
                        self.selectedChat?.videoCallId = ""
                        self.meetingTokenData = data.data
                        self.isPresented = true
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }

    func sendMessage(_ message: String) {
        var senderId = String()
        var recipientId = String()
        if Defaults().userType == AppConstants.GiveCare{
            senderId = selectedChat?.giverId ?? ""
            recipientId = selectedChat?.seekerId ?? ""
        }else{
            recipientId = selectedChat?.giverId ?? ""
            senderId = selectedChat?.seekerId ?? ""
        }
        
        let msgData = MessageData(jsonData: [
            "id": "\(UUID())",
            "message": message,
            "sender":senderId,
            "recipient":recipientId
        ])
        let param = ["contact_Id":selectedChat?.id ?? "",
                     "sender_id":senderId,
                     "recipient_id":recipientId,
                     "Authorization": "bearer \(Defaults().accessToken)",
                     "message":message]
        
        socket.emit("message_send", with: [param]) {
            self.messageList = [msgData] + self.messageList
        }
    }

    func receiveMessage(_ completion: @escaping (MessageData, String) -> Void) {
        socket.on("message_receive") { [weak self] data, _ in
            if let typeDict = data[0] as? NSDictionary {
                print(typeDict)
                var senderId = String()
                var recipientId = String()
                if Defaults().userType == AppConstants.GiveCare{
                    recipientId = self?.selectedChat?.giverId ?? ""
                    senderId = self?.selectedChat?.seekerId ?? ""
                }else{
                    senderId = self?.selectedChat?.giverId ?? ""
                    recipientId = self?.selectedChat?.seekerId ?? ""
                }
                let message = typeDict.value(forKey: "message") as? String ?? ""
                let actionButton = typeDict.value(forKey: "is_action_btn") as? Bool ?? false
                HapticManager.sharde.impact(style: .heavy)
                let msgData = MessageData(jsonData: [
                    "id": "\(UUID())",
                    "message": message,
                    "sender":senderId,
                    "recipient":recipientId,
                    "is_action_btn":actionButton
                ])
                completion(msgData, "")
            }
        }
    }
}
