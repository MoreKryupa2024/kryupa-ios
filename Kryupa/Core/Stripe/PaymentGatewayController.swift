//
//  PaymentGatewayController.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 08/11/24.
//


import Foundation
import Stripe
import UIKit


class PaymentGatewayController: UIViewController {
    
    func confirmSetupIntent(intent:STPSetupIntentConfirmParams, completion: @escaping(STPPaymentHandlerActionStatus, STPSetupIntent?, NSError?)-> Void){
        let paymentHandler = STPPaymentHandler.shared()
        
        paymentHandler.confirmSetupIntent(intent, with: self) { status, intent, error in
            completion(status, intent, error)
        }
    }
}

extension PaymentGatewayController: STPAuthenticationContext{
    func authenticationPresentingViewController()-> UIViewController{
        return self
    }
}
