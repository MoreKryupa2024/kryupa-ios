//
//  RecommendedCareGiverDetailScreenViewModel.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 06/06/24.
//

import Foundation

class RecommendedCareGiverDetailScreenViewModel: ObservableObject{
    
    var options: [String] = ["Summary","Reviews"]
    @Published var selection: String = "Summary"
    @Published var amount: String = ""
    @Published var isloading: Bool = true
    @Published var isRecommended: Bool = false
    @Published var isNormalBooking: Bool = false
    @Published var giverDetail: CareGiverDetailData?
    @Published var walletAmountData: WalletAmountData?
    @Published var chatData: ChatListData?
    let notificatioSsetBookingId = NotificationCenter.default
    
    init(){
        notificatioSsetBookingId.addObserver(forName: .setBookingId, object: nil, queue: nil,
                                                     using: self.setBookingIds)
    }
    
    private func setBookingIds(_ notification: Notification) {
        if let bookingid = notification.userInfo?["bookingId"] as? String {
            isRecommended = false
            sendRequestForBookCaregiver(bookingId: bookingid)
        }
    }
    
    func getWalletBalance(){
        NetworkManager.shared.getWallet { [weak self] result in
            DispatchQueue.main.async {
                guard let self else{
                    self?.isloading = false
                    return
                }
                self.isloading = false
                switch result{
                case .success(let data):
                    self.walletAmountData = data.data
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func getCardVerificationDetails(action:(@escaping(Bool)->Void)){
        isloading = true
        NetworkManager.shared.getCardVerificationDetails { result in
            DispatchQueue.main.async {
                self.isloading = false
                switch result{
                case .success(let data):
                    if data.status {
                        action(true)
                    }
                    else{
                        action(false)
                    }
                case .failure(let error):
                    print(error)
                    action(false)
                }
            }
        }
    }
    
    func setCardVerificationDetails(){
        isloading = true
        NetworkManager.shared.setCardVerificationDetails { result in
            DispatchQueue.main.async {
                self.isloading = false
                switch result{
                case .success(let data):
                    print(data)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func getCareGiverDetails(giverId:String,bookingId:String){
        isloading = true
        NetworkManager.shared.getCareGiverDetails(giverId: giverId,bookingId: bookingId) { [weak self] result in
            DispatchQueue.main.async {
                switch result{
                case .success(let data):
                    self?.giverDetail = data.data
                    self?.getWalletBalance()
                case .failure(let error):
                    self?.isloading = false
                    print(error)
                }
            }
        }
    }
    
    func sendRequestForBookCaregiver(bookingId: String){
        let param = ["caregiver_id":giverDetail?.id ?? "",
                     "booking_id":bookingId]
        isloading = true
        NetworkManager.shared.sendRequestForBookCaregiver(params:param) { [weak self] result in
            DispatchQueue.main.async {
                self?.isloading = false
                switch result{
                case .success(_):
                    print()
                    self?.giverDetail?.showBookNow = false
                    self?.isRecommended = false
                case .failure(let error):
                    print(error.getMessage())
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
