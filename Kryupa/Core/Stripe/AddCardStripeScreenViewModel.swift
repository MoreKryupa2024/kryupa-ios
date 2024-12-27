//
//  AddCardStripeScreenViewModel.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 08/11/24.
//

import Foundation
import Stripe

class AddCardStripeScreenViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var paymentMethodParams: STPPaymentMethodParams?
    private let paymentGatewayController = PaymentGatewayController()
    private var paymentIntentClientSecret: StripeClientSecretDataModel?
    private var stripeCustomerDataModel: StripeCustomerDataModel?
    var stripeCardList = [StripeCardListData]()
    private var paymentMethodId: String = ""
    var amount: String = ""
    @Published var amountAdded = false
    
    init(){
        StripeAPI.defaultPublishableKey = "pk_test_51QAAWBK8WBOXOCFNsADeGxnj0uC5mIKHuKiGrHYsyeNsAwNhaSr66pXXa462QK3AyQbOONJ69s47mvsHw4S025Ry00RaT9xX8K"
    }
    
    private func saveCard(alert:@escaping (String) -> Void?){
        
        guard let clientSecret = paymentIntentClientSecret?.clientSecret else {
            return
        }
        
        let setupIntentParams = STPSetupIntentConfirmParams(clientSecret: clientSecret)
        setupIntentParams.paymentMethodParams = paymentMethodParams
        
        paymentGatewayController.confirmSetupIntent(intent: setupIntentParams) { status, intent, error in
            switch status{
            case .succeeded:
                self.paymentMethodId = intent?.paymentMethodID ?? ""
                self.stripeCreateCustomer(alert: alert)
            case .failed:
                print(error)
                self.isLoading = false
                print(intent?.paymentMethodID)
            case .canceled:
                print(error)
                self.isLoading = false
                print(intent?.paymentMethodID)
            }
        }
    }
    
    private func stripeCreateCustomer(alert:@escaping (String) -> Void?){
        guard let clientSecret = paymentIntentClientSecret?.clientSecret else {
            return
        }
        let param:[String : Any] = ["paymentMethodId":paymentMethodId,"lastfour":paymentMethodParams?.card?.number?.suffix(4) ?? "","client_secret":clientSecret]
        NetworkManager.shared.stripeCreateCustomer(params: param, completionHandler: { [weak self] result in
            DispatchQueue.main.async {
                switch result{
                case .success(let data):
                    self?.stripeCustomerDataModel = data.data
                    self?.stripeCharge(paymentMethodId:self?.paymentMethodId ?? "",
                                       stripeCustomerId:self?.stripeCustomerDataModel?.id ?? "",
                                       amount:self?.amount ?? "")
                case .failure(let error):
                    self?.isLoading = false
                    print(error.getMessage())
                    alert(error.getMessage())
                }
            }
        })
    }
    
    func stripeCreateSetupIntent(amount:String,alert:@escaping (String) -> Void?){
        self.amount = amount
        isLoading = true
        NetworkManager.shared.stripeCreateSetupIntent(params: nil, completionHandler: { [weak self] result in
            DispatchQueue.main.async {
                switch result{
                case .success(let data):
                    self?.paymentIntentClientSecret = data.data
                    self?.saveCard(alert: alert)
                case .failure(let error):
                    self?.isLoading = false
                    print(error)
                }
            }
        })
    }
    
    func stripeCharge(paymentMethodId:String,stripeCustomerId: String,amount: String){
        isLoading = true
        let param:[String : Any] = ["paymentMethodId":paymentMethodId,
                                    "StripeCustomerId":stripeCustomerId,
                                    "amount":Double(amount) ?? 0.0]
        NetworkManager.shared.stripeCharge(params: param, completionHandler: { [weak self] result in
            DispatchQueue.main.async {
                switch result{
                case .success(let data):
                    self?.isLoading = false
                    self?.amountAdded = true
                case .failure(let error):
                    self?.isLoading = false
                    print(error)
                }
            }
        })
    }
    
    func getCardList(){
        isLoading = true
        NetworkManager.shared.stripeCardList(completionHandler: { [weak self] result in
            DispatchQueue.main.async {
                switch result{
                case .success(let data):
                    self?.isLoading = false
                    self?.stripeCardList = data.data
                case .failure(let error):
                    self?.isLoading = false
                    print(error)
                }
            }
        })
    }
    
    func deleteCard(stripeCardListData:StripeCardListData){
        let param = ["id":stripeCardListData.id,"lastFour":stripeCardListData.lastfour]
        
        isLoading = true
        NetworkManager.shared.deleteStripeCard(params: param,completionHandler: { [weak self] result in
            DispatchQueue.main.async {
                switch result{
                case .success(let data):
                    self?.isLoading = false
                    self?.getCardList()
                case .failure(let error):
                    self?.isLoading = false
                    print(error)
                }
            }
        })
    }
}
