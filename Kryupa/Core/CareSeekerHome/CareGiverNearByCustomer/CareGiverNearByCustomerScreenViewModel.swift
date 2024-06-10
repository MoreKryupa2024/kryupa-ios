//
//  CareGiverNearByCustomerScreenViewModel.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 05/06/24.
//

import Foundation

class CareGiverNearByCustomerScreenViewModel: ObservableObject{
    @Published var serachGiver: String = String()
    @Published var isloading: Bool = true
    @Published var careGiverNearByList: [CareGiverNearByCustomerScreenData] = [CareGiverNearByCustomerScreenData]()
    
    func getCareGiverNearByList(bookingID:String){
        let param: [String:Any] = [
            "pageNumber":1,
            "pageSize":10,
            "booking_id":bookingID,
            "profile_id":"",
            "searchTerm":serachGiver
        ]
        NetworkManager.shared.findCareGiverBookingID(params: param) {[weak self] result in
            switch result{
            case .success(let data):
                self?.careGiverNearByList = data.data
                self?.isloading = false
            case .failure(let error):
                print(error)
                self?.isloading = false
            }
        }
    }
}
