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
    
    func saveCard(paymentIntentClientSecret: String?){
        guard let clientSecret = paymentIntentClientSecret else {
            return
        }
        
        let setupIntentParams = STPSetupIntentConfirmParams(clientSecret: clientSecret)
        setupIntentParams.paymentMethodParams = paymentMethodParams
        
        paymentGatewayController.confirmSetupIntent(intent: setupIntentParams) { status, intent, error in
            switch status{
            case .succeeded:
                let paymentMethodId = intent?.paymentMethodID ?? ""
                self.sendPaymentMethodId(paymentMethodId: paymentMethodId)
            case .failed:
                print(intent?.paymentMethodID)
            case .canceled:
                print(intent?.paymentMethodID)
            }
        }
    }
    
    private func sendPaymentMethodId(paymentMethodId: String){
        isLoading = true
        let param:[String : Any] = ["paymentMethodId":paymentMethodId]
        NetworkManager.shared.sendPaymentMethodId(params: param, completionHandler: { result in

        })
    }
}
