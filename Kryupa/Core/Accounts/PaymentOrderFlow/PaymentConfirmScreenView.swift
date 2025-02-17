//
//  PaymentConfirmScreenView.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 16/07/24.
//

import SwiftUI

struct PaymentConfirmScreenView: View {
    @Environment(\.router) var router
    var paymentConfirmAction: (()->Void)? = nil
    
    @StateObject var viewModel = PaymentViewModel()
    var body: some View {
        ZStack{
            VStack{
                HeaderViewWithRouter(title: "Payment Confirmed")
                ////LottieView(animationFileName: "SuccessLottie", loopMode: .loop)
                GifImageView("Success")
                    .padding(.horizontal,20)
                    .frame(height: 325)
                VStack(spacing:20){
                    Text("Your payment was successful!")
                        .font(.custom(FontContent.plusRegular, size: 12))
                        
                    
                    Text("Your Booking for \((viewModel.paymentOrderData?.startDate.convertDateFormater(beforeFormat: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", afterFormat: "MMMM d")) ?? "") has\nbeen Confirmed")
                        
                        .font(.custom(FontContent.plusRegular, size: 12))
                        
                }
                .multilineTextAlignment(.center)
                .foregroundStyle(._444446)
                .padding(.top,50)
                
                Spacer()
            }
        }
        .task{
            viewModel.confrimGiverPayment {
                
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                paymentConfirmAction?()
            }
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    PaymentConfirmScreenView()
}
