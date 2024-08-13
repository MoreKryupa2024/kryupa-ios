//
//  ServiceDetailScreenViewModel.swift
//  Kryupa
//
//  Created by Hemant Singh Rajput on 08/08/24.
//

import Foundation
class ServiceDetailScreenViewModel: ObservableObject{
    @Published var review: String = ""
    @Published var rating: Int = 0
    @Published var isloading: Bool = Bool()
    @Published var bookingsListData: BookingsListData?
    @Published var cancelSeriveDetailData: CancelSeriveDetailData?
    @Published var selectedReason: String = String()
    @Published var selectedReasonTwo: String = String()
    @Published var reasonDescription: String = String()
    
    func cancelBookingData(){
        
        let param: [String : Any] = ["approch_id":bookingsListData?.id ?? ""]
        
        isloading = true
        NetworkManager.shared.cancelBookingData(params: param) { [weak self] result in
            
            DispatchQueue.main.async() {
                self?.isloading = false
                switch result{
                case .success(let data):
                    self?.cancelSeriveDetailData = data.data
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func addReview(){
        
        let param: [String : Any] = ["approchId":bookingsListData?.id ?? "",
                     "review":review,
                     "rating":rating]
        
        isloading = true
        NetworkManager.shared.addReview(params: param) { [weak self] result in
            
            DispatchQueue.main.async() {
                switch result{
                case .success(_):
                    self?.isloading = false
                case .failure(let error):
                    self?.isloading = false
                    print(error)
                }
            }
            
        }
    }
    
    func bookingCancel(alert:@escaping((String)->Void), action:@escaping (()->Void)){
        if selectedReason.isEmpty{
            alert("Please Select Reason Type.")
            return
        }else if selectedReasonTwo.isEmpty && selectedReason == "Other"{
            alert("Please Enter Other Reason.")
            return
        }else if reasonDescription.isEmpty{
            alert("Please Enter Reason Description.")
            return
        }
        let param: [String : Any] = ["approch_id":bookingsListData?.id ?? "",
                                     "booking_id":bookingsListData?.bookingID ?? "",
                                     "description":reasonDescription,
                                     "reason1":selectedReason,
                                     "reason2":selectedReasonTwo]
        
        isloading = true
        NetworkManager.shared.bookingCancel(params: param) { [weak self] result in
            
            DispatchQueue.main.async() {
                self?.isloading = false
                switch result{
                case .success(let data):
                    action()
                case .failure(let error):
                    print(error)
                    alert(error.getMessage())
                }
            }
        }
    }
    
    func getReview(){
        
        let param: [String : Any] = ["approchId":bookingsListData?.id ?? ""]
        
        isloading = true
        NetworkManager.shared.getBookingReview(params: param) { [weak self] result in
            
            DispatchQueue.main.async() {
                switch result{
                case .success(let data):
                    self?.isloading = false
                    self?.rating = data.data.rating
                    self?.review = data.data.review
                case .failure(let error):
                    self?.isloading = false
                    print(error)
                }
            }
            
        }
    }
}
