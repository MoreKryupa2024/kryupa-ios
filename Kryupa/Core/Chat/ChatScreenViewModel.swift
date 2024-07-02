//
//  ChatScreenViewModel.swift
//  Kryupa
//
//  Created by Hemant Singh Rajput on 02/07/24.
//

import Foundation
import SocketIO


class ChatScreenViewModel: ObservableObject{
    
    var manager: SocketManager!
    var socket: SocketIOClient!
    static let shared = ChatScreenViewModel()
    
    init(){
        self.manager = SocketManager(socketURL: URL(string: "https://w7dvnjx5-3005.inc1.devtunnels.ms/")!, config: [.log(true), .compress])
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
        let param = ["contact_Id":"248e713c-79dd-46dd-8941-3dadd72033da",
                     "sender_id":"d8b8446f-57e0-4698-a40f-2992d0c26bb9",
                     "recipient_id":"1816d57f-3eaa-4425-bfb7-b620e7651c43",
                     "Authorization": "bearer \(Defaults().accessToken)",
                     "message":message]
        
        socket.emit("message_send", with: [param]) {
            print()
        }
    }

    func receiveMessage(_ completion: @escaping (String, String, UUID) -> Void) {
        socket.on("message_receive") { data, _ in
            print(data)
        }
    }
    
}
