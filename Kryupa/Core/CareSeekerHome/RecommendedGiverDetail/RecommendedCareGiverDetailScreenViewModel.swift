//
//  RecommendedCareGiverDetailScreenViewModel.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 06/06/24.
//

import Foundation
@MainActor
class RecommendedCareGiverDetailScreenViewModel: ObservableObject{
    
    var options: [String] = ["Summary","Review"]
    @Published var selection: String = "Summary"
    @Published var isloading: Bool = true
    @Published var isRecommended: Bool = false
    @Published var isNormalBooking: Bool = false
    @Published var giverDetail: CareGiverDetailData?
    @Published var chatData: ChatListData?
    
    
    func getCareGiverDetails(giverId:String){
        isloading = true
        NetworkManager.shared.getCareGiverDetails(giverId: giverId) { [weak self] result in
            DispatchQueue.main.async {
                self?.isloading = false
                switch result{
                case .success(let data):
                    self?.giverDetail = data.data
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func createConversation(giverId:String,bookingId:String,action:(@escaping()->Void),alert: ((String)->Void)?){
        let param = ["caregiver_id":giverId,
                     "booking_id":bookingId]
        isloading = true
        NetworkManager.shared.createConversation(params:param) { [weak self] result in
            DispatchQueue.main.async {
                self?.isloading = false
                switch result{
                case .success(let data):
                    self?.chatData = data.data
                    action()
                case .failure(let error):
                    alert?(error.getMessage())
                }
            }
        }
    }
}
