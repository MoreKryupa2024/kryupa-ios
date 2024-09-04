//
//  BookingViewModel.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 19/06/24.
//

import Foundation

class BookingViewModel: ObservableObject{
    @Published var bookingList = [BookingsListData]()
    @Published var selectedSection = 0
    @Published var isLoading = Bool()
    @Published var pagination: Bool = true
    @Published var pageNumber = 1
    
    func getBookings(){
        isLoading = true
        var param : [String : Any] = ["pageNumber":1,
                                      "pageSize":20]
       
        
        if Defaults().userType == AppConstants.SeekCare{
            switch selectedSection{
            case 1:
                param["status"] = "Pending"
            case 2:
                param["status"] = "Active"
            case 3:
                param["status"] = "Result"
            case 0:
                param["status"] = "Open"
            default:
                break
            }
            print(param)
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
    
    func deleteBooking(bookingId:String,alert: @escaping ((String)->Void)){
        isLoading = true
        let param = ["booking_id":bookingId]
        NetworkManager.shared.deletebooking(params: param) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result{
                case .success(_):
                    self?.getBookings()
                    alert("Draft Deleted Successfully")
                case .failure(let error):
                    alert(error.getMessage())
                }
            }
        }
    }
}
