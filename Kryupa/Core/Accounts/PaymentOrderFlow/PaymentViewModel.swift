//
//  PaymentViewModel.swift
//  Kryupa
//
//  Created by Hemant Singh Rajput on 24/07/24.
//

import Foundation


class PaymentViewModel: ObservableObject{
    
    @Published var paySpecialMessageData: SpecialMessageData?
    @Published var paymentOrderData: PaymentOrderData?
    @Published var isloading = Bool()
    @Published var showPaypal: Bool = false
    @Published var orderId: String = ""
    
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
    
    func getPaypalOrderID(){
        let param = ["approch_id":paySpecialMessageData?.approchId ?? ""]
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
                    self.orderId = data.data.paymentOrderID
                    self.showPaypal = true
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
