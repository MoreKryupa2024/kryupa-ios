//
//  SuccessfulScreeenView.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 21/05/24.
//

import SwiftUI

struct SuccessfulScreeenView: View {
    @Environment(\.router) var router
    var userType: String = Defaults().userType//.standard.value(forKey: "user") as? String ?? ""
    
    var title: String{
        if userType == AppConstants.GiveCare{
            return "Thankyou for registering"
        }else{
            return "Welcome Aboard!"
        }
    }
    
    var message: String{
        if userType == AppConstants.GiveCare{
            return "You will receive a mail once your background check has been verified"
        }else{
            return "you're now ready to embark on your journey to seek care."
        }
    }
    
    
    var body: some View {
        ScrollView{
            VStack(spacing:0){
                ZStack(alignment:.leading){
                    
                    RoundedRectangle(cornerRadius: 4)
                        .foregroundStyle(.appMain)
                        .frame(height: 4)
                }
                .padding([.leading,.trailing],24)
                
                
                Text(title)
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                    .font(.custom(FontContent.besMedium, size: 22))
                    .padding(.top,50)
                
                
                GifImageView("Success")
                    .padding(.horizontal,20)
                    .frame(height: 325)
                
                Text(message)
                    .font(.custom(FontContent.plusRegular, size: 13))
                    .multilineTextAlignment(.center)
                    .frame(width: 270)
                
                    .onAppear{
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                            if userType == AppConstants.GiveCare{
                                NotificationCenter.default.post(name: .setLobbyScreen,
                                                                                object: nil, userInfo: nil)
//                                NotificationCenter.default.post(name: .setCareGiverHomeScreen,
//                                                                                object: nil, userInfo: nil)
                                router.dismissScreenStack()
                            }else{
                                NotificationCenter.default.post(name: .setCareSeekerHomeScreen,
                                                                                object: nil, userInfo: nil)
                                router.dismissScreenStack()
                            }
                        }
                    }
            }
        }
        .scrollIndicators(.hidden)
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    SuccessfulScreeenView()
}
