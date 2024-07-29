//
//  UserSelectionScreenView.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 16/05/24.
//

import SwiftUI
import SwiftfulUI

struct UserSelectionScreenView: View {
    
    @Environment(\.router) var router
    
    var body: some View {
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
            Image("UserTypeScreenIcon")
                .resizable()
                .frame(width: 330,height: 290)
            
            setTitle(title: "Ready to Lend a Hand?")
                .padding(.top, 85)
            
            commonButton(title: "Give Care")
                .padding(.top, 10)
                .asButton(.press) {
                    navigateToSocialScreenView(AppConstants.GiveCare)
                }
                .toolbar(.hidden, for: .navigationBar)
            
            sepratorView
            
            setTitle(title: "In Need of a Helping Hand?")
                .padding(.top, 30)
            
            commonButton(title: "Seek Care")
                .padding(.top, 10)
                .padding(.bottom, 56)
                .asButton(.press) {
                    navigateToSocialScreenView(AppConstants.SeekCare)
                }
                .toolbar(.hidden, for: .navigationBar)
        }
    }
    
    //MARK: Seprator View
    private var sepratorView: some View{
        HStack{
            Rectangle()
                .frame(width: 89,height: 1)
            Text("Or")
            Rectangle()
                .frame(width: 89,height: 1)
            
        }
        .foregroundStyle(.AEAEB_2)
        .padding(.top, 30)
    }
    
    //MARK: Set Title View
    private func setTitle(title: String)-> some View{
        Text(title)
            .font(.custom(FontContent.plusMedium, size: 17))
            .multilineTextAlignment(.center)
    }
    
    //MARK: navigateToSocialScreenView
    private func navigateToSocialScreenView(_ userType: String){
        Defaults().userType = userType
        router.showScreen(.push) { _ in
            SocialLoginScreenView(userType: userType)
        }
    }
    
    //MARK: Common Button
    private func commonButton(title: String)-> some View {
        HStack{
            Text(title)
                .font(.custom(FontContent.plusMedium, size: 16))
                .padding([.top,.bottom], 8)
                .padding([.leading,.trailing], 20)
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
    UserSelectionScreenView()
}
