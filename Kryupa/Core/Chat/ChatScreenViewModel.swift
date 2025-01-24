//
//  ChatScreenViewModel.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 02/07/24.
//

import Foundation
import SocketIO


class ChatScreenViewModel: ObservableObject{
    
    var manager: SocketManager?
    var socket: SocketIOClient?
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
    @Published var isPresentedVideo = false
    @Published var isPresentedAudio = false
    
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
                    self?.getChatHistory()
                case .failure(let error):
                    print(error.getMessage())
                }
            }
        }
    }

    func connect() {
        updateInboxListSockit()
        chatWindowFocus()
        self.receiveMessage { msgData, str in
            self.messageList = [msgData] + self.messageList
        }
    }

    func disconnect() {
        chatWindowUnfocus()
    }
    
    func updateInboxListSockit(){
        socket?.on("update_inbox_list") { [weak self] data, _ in
            print("********************* socket inbox Connected")
        }
    }
    
    func chatWindowFocus(){
        let param = ["contactId":selectedChat?.id ?? ""]
        self.socket?.emit("chat_window_focus", with: [param]){
            print("********************* chat_window_focus Connected")
        }
    }
    
    func chatWindowUnfocus(){
        let param = ["contactId":selectedChat?.id ?? ""]
        self.socket?.emit("chat_window_unfocus", with: [param]){}
    }
    
    func getChatHistory(){
        guard let contactId = selectedChat?.id else {return}
        if (selectedChat?.id ?? "") == ""{
            return
        }
        isLoading = true
        let param:[String:Any] = ["contactId": contactId,"pageSize":20,"pageNumber":pageNumber]
        
        NetworkManager.shared.getChatHistory(params: param) { [weak self] result in
            guard let self else {
                self?.isLoading = false
                return
            }
            DispatchQueue.main.async {
                self.isLoading = false
                switch result{
                case .success(let data):
                    if self.pageNumber == 1{
                        self.messageList = data.data.filter({ MessageData in
                            if MessageData.message.contains("video_call"){
                                return false
                            }else{
                                return true
                            }
                        })
                    }else{
                        self.messageList += data.data.filter({ MessageData in
                            if MessageData.message.contains("video_call"){
                                return false
                            }else{
                                return true
                            }
                        })
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func chatVideoCallData(onlyAudio: Bool){
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
                                  "started_by":senderId,
                                  "call_type": onlyAudio ? "audio" : "video"]
        
        NetworkManager.shared.chatVideoCall(params: param) { [weak self] result in
            guard let self else {
                self?.isLoading = false
                return
            }
            DispatchQueue.main.async {
                self.isLoading = false
                switch result{
                case .success(let data):
                    
                    self.meetingTokenData = data.data
                    
                    
                    if onlyAudio {
                        if self.isPresentedAudio == false{
                            self.isPresentedAudio = true
                            self.isPresentedVideo = false
                        }
                    }
                    else {
                        if self.isPresentedVideo == false{
                            self.isPresentedVideo = true
                            self.isPresentedAudio = false
                        }
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
                    
                        self.selectedChat?.videoCallId = ""
                        self.meetingTokenData = data.data
                        if data.data.callType == "audio"{
                            self.isPresentedAudio = true
                            self.isPresentedVideo = false
                        }
                        else {
                            self.isPresentedAudio = false
                            self.isPresentedVideo = true
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
        let id  = "\(UUID())"
        
        let msgData = MessageData(jsonData: [
            "id": id,
            "message": message,
            "sender":senderId,
            "recipient":recipientId
        ])
        let param = ["contact_Id":selectedChat?.id ?? "",
                     "id": id,
                     "sender_id":senderId,
                     "recipient_id":recipientId,
                     "Authorization": "bearer \(Defaults().accessToken)",
                     "message":message]
        print("---message_send Called")
        socket?.emit("message_send", with: [param]) {
            self.messageList = [msgData] + self.messageList
        }
    }

    func receiveMessage(_ completion: @escaping (MessageData, String) -> Void) {
        print("---message_receive Called")
        socket?.on("message_receive") { [weak self] data, _ in
            guard let self else { return }
            if let typeDict = data[0] as? NSDictionary {
                print(typeDict)
                var senderId = String()
                var recipientId = String()
                if Defaults().userType == AppConstants.GiveCare{
                    recipientId = self.selectedChat?.giverId ?? ""
                    senderId = self.selectedChat?.seekerId ?? ""
                }else{
                    senderId = self.selectedChat?.giverId ?? ""
                    recipientId = self.selectedChat?.seekerId ?? ""
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
                    "created_at": Date().formattedDateString(format: "yyyy-MM-dd HH:mm:ss.SSS")
                ])
                let messcount = self.messageList.filter{$0.id == id}
                if messcount.count == 0{
                    completion(msgData, "")
                }
            }
        }
    }
}
