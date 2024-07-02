//
//  MobileNumberScreenView.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 16/05/24.
//

import SwiftUI
import SwiftfulUI

struct MobileNumberScreenView: View {
    
    @Environment(\.router) var router
    
    @StateObject private var viewModel = MobileScreenViewModel()
    
    var body: some View {
        ZStack{
            
            VStack(spacing:0,content: {
                Text("Phone Number")
                    .font(.custom(FontContent.besMedium, size: 28))
                    .multilineTextAlignment(.center)
                    .padding(.top, 43)
                
                Text("Please enter your phone number")
                    .font(.custom(FontContent.plusRegular, size: 13))
                    .multilineTextAlignment(.center)
                    .padding(.top, 20)
                    .foregroundStyle(._444446)
                
                VStack{
                    mobileNumberHeaderTitleView
                    
                    mobileNumberFieldView
                    
                    sendCodeButton
                        .padding(.top,50)
                        .asButton(.press) {
                            if "+1\(viewModel.mobileNumner)".validateMobile(){
                                viewModel.sendOTP {
                                    router.showScreen(.push) { _ in
                                        OTPVerificationScreenView(mobileNumber: viewModel.mobileNumner,requestId: viewModel.sendOTPdata?.requestID ?? "")
                                    }
                                } errorAction: { error in
//                                    router.showScreen(.push) { _ in
//                                        OTPVerificationScreenView(mobileNumber: viewModel.mobileNumner,requestId: viewModel.sendOTPdata?.requestID ?? "")
//                                    }
                                    presentAlert(title: "Kruypa", subTitle: error)
                                }
                            }
                        }
                    
                    Spacer()
                }
                .padding(.top, 30)
                .padding([.leading, .trailing],24)
                .toolbar(.hidden, for: .navigationBar)
            })
            .onAppear(perform: {
#if DEBUG && targetEnvironment(simulator)
                self.viewModel.mobileNumner = "6466124295"
#else
                //
#endif
                //
            })
            .modifier(DismissingKeyboard())
            
            if viewModel.isLoading{
                LoadingView()
            }
        }
    }
    
    //MARK: Mobile Number Header Title View
    private var mobileNumberHeaderTitleView: some View{
        HStack(spacing:0){
            Text("Enter Phone No.")
                .font(.custom(FontContent.plusMedium, size: 17))
                .multilineTextAlignment(.center)
                .foregroundStyle(.appMain)
            Text("*")
                .font(.custom(FontContent.plusMedium, size: 17))
                .multilineTextAlignment(.center)
                .foregroundStyle(.red)
                Spacer()
        }
    }
    
    //MARK: Mobile Number Field View
    private var mobileNumberFieldView: some View{
        HStack(spacing:3) {
            Image("flagDemo")
                .frame(width: 20, height: 20)
                .padding(.leading,10)
            
            
            Text("+1")
                .font(.custom(FontContent.plusRegular, size: 15))
                .foregroundStyle(._444446)
            
            Image("DropDownDrackGray")
                .resizable()
                .frame(width: 16,height: 16)
            
            TextField(text: $viewModel.mobileNumner) {
                Text("123454321")
                    .foregroundStyle(._7_C_7_C_80)
            }
            .padding(.trailing, 10)
            .keyboardType(.numberPad)
            .frame(height: 44)
            .font(.custom(FontContent.plusRegular, size: 15))
        }
        .background{
            RoundedRectangle(
                            cornerRadius: 8
                        )
                .stroke(lineWidth: 1)
                .foregroundStyle(.D_1_D_1_D_6)
        }
        .frame(height: 44)
    }
    
    //MARK: Send Code Button View
    private var sendCodeButton: some View {
        HStack{
            Text("Send Code")
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
    MobileNumberScreenView()
}
