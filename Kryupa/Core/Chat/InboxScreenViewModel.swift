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
