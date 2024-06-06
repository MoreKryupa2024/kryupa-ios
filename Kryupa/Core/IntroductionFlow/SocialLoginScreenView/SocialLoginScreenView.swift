//
//  SocialLoginScreenView.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 16/05/24.
//

import SwiftUI
import SwiftfulUI

struct SocialLoginScreenView: View {
    
    @Environment(\.router) var router
    var userType: String = UserDefaults.standard.value(forKey: "user") as? String ?? ""
    @StateObject private var viewModel = SocialLoginScreenViewModel()
    var title: String{
        if userType == AppConstants.GiveCare{
            return "Ready to Provide Care? Join our network of caregivers."
        }else{
            return "Your Path for Quality Care Starts Here! Register Now"
        }
    }
    
    var body: some View {
        ZStack{
            VStack(spacing: 0.0){
                Spacer()
                Image("socialScreenIcon")
                    .resizable()
                    .frame(width: 305,height: 295)
                
                Text(title)
                    .font(.custom(FontContent.besMedium, size: 28))
                    .multilineTextAlignment(.center)
                    .lineSpacing(0)
                    .padding(.top, 66)
                    .padding(.horizontal, 24)
                
                VStack(spacing: 10.0){
                    commonButton(imageName: "appleButton")
                        .asButton(.press) {
                            navigateToMobileNumberView()
                        }
                    commonButton(imageName: "googleButton")
                        .asButton(.press) {
                            viewModel.signUpWithGoogle { param in
                                viewModel.signCall(param: param){ userInfo in
                                    navigateToMobileNumberView(userInfo: userInfo)
                                }
                            }
                        }
                }
                .padding([.leading,.trailing],52)
                .padding(.top,24)
                .padding(.bottom,63)
                .toolbar(.hidden, for: .navigationBar)
            }
            if viewModel.isLoading{
                LoadingView()
            }
        }
    }
    
    //MARK: Navigate To Mobile Number Screen
    private func navigateToMobileNumberView(userInfo: UserInfo? = nil){
        router.showScreen(.push) { _ in
            if userType == AppConstants.GiveCare{
                MobileNumberScreenView()
            }else{
                PersonalInformationSeekerView()
            }
        }
    }
    
    //MARK: Common Button View
    private func commonButton(imageName: String)-> some View {
        HStack{
            Image(imageName)
                .resizable()
                .frame(height: 48)
        }
    }
}

#Preview {
    SocialLoginScreenView()
}


struct LoadingView:View{
    var body: some View{
        ZStack{
            Color(.systemBackground)
                .ignoresSafeArea()
                .opacity(0.5)
            
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                .scaleEffect(2)
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .onTapGesture {
            print("No access!")
        }
    }
}
