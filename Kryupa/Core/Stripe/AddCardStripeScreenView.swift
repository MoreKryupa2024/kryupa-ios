//
//  AddCardStripeScreenView.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 08/11/24.
//

import SwiftUI
import Stripe
import SwiftfulUI

struct AddCardStripeScreenView: View {
    
    @Environment(\.router) var router
    @StateObject var viewPaymentViewModel = PaymentViewModel()
    @StateObject var viewModel = AddCardStripeScreenViewModel()
    var moneyAddedAction: (()->Void)? = nil
    var backAction: (()->Void)? = nil
    
    var body: some View {
        ZStack{
            VStack(spacing:0){
                HeaderViewWithRouter(showBackButton: true) {
                    backAction?()
                }
                
                Text("Add Card Details")
                    .font(.custom(FontContent.besMedium, size: 20))
                    .padding(.top,30)
                
                Text("Your card will be saved for further transaction on Kryupa. Note: All payments will be deducted at the end of service")
                    .font(.custom(FontContent.plusRegular, size: 15))
                    .padding(.horizontal,24)
                    .padding(.top,10)
                
                STPPaymentCardTextField.Representable(paymentMethodParams: $viewModel.paymentMethodParams)
                    .padding(.horizontal,24)
                    .padding([.top,.bottom],30)
                
                
                SaveButton
                    .asButton(.press) {
                        viewModel.stripeCreateSetupIntent(amount: viewPaymentViewModel.amount) { errorStr in
                            presentAlert(title: "Kryupa", subTitle: errorStr)
                        }
                    }
                Spacer()
            }
            .toolbar(.hidden, for: .navigationBar)
            .onChange(of: viewModel.amountAdded) { oldValue, newValue in
                if viewModel.amountAdded{
                    moneyAddedAction?()
                }
            }
            
            if viewModel.isLoading{
                LoadingView()
            }
        }
    }
    
    private var SaveButton: some View {
        Text("Add & Save Card Details")
            .font(.custom(FontContent.plusRegular, size: 16))
            .foregroundStyle(.white)
            .frame(height: 53)
            .frame(width: 256)
            .background{
                RoundedRectangle(cornerRadius: 48)
            }
    }
}

#Preview {
    AddCardStripeScreenView()
}
