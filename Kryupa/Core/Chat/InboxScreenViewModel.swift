//
//  InboxScreenViewModel.swift
//  Kryupa
//
//  Created by Hemant Singh Rajput on 14/08/24.
//

import Foundation


class InboxScreenViewModel: ObservableObject{
    @Published var inboxList = [ChatListData]()
    @Published var isLoading = Bool()
    @Published var showChatView = Bool()
    let notificatioSetChatScreen = NotificationCenter.default
    let viewModelChat = ChatScreenViewModel()
    
    init(){
        notificatioSetChatScreen.addObserver(forName: .setChatScreen, object: nil, queue: nil,
                                             using: self.setChatScreen)
    }
    
    private func setChatScreen(_ notification: Notification){
        if let data = notification.userInfo, let dataDict = data as? [String:Any] {
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
