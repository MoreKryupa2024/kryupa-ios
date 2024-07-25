//
//  PaymentConfirmScreenView.swift
//  Kryupa
//
//  Created by Hemant Singh Rajput on 16/07/24.
//

import SwiftUI

struct PaymentConfirmScreenView: View {
    @Environment(\.router) var router
    
    var body: some View {
        ZStack{
            VStack{
                HeaderView(title: "Payment Confirmed")
                
                GifImageView("Success")
                    .padding(.horizontal,20)
                    .frame(height: 325)
                VStack(spacing:20){
                    Text("Your payment was successful!")
                        .font(.custom(FontContent.plusRegular, size: 12))
                        
                    
                    Text("Your Booking for 7th March has\nbeen Confirmed")
                        
                        .font(.custom(FontContent.plusRegular, size: 12))
                        
                }
                .multilineTextAlignment(.center)
                .foregroundStyle(._444446)
                .padding(.top,50)
                
                Spacer()
            }
        }
        .task{
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                router.dismissScreenStack()
            }
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    PaymentConfirmScreenView()
}
