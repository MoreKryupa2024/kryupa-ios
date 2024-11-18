//
//  InboxScreenViewModel.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 14/08/24.
//

import Foundation
import SocketIO

class InboxScreenViewModel: ObservableObject{
    
    @Published var inboxList = [ChatListData]()
    @Published var isLoading = Bool()
    @Published var showChatView = Bool()
    private var manager: SocketManager!
    private var socket: SocketIOClient!
    let notificatioSetChatScreen = NotificationCenter.default
    let viewModelChat = ChatScreenViewModel()
    
    init(){
        notificatioSetChatScreen.addObserver(forName: .setChatScreen, object: nil, queue: nil,using: self.setChatScreen)
        notificatioSetChatScreen.addObserver(forName: .disconnectSockit, object: nil, queue: nil,using: self.disconnectSockit)
        setUpSocket()
        viewModelChat.manager = self.manager
        viewModelChat.socket = self.socket
    }
    
    func setUpSocket(){
        self.manager = SocketManager(socketURL: URL(string: APIConstant.chatURL)!, config: [.log(true), .compress])
        self.socket = self.manager.defaultSocket
    }
    
    func connect() {
        socket.on(clientEvent: .connect) {data, ack in
            self.updateInboxListSockit()
            //Call your first socket here
        }
        let param = ["Authorization": "bearer \(Defaults().accessToken)"]
        socket.connect(withPayload: param)
    }
    
    func updateInboxListSockit(){
        socket?.on("update_inbox_list") { [weak self] data, _ in
            self?.getInboxList()
        }
    }
    deinit{
        disconnect()
    }
    
    func disconnect() {
        socket.disconnect()
    }
    
    private func setChatScreen(_ notification: Notification){
        if let data = notification.userInfo, let dataDict = data as? [String:Any] {
            viewModelChat.selectedChat = ChatListData(jsonData: dataDict)
            showChatView = true
        }
    }
    
    private func disconnectSockit(_ notification: Notification){
        socket.disconnect()
    }
    
    func getInboxList(){
        isLoading = true
        //let param = ["pageNumber":pageNumber,
        let param = ["pageNumber":1,
                     "pageSize":20]
        NetworkManager.shared.getInboxList(params: param) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let data):
                    self?.inboxList = data.data
//                    if self!.pageNumber > 1{
//                        self?.inboxList += data.data
//                    }else{
//                        self?.inboxList = data.data
//                    }
//                    self?.pagination = data.data.count != 0
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
