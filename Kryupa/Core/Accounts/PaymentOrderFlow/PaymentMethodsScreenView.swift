//
//  PaymentMethodsScreenView.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 16/07/24.
//

import SwiftUI
import SwiftfulUI

struct PaymentMethodsScreenView: View {
    
    @Environment(\.router) var router
    @StateObject var viewModel = PaymentViewModel()
    let paymentHandler = PaymentHandler()
    
    @State var showCardListScreen = false
    @State var showMoneyAddedScreen = false
    @State var showPaymentConfirmScreen = false
    
    var paymentConfirmAction: (()->Void)? = nil
    var backAction: (()->Void)? = nil
    
    var body: some View {
        ZStack{
            VStack{
                HeaderViewWithRouter(title: "Payment", showBackButton: true) {
                    backAction?()
                }
                VStack(spacing:15){
                    if viewModel.showNudgeText {
                        Group {
                            Text("To proceed, add ")
                                .font(.custom(FontContent.plusRegular, size: 14))
                            +
                            Text("$\(viewModel.amount)")
                                .font(.custom(FontContent.plusBold, size: 14))
                            +
                            Text(" to your wallet.")
                                .font(.custom(FontContent.plusRegular, size: 14))
                        }
                        .padding(.horizontal,24)
                        
                        Text("This amount will be stored and only deducted when the service starts. \n\n(2% platform fee will apply at the time of booking)")
                            .padding(.horizontal,24)
                            .font(.custom(FontContent.plusRegular, size: 12))
                    }
                    PaypalView
                        .asButton(.press) {
                            viewModel.getPaypalOrderID()
                        }
                    StripeView
                        .asButton(.press) {
                            self.showCardListScreen = true
                        }
                    
                    ApplePayView
                        .asButton(.press) {
                            self.paymentHandler.startPayment(amount: viewModel.amount) { (success, token) in
                                if success {
                                    print(token)
                                    self.viewModel.applePayPaymentConfirm(transactionID: token)
                                    self.showMoneyAddedScreen = true
                                }else{
                                    self.presentAlert(title: "Kryupa", subTitle: token)
                                }
                            }
                        }
                    Spacer()
                }
                
            }
            
            if showCardListScreen{
                CardListScreenView(viewPaymentViewModel: viewModel) {
                    self.showMoneyAddedScreen = true
                } backAction: {
                    showCardListScreen = false
                }
                .background(.white)
            }
            
            if showMoneyAddedScreen{
                MoneyAddedScreenView(viewModel: viewModel,paymentConfirmAction: {
                    self.showMoneyAddedScreen = false
                    paymentConfirmAction?()
                })
                .background(.white)
            }
            
            if showPaymentConfirmScreen{
                PaymentConfirmScreenView(paymentConfirmAction: {
                    paymentConfirmAction?()
                }, viewModel: viewModel)
                    .background(.white)
            }
            
            if viewModel.isloading {
                LoadingView()
            }
            
            if viewModel.showPaypal {
                PaypalScreenView(orderId: self.viewModel.orderId) { payPalClient, result in
                    print("Paypal Payment Success")
                    viewModel.showPaypal = false
                    print(payPalClient)
                    print(result)
                    viewModel.confirmPaypalOrderID() {
                        if viewModel.fromPaymentFlow{
                            self.showPaymentConfirmScreen = true
                        }else{
                            self.showMoneyAddedScreen = true
                        }
                    }
                } payPalError: { payPalClient, error in
                    print(payPalClient)
                    print(error)
                    viewModel.showPaypal = false
                    print("Paypal Payment Send Error")
                } payPalDidCancel: { payPalClient in
                    viewModel.showPaypal = false
                    print("Paypal Payment Cancel")
                }
            }
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
    private var PaypalView: some View{
        HStack(spacing:20){
            Image("Paypal")
                .resizable()
                .frame(width: 21,height: 25)
            Text("Continue With Paypal")
                .font(.custom(FontContent.plusRegular, size: 15))
        }
        .frame(maxWidth: .infinity)
        .frame(height: 48)
        .overlay {
            RoundedRectangle(cornerRadius: 24)
                .stroke(lineWidth: 1.0)
                .foregroundStyle(.E_5_E_5_EA)
                
        }
        .padding(.horizontal,24)
    }
    
    private var VenmoView: some View{
        HStack(spacing:20){
            Image("Venmo")
                .resizable()
                .frame(width: 25,height: 25)
            Text("Continue With Venmo")
                .font(.custom(FontContent.plusRegular, size: 15))
        }
        .frame(maxWidth: .infinity)
        .frame(height: 48)
        .overlay {
            RoundedRectangle(cornerRadius: 24)
                .stroke(lineWidth: 1.0)
                .foregroundStyle(.E_5_E_5_EA)
                
        }
        .padding(.horizontal,24)
    }
    
    private var StripeView: some View{
        HStack(spacing:20){
            Image("Stripe")
                .resizable()
                .frame(width: 50,height: 35)
            Text("Continue With Stripe")
                .font(.custom(FontContent.plusRegular, size: 15))
        }
        .frame(maxWidth: .infinity)
        .frame(height: 48)
        .overlay {
            RoundedRectangle(cornerRadius: 24)
                .stroke(lineWidth: 1.0)
                .foregroundStyle(.E_5_E_5_EA)
                
        }
        .padding(.horizontal,24)
    }
    
    private var ApplePayView: some View{
        HStack(spacing:20){
            Image("ApplePay")
                .resizable()
                .frame(width: 35,height: 35)
            Text("Continue With Apple Pay")
                .font(.custom(FontContent.plusRegular, size: 15))
        }
        .frame(maxWidth: .infinity)
        .frame(height: 48)
        .overlay {
            RoundedRectangle(cornerRadius: 24)
                .stroke(lineWidth: 1.0)
                .foregroundStyle(.E_5_E_5_EA)
        }
        .padding(.horizontal,24)
    }
    
    private var ZelleView: some View{
        HStack(spacing:20){
            Image("Zelle")
                .resizable()
                .frame(width: 39,height: 25)
            Text("Continue With Zelle")
                .font(.custom(FontContent.plusRegular, size: 15))
        }
        .frame(maxWidth: .infinity)
        .frame(height: 48)
        .overlay {
            RoundedRectangle(cornerRadius: 24)
                .stroke(lineWidth: 1.0)
                .foregroundStyle(.E_5_E_5_EA)
                
        }
        .padding(.horizontal,24)
    }
}

#Preview {
    PaymentMethodsScreenView()
}
