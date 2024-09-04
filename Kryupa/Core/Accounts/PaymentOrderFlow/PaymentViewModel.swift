//
//  PaymentViewModel.swift
//  Kryupa
//
//  Created by Hemant Singh Rajput on 24/07/24.
//

import Foundation

@MainActor
class PaymentViewModel: ObservableObject{
    
    @Published var paySpecialMessageData: SpecialMessageData?
    @Published var paymentOrderData: PaymentOrderData?
    @Published var walletAmountData: WalletAmountData?
    @Published var transectionListData = [TransectionListData]()
    @Published var isloading = Bool()
    @Published var showPaypal: Bool = false
    @Published var fromPaymentFlow: Bool = false
    @Published var orderId: String = ""
    @Published var amount: String = "0.00"
    @Published var pagination: Bool = true
    @Published var pageNumber = 1
    
    func getPaymentOrderDetails(){
        
        isloading = true
        let param = ["approch_id":paySpecialMessageData?.approchId ?? ""]
        NetworkManager.shared.getOrderInvoice(params: param) { [weak self]result in
            DispatchQueue.main.async {
                guard let self else{
                    self?.isloading = false
                    return
                }
                self.isloading = false
                switch result{
                case .success(let data):
                    self.paymentOrderData = data.data
                case .failure(let error):
                    print(error.getMessage())
                }
            }
        }
    }
    
    func confrimGiverPayment(action: @escaping (()->Void)){
        
        isloading = true
        let param = ["approch_id":paySpecialMessageData?.approchId ?? ""]
        NetworkManager.shared.payCaregiverBooking(params: param) { [weak self]result in
            DispatchQueue.main.async {
                guard let self else{
                    self?.isloading = false
                    return
                }
                self.isloading = false
                switch result{
                case .success(let data):
                    self.paymentOrderData = data.data
                    action()
                case .failure(let error):
                    print(error.getMessage())
                }
            }
        }
    }
    
    func confirmPaypalOrderID(action: @escaping (()->Void)){
        let param = ["order_id":orderId]
        isloading = true
        NetworkManager.shared.confirmPaypalOrderID(params: param) { [weak self] result in
            DispatchQueue.main.async {
                guard let self else{
                    self?.isloading = false
                    return
                }
                self.isloading = false
                switch result{
                case .success(let data):
                    self.orderId = data.data.paymentOrderID
                    action()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func getPaypalOrderID(){
        let amount = (Double(amount) ?? 0).removeZerosFromEnd(num: 2)
        let param = ["amount":Double(amount) ?? 0]
        isloading = true
        NetworkManager.shared.getPaypalOrderID(params: param) { [weak self] result in
            DispatchQueue.main.async {
                guard let self else{
                    self?.isloading = false
                    return
                }
                self.isloading = false
                switch result{
                case .success(let data):
                    self.orderId = data.data.orderID
                    self.showPaypal = true
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func getWalletBalance(){
        isloading = true
        NetworkManager.shared.getWallet { [weak self] result in
            DispatchQueue.main.async {
                guard let self else{
                    self?.isloading = false
                    return
                }
                self.isloading = false
                self.getTransectionList()
                switch result{
                case .success(let data):
                    self.walletAmountData = data.data
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func getTransectionList(){
//        let param = ["pageNumber":pageNumber,
        let param = ["pageNumber":1,
                     "pageSize":20]
        isloading = true
        NetworkManager.shared.getAllTransaction(params:param) { [weak self] result in
            DispatchQueue.main.async {
                guard let self else{
                    self?.isloading = false
                    return
                }
                self.isloading = false
                switch result{
                case .success(let data):
                    /* if self.pageNumber > 1{
                     self.transectionListData += data.data
                 }else{
                     self.transectionListData = data.data
                 }
                 self.pagination = data.data.count != 0*/
                    self.transectionListData = data.data
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
