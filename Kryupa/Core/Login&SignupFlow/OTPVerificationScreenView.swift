//
//  OTPVerificationScreenView.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 16/05/24.
//

import SwiftUI
import SwiftfulUI

struct OTPVerificationScreenView: View {
    
    @Environment(\.router) var router
    var mobileNumber: String = String()
    
    var body: some View {
        
        VStack(spacing:0,content: {
            Text("Phone verification")
                .font(.custom(FontContent.besMedium, size: 28))
                .multilineTextAlignment(.center)
                .padding(.top, 43)
            
            Text("An authentication code has been sent to you on your number ending with \(String(mobileNumber.suffix(4)))")
                .frame(width: 270)
                .font(.custom(FontContent.plusRegular, size: 13))
                .multilineTextAlignment(.center)
                .padding(.top, 20)
                .foregroundStyle(._444446)
            
            VStack{
                OTPTextFieldView(numberOfFields: 5) { otpArray in
                    print(otpArray)
                }
                
                resendOTPView

                verifyCodeButton
                    .padding(.top,30)
                    .asButton(.press) {
                        router.showScreen(.push) { rout in
                            PersonalInformationScreenView()
                        }
                    }
                
                Spacer()
            }
            .padding(.top, 30)
            .padding([.leading, .trailing],24)
            .toolbar(.hidden, for: .navigationBar)
            
        })
        .modifier(DismissingKeyboard())
    }
    
    //MARK: Resend Code View
    private var resendOTPView: some View{
        HStack(spacing:5){
            Text("Didn’t receive the code?")
            Text("Resend it")
                .underline()
                .asButton(.press) {
                    
                }
        }
        .font(.custom(FontContent.plusRegular, size: 13))
        .foregroundStyle(._444446)
        .padding(.top, 15)
    }

    
    //MARK: Verify Code View
    private var verifyCodeButton: some View {
        HStack{
            Text("Verify Code")
                .font(.custom(FontContent.plusMedium, size: 16))
                .padding([.top,.bottom], 16)
                .padding([.leading,.trailing], 40)
        }
        .background(
            ZStack{
                Capsule(style: .circular)
                    .fill(.appMain)
            }
        )
        .foregroundColor(.white)
    }
}

#Preview {
    OTPVerificationScreenView()
}
