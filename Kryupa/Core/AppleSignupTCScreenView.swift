//
//  AppleSignupT&CScreenView.swift
//  Kryupa
//
//  Created by Nirmal on 10/12/24.
//

import SwiftUI
import SwiftfulUI

struct AppleSignupTCScreenView: View {
    
    var continueAction: (() -> Void)? = nil
    
    var body: some View {
        ZStack(alignment:.bottom){
            VStack(spacing:0){
                Spacer()
                VStack(spacing:0){
                    VStack(spacing:0){
                        Image("TCLogo")
                            .frame(width: 51,height: 51)
                            .padding(10)
                            .background(.white)
                            .clipShape(.rect(cornerRadius: 10))
                            .padding(.top,40)
                        
                        Text("Terms & Conditions")
                            .font(.custom(FontContent.besMedium, size: 16))
                            .padding(.top,10)
                        
                        Rectangle()
                            .frame(width: 109,height: 1)
                            .padding(.top,6)
                        
                        Text("Email Communication Consent Policy")
                            .font(.custom(FontContent.plusMedium, size: 15))
                            .padding(.top,40)
                        
                        Text("""
By selecting "Hide My Email", you will no longer receive any emails from Kryupa, including notifications and updates. Choose "Share My Email" to stay informed.
""")
                            .font(.custom(FontContent.plusRegular, size: 13))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal,40)
                            .padding(.top,10)
                        
                    }
                    .foregroundStyle(.white)
                    
                    Text("Continue")
                        .font(.custom(FontContent.plusRegular, size: 16))
                        .foregroundStyle(.black)
                        .frame(height: 35)
                        .frame(width: 111)
                        .background{
                            RoundedRectangle(cornerRadius: 48)
                                .foregroundStyle(.white)
                        }
                        .padding(.vertical,30)
                        .padding(.bottom,20)
                        .asButton(.press) {
                            self.continueAction?()
                        }
                }
                .background(.black)
                .cornerRadius(30, corners: [.topLeft, .topRight])
            }
            .frame(width: UIScreen.screenWidth)
        }
        .background(.black.opacity(0.50))
        .frame(width: UIScreen.screenWidth,height: UIScreen.screenHeight)
    }
}

#Preview {
    AppleSignupTCScreenView()
}
