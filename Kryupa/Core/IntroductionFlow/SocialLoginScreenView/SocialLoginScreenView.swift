//
//  SocialLoginScreenView.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 16/05/24.
//

import SwiftUI
import SwiftfulUI
import FirebaseMessaging
import AuthenticationServices

struct SocialLoginScreenView: View {
    @State var checkbox:Bool = true
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
                HStack{
                    Image("navBack")
                        .resizable()
                        .frame(width: 30,height: 30)
                        .asButton(.press) {
                            router.dismissScreen()
                        }
                    Spacer()
                }
                .padding(.horizontal,24)
                .padding(.top,10)
                
                Spacer()
                Image("socialScreenIcon")
                    .resizable()
                    .frame(width: 305)
                
                Text(title)
                    .font(.custom(FontContent.besMedium, size: 28))
                    .multilineTextAlignment(.center)
                    .lineSpacing(0)
                    .padding(.top, 66)
                    .padding(.horizontal, 24)
                
                VStack(alignment:.center, spacing: 10.0){
                    AppleButton
                    commonButton(imageName: "googleButton")
                        .asButton(.press) {
                            if checkbox{
                                viewModel.signUpWithGoogle { param in
                                    viewModel.signCall(param: param){ userInfo in
                                        navigateToMobileNumberView(userInfo: userInfo)
                                    }
                                }
                            }else{
                                presentAlert(title: "Kryupa", subTitle: "Please Check the Below Checkbox to move forword")
                            }
                            
                        }
                }
                .padding(.top,24)
                .padding(.bottom,30)
                
                HStack(alignment:.top,spacing: 5){
                    Image(checkbox ? "checkboxSelected" : "checkboxUnselected")
                        .frame(width: 20,height: 20)
                    Text("I agree to use in-app messaging, which may include my name. It’s advised not to include other personal health information (PHI) in message and to keep mobile devices password protected to prevent unauthorized access.")
                        .fontWeight(.regular)
                        .font(.system(size: 11))
                }
                .padding(.horizontal,24)
                .asButton(.press) {
                    checkbox = !checkbox
                }
            }
            .toolbar(.hidden, for: .navigationBar)
            
            if viewModel.isLoading{
                LoadingView()
            }
        }
    }
    
    private var AppleButton: some View{
        return SignInWithAppleButton(.signUp) { request in
            request.requestedScopes = [.fullName, .email]
        } onCompletion: { result in
            switch result {
            case .success(let authorization):
                handleSuccessfulLogin(with: authorization)
            case .failure(let error):
                handleLoginError(with: error)
            }
        }
        .clipShape(.rect(cornerRadius: 24))
        .frame(width: 270,height: 48)
    }
    
    private func handleSuccessfulLogin(with authorization: ASAuthorization) {
        if let userCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let data = userCredential.identityToken else { return }
            let identityToken = String(decoding: data, as: UTF8.self)
            let authorizationCode = (userCredential.authorizationCode?.base64EncodedString() ?? "Authorization code not available")
            let userIdentifier = userCredential.user
            let fullName = userCredential.fullName
            let email = userCredential.email
            
            print("identityToken:- \(identityToken)")
            print("authorizationCode:- \(authorizationCode)")
            print("userIdentifier:- \(userIdentifier)")
            
            let param = ["deviceId": UIDevice.current.identifierForVendor!.uuidString,
                         "deviceType": AppConstants.DeviceType,
                         "socialAccessToken": identityToken,
                         "fcmToken": Messaging.messaging().fcmToken ?? "safasfasf",
                         "referralCode": "",
                         "userType": Defaults().userType,
                         "providerType": AppConstants.SocialApple
            ]
            
            viewModel.signCall(param: param){ userInfo in
                navigateToMobileNumberView(userInfo: userInfo)
            }
        }
    }
    
    private func handleLoginError(with error: Error) {
        
        print("Could not authenticate: \\(error.localizedDescription)")
    }
    
    //MARK: Navigate To Mobile Number Screen
    private func navigateToMobileNumberView(userInfo: DataClass? = nil){
        Defaults().fullName = userInfo?.userInfo.name ?? ""
        switch userInfo?.verificationStatus{
        case "Personal information":
            router.showScreen(.push) { _ in
                if userType == AppConstants.GiveCare{
                    PersonalInformationScreenView()
                }else{
                    PersonalInformationSeekerView()
                }
            }
        case "Take photo":
            router.showScreen(.push) { _ in
                SelectProfileImageView()
            }
        case "Onboarding done":
            if userType == AppConstants.GiveCare{
                NotificationCenter.default.post(name: .setCareGiverHomeScreen,
                                                object: nil, userInfo: nil)
                router.dismissScreenStack()
            }else{
                NotificationCenter.default.post(name: .setCareSeekerHomeScreen,
                                                object: nil, userInfo: nil)
                router.dismissScreenStack()
            }
        case "Mobile Verification":
            router.showScreen(.push) { _ in
                MobileNumberScreenView()
            }
        case "Waitting at lobby":
            
            NotificationCenter.default.post(name: .setLobbyScreen,
                                            object: nil, userInfo: nil)
            router.dismissScreenStack()
            
        default:
            break
        }
        
    }
    
    //MARK: Common Button View
    private func commonButton(imageName: String)-> some View {
        HStack{
            Image(imageName)
                .resizable()
                .frame(width: 270,height: 48)
        }
    }
}

#Preview {
    SocialLoginScreenView()
}

