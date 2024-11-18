//
//  ApplePayViewModel.swift
//  Kryupa
//
//  Created by Hemant Singh Rajput on 18/11/24.
//

import Foundation

class ApplePayViewModel: ObservableObject{
    
    @Published var isloading = Bool()

    func setApplePayTransactionID(transactionID: String, completionHandler: @escaping ((Bool)->Void)){
        let param = ["request_id":transactionID, "status": "TRUE"]
        isloading = true
        NetworkManager.shared.setApplePayTransactionStatus(params: param) { [weak self] result in
            DispatchQueue.main.async {
                guard let self else{
                    self?.isloading = false
                    return
                }
                self.isloading = false
                switch result{
                case .success(let data):
                    if data.success {
                        completionHandler(true)
                    }
                    else {
                        completionHandler(false)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    completionHandler(false)
                }
            }
        }
    }
}
