//
//  ServiceDetailScreenViewModel.swift
//  Kryupa
//
//  Created by Hemant Singh Rajput on 08/08/24.
//

import Foundation
class ServiceDetailScreenViewModel: ObservableObject{
    
    @Published var isloading: Bool = Bool()
    @Published var bookingsListData: BookingsListData?
    
    func cancelBookingData(){
        
        let param: [String : Any] = ["approch_id":bookingsListData?.id ?? ""]
        
        isloading = true
        NetworkManager.shared.cancelBookingData(params: param) { [weak self] result in
            
            DispatchQueue.main.async() {
                switch result{
                case .success(let data):
                    self?.isloading = false
                case .failure(let error):
                    self?.isloading = false
                    print(error)
                }
            }
        }
    }
}
