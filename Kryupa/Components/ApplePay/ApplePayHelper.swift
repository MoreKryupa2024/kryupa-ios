//
//  ApplePayHelper.swift
//  Kryupa
//
//  Created by Hemant Singh Rajput on 18/11/24.
//

import Foundation
import SwiftUI
import PassKit

typealias PaymentCompletionHandler = (Bool, String) -> Void

class PaymentHandler: NSObject {
    static let supportedNetworks: [PKPaymentNetwork] = [
        .amex,
        .masterCard,
        .visa
    ]
    
    var paymentController: PKPaymentAuthorizationController?
    var paymentSummaryItems = [PKPaymentSummaryItem]()
    var paymentStatus = PKPaymentAuthorizationStatus.failure
    var completionHandler: PaymentCompletionHandler?
    
    @MainActor func startPayment(amount: String, completion: @escaping PaymentCompletionHandler) {
        
//        let amount = PKPaymentSummaryItem(label: "Amount", amount: NSDecimalNumber(string: "\((viewModel.paymentOrderData?.pricePerHour ?? 0).removeZerosFromEnd(num: 2))"), type: .final)
//        let tax = PKPaymentSummaryItem(label: "Tax", amount: NSDecimalNumber(string: "2"), type: .final)
        let total = PKPaymentSummaryItem(label: "ToTal", amount: NSDecimalNumber(string: amount), type: .final)
        
//        paymentSummaryItems = [amount, tax, total];
        paymentSummaryItems = [total];

        completionHandler = completion
        
        // Create our payment request
        let paymentRequest = PKPaymentRequest()
        paymentRequest.paymentSummaryItems = paymentSummaryItems
        paymentRequest.merchantIdentifier = "merchant.Moreyeahs.com.Kryupa"
        paymentRequest.merchantCapabilities = .threeDSecure
        paymentRequest.countryCode = "US"
        paymentRequest.currencyCode = "USD"
        paymentRequest.requiredShippingContactFields = [.phoneNumber, .emailAddress]
        paymentRequest.supportedNetworks = PaymentHandler.supportedNetworks
        
        // Display our payment request
        paymentController = PKPaymentAuthorizationController(paymentRequest: paymentRequest)
        paymentController?.delegate = self
        paymentController?.present(completion: { (presented: Bool) in
            if presented {
                NSLog("Presented payment controller")
            } else {
                NSLog("Failed to present payment controller")
                self.completionHandler!(false, "")
            }
        })
    }
}

/*
 PKPaymentAuthorizationControllerDelegate conformance.
 */
extension PaymentHandler: PKPaymentAuthorizationControllerDelegate {
    
    func paymentAuthorizationController(_ controller: PKPaymentAuthorizationController, didAuthorizePayment payment: PKPayment, completion: @escaping (PKPaymentAuthorizationStatus) -> Void) {
        
        // Perform some very basic validation on the provided contact information
        if payment.shippingContact?.emailAddress == nil || payment.shippingContact?.phoneNumber == nil {
            paymentStatus = .failure
        } else {
            // Here you would send the payment token to your server or payment provider to process
            // Once processed, return an appropriate status in the completion handler (success, failure, etc)
            print(payment.token)
            paymentStatus = .success
            DispatchQueue.main.async {
                if self.paymentStatus == .success {
                    self.completionHandler!(true, payment.token.transactionIdentifier)
                } else {
                    self.completionHandler!(false, "")
                }
            }
        }
        
        completion(paymentStatus)
    }
    
    func paymentAuthorizationControllerDidFinish(_ controller: PKPaymentAuthorizationController) {
        controller.dismiss {
            DispatchQueue.main.async {
//                if self.paymentStatus == .success {
//                    self.completionHandler!(true)
//                } else {
//                    self.completionHandler!(false)
//                }
            }
        }
    }
    
}
