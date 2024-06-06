//
//  SocialLoginScreenViewModel.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 22/05/24.
//

import SwiftUI
import Firebase
import GoogleSignIn


class SocialLoginScreenViewModel: ObservableObject{
    
    @Published var isLogin: Bool = false
    @Published var isLoading:Bool = false
    
    func signUpWithGoogle(completionHandler :  @escaping ([String:Any]) -> Void){
        
        guard let clientId = FirebaseApp.app()?.options.clientID else {return}
        
        let config = GIDConfiguration(clientID: clientId)
        GIDSignIn.sharedInstance.configuration = config
        
        GIDSignIn.sharedInstance.signIn(withPresenting: ApplicationUtility.rootViewController) { signInResult, error in
            
            if let error {
                print(error.localizedDescription)
            }
            
            guard let user = signInResult?.user, let _ = user.idToken else { return }
            
            
            let accessToken = user.accessToken.tokenString
            let param = ["deviceId": UIDevice.current.identifierForVendor!.uuidString,
                         "deviceType": AppConstants.DeviceType,
                         "socialAccessToken": accessToken,
                         "fcmToken": "asdfasdfadsf",
                         "referralCode": "",
                         "userType": Defaults().userType,
                         "providerType": AppConstants.SocialGoogle
            ]
            print(param)
            completionHandler(param)
            // If sign in succeeded, display the app's main content View.
        }
    }
    
    
    func signCall(param:[String:Any],completionHandler :  @escaping (UserInfo) -> Void){
        isLoading = true
        NetworkManager.shared.postGoogleSignup(params: param) { [weak self]result in
            switch result{
            case.success(let data):
                self?.isLoading = false
                completionHandler(data.data.userInfo)
            case .failure(let error):
                self?.isLoading = false
                print(error)
            }
        }
    }
    
}

