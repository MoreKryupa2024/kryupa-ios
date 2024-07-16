//
//  PayPalView.swift
//  Kryupa
//
//  Created by Hemant Singh Rajput on 11/07/24.
//

import Foundation
import SwiftUI
import PayPalWebPayments
import CorePayments

struct PaypalScreenView: UIViewControllerRepresentable {
    
    var vc = PaypalViewController()
    var orderId = "JWT"
    var payPal: (_ payPalClient: PayPalWebPayments.PayPalWebCheckoutClient, _ result: PayPalWebPayments.PayPalWebCheckoutResult) -> Void
    var payPalError: (_ payPalClient: PayPalWebPayments.PayPalWebCheckoutClient,_ error: CorePayments.CoreSDKError) -> Void
    var payPalDidCancel: (_ payPalClient: PayPalWebPayments.PayPalWebCheckoutClient) -> Void
    
    
    typealias UIViewControllerType = UIViewController
    
    func makeUIViewController(context: Context) -> UIViewController {
        // Return MyViewController instance
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // Updates the state of the specified view controller with new information from SwiftUI.
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(vc: self.vc,
                    orderId: self.orderId,
                    payPal: self.payPal,
                    payPalError: self.payPalError,
                    payPalDidCancel: self.payPalDidCancel)
    }
    
    class Coordinator: NSObject, PayPalWebCheckoutDelegate {
       
        var payPals: (_ payPalClient: PayPalWebPayments.PayPalWebCheckoutClient, _ result: PayPalWebPayments.PayPalWebCheckoutResult) -> Void
        var payPalErrors: (_ payPalClient: PayPalWebPayments.PayPalWebCheckoutClient,_ error: CorePayments.CoreSDKError) -> Void
        var payPalDidCancels: (_ payPalClient: PayPalWebPayments.PayPalWebCheckoutClient) -> Void
       
        init(vc: PaypalViewController, 
             orderId: String,
             payPal: @escaping (PayPalWebPayments.PayPalWebCheckoutClient, PayPalWebPayments.PayPalWebCheckoutResult)-> Void,
             payPalError: @escaping (PayPalWebPayments.PayPalWebCheckoutClient, CorePayments.CoreSDKError)-> Void,
             payPalDidCancel: @escaping (PayPalWebPayments.PayPalWebCheckoutClient)-> Void)
        {
            self.payPals = payPal
            self.payPalErrors = payPalError
            self.payPalDidCancels = payPalDidCancel
            super.init()
            vc.delegate = self
            vc.orderId = orderId
        }
        
        func payPal(_ payPalClient: PayPalWebPayments.PayPalWebCheckoutClient, didFinishWithResult result: PayPalWebPayments.PayPalWebCheckoutResult) {
            self.payPals(payPalClient, result)
        }
        
        func payPal(_ payPalClient: PayPalWebPayments.PayPalWebCheckoutClient, didFinishWithError error: CorePayments.CoreSDKError) {
            self.payPalErrors(payPalClient, error)
        }
        
        func payPalDidCancel(_ payPalClient: PayPalWebPayments.PayPalWebCheckoutClient) {
            self.payPalDidCancels(payPalClient)
        }
    }
}

class PaypalViewController: UIViewController {
    
    let payPalClient = PayPalWebCheckoutClient(config: AppConstants.config)
    var delegate: PayPalWebCheckoutDelegate?
    var orderId = "JWT"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        present()
    }
    
    
    func present(){
        payPalClient.delegate = delegate
        let payPalWebRequest = PayPalWebCheckoutRequest(orderID: orderId, fundingSource: .paypal)
        payPalClient.start(request: payPalWebRequest)
    }
}
