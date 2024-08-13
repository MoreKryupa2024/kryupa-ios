//
//  CareGiverNearByCustomerScreenViewModel.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 05/06/24.
//

import Foundation
@MainActor
class CareGiverNearByCustomerScreenViewModel: ObservableObject{
    @Published var serachGiver: String = String()
    @Published var isloading: Bool = true
    @Published var pagination: Bool = true
    @Published var pageNumber = 1
    @Published var careGiverNearByList: [CareGiverNearByCustomerScreenData] = [CareGiverNearByCustomerScreenData]()
    
    func getCareGiverNearByList(bookingID:String,alert: ((String)->Void)?){
        let param: [String:Any] = [
            "pageNumber":1,
            //"pageNumber":pageNumber,
            "pageSize":20,
            "booking_id":bookingID,
            "profile_id":"",
            "searchTerm":serachGiver
        ]
        NetworkManager.shared.findCareGiverBookingID(params: param) {[weak self] result in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                switch result{
                case .success(let data):
                    self?.careGiverNearByList = data.data
                    self?.isloading = false
                    if self?.careGiverNearByList.count == 0{
                        alert?("Currently, no caregivers are available nearby")
                    }
                    
                    /* if self!.pageNumber > 1{
                     self?.careGiverNearByList += data.data
                 }else{
                     self?.careGiverNearByList = data.data
                 }
                 self?.pagination = data.data.count != 0*/
                case .failure(let error):
                    print(error)
                    self?.isloading = false
                    if self?.careGiverNearByList.count == 0{
                        alert?("Currently, no caregivers are available nearby")
                    }
                }
            }
        }
    }
}
