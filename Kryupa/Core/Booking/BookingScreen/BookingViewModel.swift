//
//  BookingViewModel.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 19/06/24.
//

import Foundation

@MainActor
class BookingViewModel: ObservableObject{
    @Published var bookingList = [BookingsListData]()
    @Published var selectedSection = 0
    @Published var isLoading = Bool()
    @Published var pagination: Bool = true
    @Published var pageNumber = 1
    
    func getBookings(){
        bookingList = []
        isLoading = true
        //var param : [String : Any] = ["pageNumber":pageNumber,
        var param : [String : Any] = ["pageNumber":1,
                                      "pageSize":20]
       
        
        if Defaults().userType == AppConstants.SeekCare{
            switch selectedSection{
            case 1:
                param["status"] = "Active"
            case 2:
                param["status"] = "Completed"
            case 3:
                param["status"] = "Cancelled"
            case 0:
                param["status"] = "Open"
            default:
                break
            }
            NetworkManager.shared.getBookings(params: param) { [weak self] result in
                
                DispatchQueue.main.async {
                    self?.isLoading = false
                    switch result{
                    case .success(let data):
                        self?.bookingList = data.data
                        /* if self!.pageNumber > 1{
                         self?.bookingList += data.data
                     }else{
                         self?.bookingList = data.data
                     }
                     self?.pagination = data.data.count != 0*/
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        }else{
            switch selectedSection{
            case 0:
                param["status"] = "Active"
            case 1:
                param["status"] = "Completed"
            case 2:
                param["status"] = "Cancelled"
            default:
                break
            }
            NetworkManager.shared.getCareGiverBookings(params: param) { [weak self] result in
                DispatchQueue.main.async {
                    self?.isLoading = false
                    switch result{
                    case .success(let data):
                        self?.bookingList = data.data
                        /* if self!.pageNumber > 1{
                         self?.bookingList += data.data
                     }else{
                         self?.bookingList = data.data
                     }
                     self?.pagination = data.data.count != 0*/
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        }
    }
}
