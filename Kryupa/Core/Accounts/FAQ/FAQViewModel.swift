//
//  FAQViewModel.swift
//  Kryupa
//
//  Created by Hemant Singh Rajput on 02/08/24.
//

import Foundation
import SocketIO

class FAQViewModel: ObservableObject{
    
    private var manager: SocketManager!
    private var socket: SocketIOClient!
    @Published var selectedSection = 0
    @Published var faqModelData: FAQModelData?
    @Published var sendMsgText: String = ""
    @Published var pagination: Bool = true
    @Published var pageNumber = 1
    @Published var isLoading = Bool()
    
    init(){
        self.manager = SocketManager(socketURL: URL(string: "\(APIConstant.communicationBaseURL)/")!, config: [.log(true), .compress])
        self.socket = self.manager.defaultSocket
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
    
    func sendMessage(_ message: String) {
        
        let msgData = AllConversationData(jsonData: [
            "id": "\(UUID())",
            "message": message,
            "sender":faqModelData?.userId ?? "",
            "recipient":faqModelData?.adminId ?? ""
        ])
        let param = ["contact_Id":faqModelData?.contactID ?? "",
                     "sender_id":faqModelData?.userId ?? "",
                     "recipient_id":faqModelData?.adminId ?? "",
                     "Authorization": "bearer \(Defaults().accessToken)",
                     "message":message]
        
        socket.emit("help_chat", with: [param]) {
            DispatchQueue.main.async {
                self.faqModelData?.allConversation.append(msgData)
            }
        }
    }
    
    func receiveMessage() {
        socket.on("message_receive") { [weak self] data, _ in
            guard let self else {return}
            if let typeDict = data[0] as? NSDictionary {
                
                let message = typeDict.value(forKey: "message") as? String ?? ""
                HapticManager.sharde.impact(style: .heavy)
                let msgData = AllConversationData(jsonData: [
                    "id": "\(UUID())",
                    "message": message,
                    "sender":faqModelData?.adminId ?? "",
                    "recipient":faqModelData?.userId ?? "",
                ])
                DispatchQueue.main.async {
                    self.faqModelData?.allConversation.append(msgData)
                }
            }
        }
    }
    
    func conversationWithAdmin(){
//        let param = ["pageNumber":pageNumber,
        let param = ["pageNumber":1,
                     "pageSize":20]
        isLoading = true
        NetworkManager.shared.conversationWithAdmin(params:param) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result{
                case .success(let data):
                    /*  if self!.pageNumber > 1{
                     self?.faqModelData?.allConversation += data.data.allConversation
                 }else{
                     self?.faqModelData = data.data
                 }
                 self?.pagination = data.data.allConversation.count != 0
                 */
                    self?.faqModelData = data.data
                case .failure(let error):
                    print(error.getMessage())
                }
            }
        }
    }
}
