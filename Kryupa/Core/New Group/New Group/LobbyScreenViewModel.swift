//
//  LobbyScreenViewModel.swift
//  Kryupa
//
//  Created by Hemant Singh Rajput on 11/06/24.
//

import Foundation

class LobbyScreenViewModel: ObservableObject{
 
    @Published var isloading: Bool = Bool()
    
    func getLobbyStatus(){
        isloading = true
        NetworkManager.shared.getLobbyStatus() { [weak self] result in
            switch result{
            case.failure(let error):
                print(error)
                self?.isloading = false
            case .success(let data):
                self?.isloading = false
            }
        }
    }
    
    func bookSlot(id: String){
        let param = ["slotId":id]
        NetworkManager.shared.bookSlot(params: param, completionHandler: { result in
            switch result{
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error)
            }
        })
    }

    
}
