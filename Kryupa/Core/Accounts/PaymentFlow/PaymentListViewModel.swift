//
//  PaymentListViewModel.swift
//  Kryupa
//
//  Created by Pooja Nenava on 11/06/24.
//

import Foundation

class PaymentListViewModel: ObservableObject{
    
    @Published var paymentMethodSelected = 0
    @Published var paymentMethodList = [0,1,2]
    @Published var selectedPaymentMethod: Int = 0
    @Published var selectedSection = 0
    @Published var showAddBankView = false
    @Published var bankName: String = ""
    @Published var routingNumber: String = ""
    @Published var accountNumber: String = ""
    @Published var bankListData = [BankListData]()
    @Published var isloading: Bool = false
    
    func getBankList(){
        isloading = true
        NetworkManager.shared.getBankList { [weak self] result in
            DispatchQueue.main.async {
                guard let self else{
                    self?.isloading = false
                    return
                }
                self.isloading = false
                switch result{
                case .success(let data):
                    self.bankListData = data.data
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func AddBankAccount(){
        
        let param = ["routing_number":routingNumber,
                     "account_number":accountNumber,
                     "bank_name":bankName]
        isloading = true
        NetworkManager.shared.addBank(params:param) { [weak self] result in
            DispatchQueue.main.async {
                guard let self else{
                    self?.isloading = false
                    return
                }
                self.isloading = false
                switch result{
                case .success(_):
                    self.showAddBankView = false
                    self.getBankList()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }

}
