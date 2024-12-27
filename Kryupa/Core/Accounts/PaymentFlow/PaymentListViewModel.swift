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
    @Published var fullName: String = ""
    @Published var ssnNumber: String = ""
    @Published var typeAccount: String = ""
    @Published var routingNumber: String = ""
    @Published var accountNumber: String = ""
    @Published var bankListData = [BankListData]()
    @Published var selectedbankData: BankListData?
    @Published var orderListData = [OrderListData]()
    @Published var isloading: Bool = false
    @Published var walletAmountData: WalletAmountData?
    @Published var amount: String = "0.00"
    
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
    
    func getOrderList(){
//        //        let param = ["pageNumber":pageNumber,
        let param = ["pageNumber":1,
                     "pageSize":20]
        
        isloading = true
        NetworkManager.shared.getOrderList(params: param) { [weak self] result in
            DispatchQueue.main.async() {
                self?.isloading = false
                switch result{
                case .success(let data):
                    self?.orderListData = data.data
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func AddBankAccount(errorAction: @escaping (String) -> Void){
        
        let param = ["account_holder_name":fullName,
                     "account_holder_type":typeAccount.lowercased(),
                     "routing_number":routingNumber,
                     "account_number":accountNumber,
                     "currency":"usd",
                     "country":"US",
                     "object":"bank_account"]
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
                    self.routingNumber = ""
                    self.fullName = ""
                    self.ssnNumber = ""
                    self.accountNumber = ""
                    self.showAddBankView = false
                    self.getBankList()
                case .failure(let error):
                    print(error.localizedDescription)
                    errorAction(error.getMessage())
                }
            }
        }
    }
    
    
    func withdrawToStripeAccount(successAction:(()->Void)?,errorAction:((String)->Void)?){
        guard let selectedbankData else{
            return
        }
        let param:[String:Any] = ["amount":Int(self.amount) ?? 0,
                                  "currency":"usd",
                                  "destination":selectedbankData.stripeBankNo,
                                  "description":"\(amount) USD has been withdrawn",
                                  "stripeAccount":selectedbankData.stripACNo]
        isloading = true
        NetworkManager.shared.transferAmountToStripe(params:param) { [weak self] result in
            DispatchQueue.main.async {
                guard let self else{
                    self?.isloading = false
                    return
                }
                self.isloading = false
                switch result{
                case .success(_):
                    self.withdrawToBankAccount(param: param, successAction: successAction, errorAction: errorAction)
                case .failure(let error):
                    errorAction?(error.getMessage())
                }
            }
        }
    }
    
    private func withdrawToBankAccount(param:[String:Any],successAction:(()->Void)?,errorAction:((String)->Void)?){
        isloading = true
        NetworkManager.shared.transferAmountToAccount(params:param) { [weak self] result in
            DispatchQueue.main.async {
                guard let self else{
                    self?.isloading = false
                    return
                }
                self.isloading = false
                switch result{
                case .success(_):
                    successAction?()
                case .failure(let error):
                    print(error.localizedDescription)
                    errorAction?(error.getMessage())
                }
            }
        }
    }

}
