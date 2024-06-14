//
//  ProfileDetailScreenView.swift
//  Kryupa
//
//  Created by Hemant Singh Rajput on 14/06/24.
//

import SwiftUI

struct ProfileDetailScreenView: View {
    var body: some View {
        ZStack{
            VStack{
                HeaderView(title: "Profile",showBackButton: true)
                ScrollView{
                    HStack(alignment:.top){
                        DropDownView(values: AppConstants.relationArray)
                        AddNewButton
                            .padding(.top,5)
                    }
                    .padding(.horizontal,24)
                    ImageViewSection
                    
                    PersonalInfoSection
                        .padding(.horizontal,24)
                        .padding(.top,20)
                    
                    SepratorView
                    
                    EmergencyInfoSection
                        .padding(.horizontal,24)
                }
                .scrollIndicators(.hidden)
            }
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
    private var PersonalInfoSection: some View{
        VStack(spacing:10){
            HStack(spacing:0){
                Text("Personal Info")
                Spacer()
                HStack {
                    Image("edit-two")
                        .resizable()
                        .frame(width: 17, height: 17)
                        .font(.custom(FontContent.plusRegular, size: 17))
                    
                    Text("Edit")
                        .font(.custom(FontContent.plusRegular, size: 16))
                        .foregroundStyle(._7_C_7_C_80)
                }
            }
            .padding(.bottom,5)
            
            
            TitleTextView(title: "Name:", value: "Alexa Chatterjee")
            TitleTextView(title: "Email:", value: "AlexaChatterjee@gmail.com")
            TitleTextView(title: "Language:", value: "English")
            TitleTextView(title: "DOB:", value: "1st March 1984")
        }
    }
    
    private var SepratorView: some View{
        Rectangle()
            .frame(height: 1)
            .foregroundStyle(.F_2_F_2_F_7)
            .padding(.vertical,30)
            .padding(.horizontal,24)
        
    }
    
    private var EmergencyInfoSection: some View{
        VStack(spacing:10){
            HStack(spacing:0){
                Text("Emergency Contact")
                Spacer()
                HStack {
                    Image("edit-two")
                        .resizable()
                        .frame(width: 17, height: 17)
                        .font(.custom(FontContent.plusRegular, size: 17))
                    
                    Text("Edit")
                        .font(.custom(FontContent.plusRegular, size: 16))
                        .foregroundStyle(._7_C_7_C_80)
                }
            }
            .padding(.bottom,5)
            
            
            TitleTextView(title: "Name:", value: "Alexa Chatterjee")
            TitleTextView(title: "Phone number:", value: "+12 54486 58954")
            TitleTextView(title: "Relation:", value: "Daughter")
            
        }
    }
    
    private func TitleTextView(title: String, value: String)-> some View{
        HStack(spacing:0){
            Text(title)
                
            Spacer()
            
            Text(value)
                .foregroundStyle(._7_C_7_C_80)
        }
        .font(.custom(FontContent.plusRegular, size: 15))
    }
    
    private var ImageViewSection: some View{
        HStack(spacing:15){
            ZStack {
                Image("personal")
                    .resizable()
                    .frame(width: 68, height: 68)
                    .clipShape(.rect(cornerRadius: 34))
                    .padding(3)
                    .overlay(
                        RoundedRectangle(cornerRadius: 37)
                            .stroke(.AEAEB_2, lineWidth: 1)
                    )
                Image("edit")
                    .offset(x:22,y:-25)
            }
            
            
            VStack(alignment: .leading, spacing:5){
                Text("John Smith")
                    .font(.custom(FontContent.besMedium, size: 20))
                    .foregroundStyle(.appMain)
                HStack(spacing:5){
                    Image("bin")
                    Text("Delete")
                        .foregroundStyle(.D_3180_C)
                }
            }
            Spacer()
        }
        .padding(.horizontal,24)
        .padding(.top,30)
    }
    
    private var AddNewButton: some View {
        HStack{
            Text("Add New")
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
}

#Preview {
    ProfileDetailScreenView()
}
