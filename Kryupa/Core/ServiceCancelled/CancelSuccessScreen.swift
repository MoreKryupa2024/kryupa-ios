//
//  CancelSuccessScreen.swift
//  Kryupa
//
//  Created by Hemant Singh Rajput on 09/08/24.
//

import SwiftUI

struct CancelSuccessScreen: View {
    @Environment(\.router) var router
    var body: some View {
        ZStack{
            VStack{
                HeaderView()
                
                GifImageView("Success")
                    .padding(.horizontal,20)
                    .frame(height: 325)
                //LottieView(animationFileName: "SuccessLottie", loopMode: .loop)
                VStack(spacing:20){
                    Text("Your Booking has been cancelled!\nCustomer Service will contact you soon.")
                        .font(.custom(FontContent.plusRegular, size: 12))
                }
                .multilineTextAlignment(.center)
                .foregroundStyle(._444446)
                .padding(.top,40)
                
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
    CancelSuccessScreen()
}
