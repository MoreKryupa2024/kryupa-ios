//
//  ServiceDetailScreenView.swift
//  Kryupa
//
//  Created by Hemant Singh Rajput on 12/06/24.
//

import SwiftUI
import SwiftfulUI

struct ServiceDetailScreenView: View {
    
    @State var review: String = "Nice and polite"
    
    var body: some View {
        ZStack{
            VStack(spacing:0){
             HeaderView
                ScrollView{
                    ProfileView
                    DetailView
                }
                .scrollIndicators(.hidden)
            }
//            if viewModel.isloading{
//                LoadingView()
//            }
        }
        .toolbar(.hidden, for: .navigationBar)
//        .onAppear{
//            viewModel.getCareGiverDetails(giverId: careGiverDetail?.id ?? "")
//        }
    }
    
    private var DetailView: some View{
        VStack(spacing:0){
            VStack(alignment:.leading, spacing:5){
                Text("Monday, 07 March 2024")
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .font(.custom(FontContent.besMedium, size: 16))
                
                Text("02:00 PM - 05:00PM")
                    .font(.custom(FontContent.plusRegular, size: 11))
                    .foregroundStyle(._444446)
            }
            .padding(.vertical,10)
            .padding(.horizontal,26)
            .background{
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 2)
                    .foregroundStyle(.F_2_F_2_F_7)
            }
            .padding(.horizontal,24)
            .padding(.top,30)
            
            SepratorView
            
            VStack(alignment:.leading, spacing:10){
                HStack(spacing:0){
                    Text("Address:")
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .font(.custom(FontContent.plusRegular, size: 17))
                        .padding(.leading,24)
                    Image("editAddress")
                        .padding(.trailing,18)
                }
                
                Text("FG 20, Sector 54, New York USA, 541236")
                    .font(.custom(FontContent.plusRegular, size: 12))
                    .foregroundStyle(._444446)
                    .padding(.leading,24)
            }
            
            SepratorView
            
            VStack(alignment:.leading, spacing:10){
                HStack(spacing:0){
                    Text("Rate per hour:")
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .font(.custom(FontContent.plusRegular, size: 15))
                    
                    
                    Text("$20.23")
                        .font(.custom(FontContent.plusRegular, size: 16))
                }
                
                HStack(spacing:0){
                    Text("Number of hour:")
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .font(.custom(FontContent.plusRegular, size: 15))
                    
                    
                    Text("6")
                        .font(.custom(FontContent.plusRegular, size: 16))
                }
                
                HStack(spacing:0){
                    Text("Total:")
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .font(.custom(FontContent.plusRegular, size: 15))
                    
                    
                    Text("$121.38")
                        .font(.custom(FontContent.plusRegular, size: 16))
                }
            }
            .padding(.horizontal,24)
            
            SepratorView
            
            VStack(alignment:.leading, spacing:10){
                
                Text("Review:")
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .font(.custom(FontContent.plusRegular, size: 17))
                HStack(spacing:5){
                    Image(systemName: "star.fill")
                        .resizable()
                        .frame(width: 12,height: 12)
                    Image(systemName: "star.fill")
                        .resizable()
                        .frame(width: 12,height: 12)
                    Image(systemName: "star.fill")
                        .resizable()
                        .frame(width: 12,height: 12)
                    Image(systemName: "star.fill")
                        .resizable()
                        .frame(width: 12,height: 12)
                    Image(systemName: "star.fill")
                        .resizable()
                        .frame(width: 12,height: 12)
                }
                .foregroundStyle(.D_1_D_1_D_6)
                
                TextEditor(text: $review)
                .frame(height: 120)
                .keyboardType(.asciiCapable)
                .font(.custom(FontContent.plusRegular, size: 15))
                .padding([.leading,.trailing],10)
                .background {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(lineWidth: 1)
                        .foregroundStyle(.D_1_D_1_D_6)
                        .frame(height: 125)
                }
                .padding(.top,10)
                
                SubmitButton
                    .padding(.vertical,20)
            }
            .padding(.horizontal,24)
        }
    }
    
    private var SepratorView: some View{
        Rectangle()
            .frame(height: 1)
            .foregroundStyle(.F_2_F_2_F_7)
            .padding(.vertical,15)
            .padding(.trailing,48)
        
    }
    
    private var ProfileView: some View{
        VStack(spacing:0){
            Text("Profile")
                .font(.custom(FontContent.besMedium, size: 20))
                .padding(.top,23)
                .padding(.bottom,15)
            
            
            RoundedRectangle(cornerRadius: 69)
                .stroke(lineWidth: 1)
                .foregroundStyle(.E_5_E_5_EA)
                .overlay(content: {
                    Image("profile")
                        .resizable()
                        .frame(width: 126,height: 126)
                        .clipShape(.rect(cornerRadius: 63))
                })
                .foregroundStyle(.white)
                .frame(width: 138,height: 138)
            
            VStack(alignment:.center, spacing:5){
                Text("Alexa Chatterjee")
                    .font(.custom(FontContent.besMedium, size: 20))
                
                Text("5 years experienced")
                    .font(.custom(FontContent.plusRegular, size: 12))
                    .foregroundStyle(._444446)
                Text("$252")
                    .font(.custom(FontContent.plusRegular, size: 12))
                    .foregroundStyle(._444446)
                HStack{
                    Image(systemName: "star.fill")
                        .resizable()
                        .frame(width: 12,height: 12)
                    
                    Text("(100)")
                        .font(.custom(FontContent.plusRegular, size: 11))
                        .foregroundStyle(._444446)
                }
            }
            .padding(.top,10)
         
            CancelButton
                .padding(.top,30)
                .asButton(.press){
//                    router.showScreen(.push) { route in
//                        ChatView()
//                    }
                }
        }
    }
    
    private var CancelButton: some View {
        HStack{
            Text("Cancel Booking")
                .font(.custom(FontContent.plusMedium, size: 16))
                .padding(.vertical, 8)
                .padding(.horizontal, 20)
        }
        .background(
            ZStack{
                Capsule(style: .circular)
                    .fill(.appMain)
            }
        )
        .foregroundColor(.white)
    }
    
    private var SubmitButton: some View {
        HStack{
            Text("Submit")
                .font(.custom(FontContent.plusMedium, size: 16))
                .padding(.vertical, 8)
                .padding(.horizontal, 20)
        }
        .background(
            ZStack{
                Capsule(style: .circular)
                    .fill(.appMain)
            }
        )
        .foregroundColor(.white)
    }
    
    private var HeaderView: some View{
        ZStack{
            Image("KryupaLobby")
                .resizable()
                .frame(width: 124,height: 20)
            
            HStack{
                Image("navBack")
                    .resizable()
                    .frame(width: 30,height: 30)
                    .asButton(.press) {
//                        router.dismissScreen()
                    }
                Spacer()
                Image("NotificationBellIcon")
                    .frame(width: 25,height: 25)
            }
            .padding(.horizontal,24)
        }
    }
}

#Preview {
    ServiceDetailScreenView()
}
