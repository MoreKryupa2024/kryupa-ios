//
//  ChatScreenViewModel.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 02/07/24.
//

import Foundation
import SocketIO


class ChatScreenViewModel: ObservableObject{
    
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
                     "booking_id":bookingId,
                     "draft_id":Defaults().draftId]
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
        chatWindowFocus()
        self.receiveMessage { msgData in
            self.messageList = [msgData] + self.messageList
        }
    }

    func disconnect() {
        chatWindowUnfocus()
    }
    
    
    func chatWindowFocus(){
        SocketSingleClass.shared.chatWindowFocus(contactId: selectedChat?.id ?? "")
    }
    
    func chatWindowUnfocus(){
        SocketSingleClass.shared.chatWindowUnfocus(contactId: selectedChat?.id ?? "")
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
        guard let selectedChat else {return}
        SocketSingleClass.shared.sendMessage(message, selectedChat: selectedChat, completion: { msgData in
            self.messageList = [msgData] + self.messageList
        })
    }

    func receiveMessage(_ completion: @escaping (MessageData) -> Void) {
        guard let selectedChat else {return}
        SocketSingleClass.shared.receiveMessage({ msgData in
            let messcount = self.messageList.filter{$0.id == msgData.id}
            if messcount.count == 0{
                completion(msgData)
            }
        }, selectedChat: selectedChat)
    }
}
