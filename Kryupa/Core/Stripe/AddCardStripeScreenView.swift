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

    var paymentIntentClientSecret: String?
    @StateObject var viewModel = AddCardStripeScreenViewModel()
    
    init(){
        StripeAPI.defaultPublishableKey = "pk_test_51QAAWBK8WBOXOCFNsADeGxnj0uC5mIKHuKiGrHYsyeNsAwNhaSr66pXXa462QK3AyQbOONJ69s47mvsHw4S025Ry00RaT9xX8K"
    }
    
    var body: some View {
        ZStack{
            VStack(spacing:0){
                HeaderView(showBackButton: true)
                
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
                        viewModel.saveCard(paymentIntentClientSecret: paymentIntentClientSecret)
                    }
                Spacer()
            }
            .toolbar(.hidden, for: .navigationBar)
            
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
