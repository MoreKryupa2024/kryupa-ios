//
//  ChatScreenViewModel.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 02/07/24.
//

import Foundation
import SocketIO


class ChatScreenViewModel: ObservableObject{
    
    var manager: SocketManager!
    var socket: SocketIOClient!
    var selectedChat: ChatListData?
    @Published var inboxList = [ChatListData]()
    @Published var messageList = [MessageData]()
    static let shared = ChatScreenViewModel()
    @Published var isLoading = Bool()
    @Published var showVideoCallView = Bool()
    @Published var isRecommended = Bool()
    @Published var normalBooking = Bool()
    @Published var bookingDeclineView = Bool()
    @Published var showPayViewView = Bool()
    @Published var paySpecialMessageData: SpecialMessageData?
    @Published var bookingId = String()
    
    init(){
        self.manager = SocketManager(socketURL: URL(string: "\(APIConstant.baseURL)/")!, config: [.log(true), .compress])
        self.socket = self.manager.defaultSocket
    }
    
    func sendRequestForBookCaregiver(){
        let param = ["caregiver_id":selectedChat?.giverId ?? "",
                     "booking_id":bookingId]
        isLoading = true
        NetworkManager.shared.sendRequestForBookCaregiver(params:param) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result{
                case .success(let data):
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
        //https://ccjlmfh6-3050.inc1.devtunnels.ms/apis/communication/chat/get_conversation
        guard let contactId = selectedChat?.id else {return}
        if (selectedChat?.id ?? "") == ""{
            return
        }
        isLoading = true
        let param:[String:Any] = ["contactId": contactId]
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
                            self.showVideoCallView = false
                            return false
                        }else if MessageData.message.contains("pay_now"){
                            self.paySpecialMessageData = SpecialMessageData(jsonData: (MessageData.message.toJSON() as? [String : Any] ?? [String : Any]()))
                            self.showPayViewView = true
                            return false
                        }else{
                            return true
                        }
                    })
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
            DispatchQueue.main.async {
                self.messageList.append(msgData)
            }
        }
    }

    func receiveMessage(_ completion: @escaping (MessageData, String) -> Void) {
        socket.on("message_receive") { [weak self] data, _ in
            if let typeDict = data[0] as? NSDictionary {
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
                print(message)
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
    
    func getInboxList(){
        isLoading = true
        NetworkManager.shared.getInboxList { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let data):
                    self?.inboxList = data.data
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
}
