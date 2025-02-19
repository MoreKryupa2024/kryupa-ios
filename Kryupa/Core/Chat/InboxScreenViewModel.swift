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
    let notificatioSetChatScreen = NotificationCenter.default
    let viewModelChat = ChatScreenViewModel()
    
    init(){
        notificatioSetChatScreen.addObserver(forName: .setChatScreen, object: nil, queue: nil,using: self.setChatScreen)
//        notificatioSetChatScreen.addObserver(forName: .disconnectSockit, object: nil, queue: nil,using: self.disconnectSockit)
        
    }
    
    
    func updateInboxListSockit(){
        SocketSingleClass.shared.updateInboxListSockit { [weak self] in
            self?.getInboxList()
        }
    }
    
    private func setChatScreen(_ notification: Notification){
        if let data = notification.userInfo, var dataDict = data as? [String:Any] {
            let aps = dataDict["aps"] as? [String:Any] ?? [String:Any]()
            let alert = aps["alert"] as? [String:Any] ?? [String:Any]()
            dataDict["name"] = alert["title"] as? String ?? ""
            viewModelChat.selectedChat = ChatListData(jsonData: dataDict)
            showChatView = true
        }
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
