//
//  ReferAndEarnScreenView.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 29/05/24.
//

import SwiftUI
import SwiftfulUI

struct ReferAndEarnScreenView: View {
    @Environment(\.router) var router
    
    var body: some View {
        VStack{
            HeaderView
            ScrollView{
                BannerView
                HStack(spacing:18){
                    ReferEarnView(title: "Potential Earning", value: "$125")
                    ReferEarnView(title: "Friends Referred", value: "03/10")
                }
                .padding(.horizontal,24)
                ReferPointsView
                nextButton
                    .padding(.top,25)
            }
            .scrollIndicators(.hidden)
            .toolbar(.hidden, for: .navigationBar)
        }
    }
    
    private var sepratorView: some View{
        Image("referSepratorView")
            .frame(width: 2,height: 22)
            .padding(.leading,32)
    }
    
    
    private var ReferPointsView: some View{
        VStack(alignment:.leading,spacing:0){
            Text("As easy as ordering pizza!")
                .font(.custom(FontContent.plusMedium, size: 13))
                .foregroundStyle(._018_ABE)
                .padding(.top,25)
            
            ReferPhoneView
                .padding(.top,15)
            sepratorView
            ReferDownloadView
            sepratorView
            VerificationProcessView
            sepratorView
            PotentialRewardView
            
            
        }
        .padding(.horizontal,24)
    }
    
    private var nextButton: some View {
        HStack{
            Text("Refer Now")
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
    
    private var ReferDownloadView: some View{
        HStack(spacing:15){
            Circle()
                .foregroundStyle(.E_5_E_5_EA)
                .frame(height: 13)
            
            Image("ReferDownload")
                .frame(width: 34,height: 34)
            
            Text("When your referral downloads the app")
                .font(.custom(FontContent.plusRegular, size: 11))
                .foregroundStyle(._444446)
        }
        .frame(maxWidth: .infinity,alignment: .leading)
        .padding(.leading,27)
        .overlay(content: {
            RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 1)
                .foregroundStyle(.E_5_E_5_EA)
                .frame(height: 64)
        })
        .padding(.vertical,14)
    }
    private var VerificationProcessView: some View{
        HStack(spacing:15){
            Circle()
                .foregroundStyle(.E_5_E_5_EA)
                .frame(height: 13)
            
            Image("verificationProcess")
                .frame(width: 34,height: 34)
            
            Text("and completes the background verification process")
                .font(.custom(FontContent.plusRegular, size: 11))
                .foregroundStyle(._444446)
        }
        .frame(maxWidth: .infinity,alignment: .leading)
        .padding(.leading,27)
        .overlay(content: {
            RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 1)
                .foregroundStyle(.E_5_E_5_EA)
                .frame(height: 64)
        })
        .padding(.vertical,16)
    }
    
    private var  PotentialRewardView: some View{
        HStack(spacing:15){
            Circle()
                .foregroundStyle(.E_5_E_5_EA)
                .frame(height: 13)
            
            Image("potentialReward")
                .frame(width: 34,height: 34)
            
            Text("You earn a potential reward of $25!")
                .font(.custom(FontContent.plusRegular, size: 11))
                .foregroundStyle(._444446)
        }
        .frame(maxWidth: .infinity,alignment: .leading)
        .padding(.leading,27)
        .overlay(content: {
            RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 1)
                .foregroundStyle(.E_5_E_5_EA)
                .frame(height: 64)
        })
        .padding(.vertical,14)
    }
    
    private var ReferPhoneView: some View{
        HStack(spacing:15){
            Circle()
                .foregroundStyle(.E_5_E_5_EA)
                .frame(height: 13)
            
            Image("referPhone")
                .frame(width: 34,height: 50)
                .offset(y:7)
            
            Text("Share the app with your friends & family")
                .font(.custom(FontContent.plusRegular, size: 11))
                .foregroundStyle(._444446)
        }
        .frame(maxWidth: .infinity,alignment: .leading)
        .padding(.leading,27)
        .overlay(content: {
            RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 1)
                .foregroundStyle(.E_5_E_5_EA)
                .frame(height: 64)
        })
        .padding(.vertical,8)
    }
    
    private func ReferEarnView(title:String,value: String)-> some View{
        
        VStack(alignment: .leading,spacing: 0){
            Text(title)
                .font(.custom(FontContent.plusRegular, size: 11))
                .foregroundStyle(._7_C_7_C_80)
            Text(value)
                .font(.custom(FontContent.besRegular, size: 22))
        }
        .frame(maxWidth: .infinity,alignment: .leading)
        .padding(.horizontal,20)
        .padding(.vertical,6)
        .overlay(content: {
            RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 1)
                .foregroundStyle(.E_5_E_5_EA)
        })
        .padding(.top,15)
    }
    
    private var BannerView: some View{
        Image("refer & earn banner")
            .resizable()
            .frame(height: 106)
            .padding(.horizontal,24)
            .padding(.top,10)
        
    }
    
    private var HeaderView: some View{
        ZStack{
            HStack{
                Image("navBack")
                    .resizable()
                    .frame(width: 30,height: 30)
                    .padding(.leading,24)
                Spacer()
            }
            .asButton(.press) {
                router.dismissScreen()
            }
            
            Image("refer & earn header")
                .resizable()
                .frame(width: 135,height: 20)
        }
        .padding(.vertical,10)
    }
}

#Preview {
    ReferAndEarnScreenView()
}
