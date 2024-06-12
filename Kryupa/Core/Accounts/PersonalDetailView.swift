//
//  PersonalDetailView.swift
//  Kryupa
//
//  Created by Pooja Nenava on 10/06/24.
//

import SwiftUI
import SwiftfulUI

struct PersonalDetailView: View {

    @State var strBio: String = ""
    @State private var intExp = 0
    @StateObject private var viewModel = PersonalDetailViewModel()

    var body: some View {
        
        ScrollView(showsIndicators: false){
            HeaderView
            textFieldViewWithHeader(
                title: "Bio",
                placeHolder: "Input text",
                value: $strBio,
                keyboard: .asciiCapable
            )
            line
            yearOfExpView
            line
            AdditionalInfoView
            line
            QualificationView
            line
            EducationDropdownView
            languageDropdownView
        }
        .overlay(alignment: .top) {
                Color.clear
                    .background(.regularMaterial)
                    .ignoresSafeArea(edges: .top)
                    .frame(height: 0)
            }
        .onAppear() {
            UIScrollView.appearance().bounces = false
        }
        
    }
    
    private var languageDropdownView: some View{
        VStack(alignment: .leading, spacing:0,
               content: {
            HStack(spacing:0){
                Text("Language")
                Text("*")
                    .foregroundStyle(.red)
            }
            .frame(height: 21)
            .font(.custom(FontContent.plusMedium, size: 17))
            .padding(.bottom,10)
            
            DropDownWithCheckBoxView(
                selectedValue: viewModel.languageDropDownSelected,
                placeHolder: "Select Language",
                values: viewModel.languageList) { value in
                    viewModel.languageDropDownSelected = value
                }

        })
        .padding(.horizontal,24)
        .padding(.top, 10)
        .padding(.bottom,-10)
    }
    
    private var EducationDropdownView: some View{
        VStack(alignment: .leading, spacing:0,
               content: {
            HStack(spacing:0){
                Text("Education")
                Text("*")
                    .foregroundStyle(.red)
            }
            .frame(height: 21)
            .font(.custom(FontContent.plusMedium, size: 17))
            .padding(.bottom,10)
            
            DropDownView(
                selectedValue: viewModel.education,
                placeHolder: "College Degree",
                values: viewModel.educationList) { value in
                    viewModel.education = value
                }
        })
        .padding(.horizontal,24)
        .padding(.top, 10)
    }
    
    private var QualificationView: some View{
        
        VStack(alignment: .leading, spacing: 10) {
            Text("Qualifications")
                .font(.custom(FontContent.plusMedium, size: 17))
                .foregroundStyle(._242426)
            
            
            HStack {
                Text("Education:")
                    .font(.custom(FontContent.plusRegular, size: 12))
                    .foregroundStyle(._242426)
                Spacer()
                Text("College Degree")
                    .font(.custom(FontContent.plusRegular, size: 12))
                    .foregroundStyle(._242426)
            }
            
            HStack {
                Text("Languages:")
                    .font(.custom(FontContent.plusRegular, size: 12))
                    .foregroundStyle(._242426)
                Spacer()
                Text( viewModel.languageDropDownSelected.isEmpty ? "-" : "\(viewModel.languageDropDownSelected.joined(separator: ","))")
                    .font(.custom(FontContent.plusRegular, size: 12))
                    .foregroundStyle(._242426)
            }
        }
        .padding(.horizontal,24)
        .padding(.top, 10)
    }
    
    private var AdditionalInfoView: some View{
        
        VStack(alignment: .leading){
            HStack(spacing:0){
                Text("Additional info")
            }
            .font(.custom(FontContent.plusMedium, size: 17))
            
            
            ZStack{
                NonLazyVGrid(columns: 1, alignment: .leading, spacing: 10, items: AppConstants.additionalInfoArray) { service in
                    if let service{
                        CheckBoxView(
                            isSelected: !viewModel.additionalInfoSelected.contains(service),
                            name: service
                        )
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .asButton(.press) {
                            if viewModel.additionalInfoSelected.contains(service){
                                viewModel.additionalInfoSelected = viewModel.additionalInfoSelected.filter{ $0 != service}
                            }else{
                                viewModel.additionalInfoSelected.append(service)
                            }
                        }
                    }else{
                        EmptyView()
                    }
                }
            }
        }
        .padding(.horizontal,24)
        .padding(.top,10)
    }
        
    private var yearOfExpView: some View{
        
        return HStack {
            Text("Years of experience")
                .font(.custom(FontContent.plusMedium, size: 17))
            
            Spacer()
            
            HStack(spacing:15) {
                Image("minus")
                    .asButton(.press) {
                        if Int(intExp) == 0 {
                            print("minus no")
                            intExp = 0
                        }
                        else {
                            print("minus in")
                            intExp = intExp - 1
                        }
                    }
                Text(String(intExp))
                    .font(.custom(FontContent.plusRegular, size: 16))
                Image("plus")
                    .asButton(.press) {
                        print("plus")
                        intExp = intExp + 1
                        print(intExp)
                    }
            }
            .padding(.horizontal, 15)
            .frame(height: 32)
            .overlay(
                RoundedRectangle(cornerRadius: 60)
                    .inset(by: 1)
                    .stroke(.D_1_D_1_D_6, lineWidth: 1)
            )
        }
        .padding(.horizontal,24)
        .padding(.top,10)
    }
    
    private var line: some View {
        Divider()
            .background(.F_2_F_2_F_7)
            .padding(.trailing, 30)
            .padding(.leading, 0)
            .padding(.top, 10)
        }
    
    private func textFieldViewWithHeader(title:String?, placeHolder: String, value: Binding<String>,keyboard: UIKeyboardType)-> some View{
        
        VStack(alignment: .leading, content: {
            if let title{
                HStack(spacing:0){
                    Text(title)
                }
                .font(.custom(FontContent.plusMedium, size: 17))
            }
            TextField(text: value, axis: .vertical) {
                Text(placeHolder)
                    .foregroundStyle(._7_C_7_C_80)
            }
            .lineLimit(3)
            .frame(height: 48)
            .keyboardType(keyboard)
            .font(.custom(FontContent.plusRegular, size: 15))
            .padding([.horizontal],10)
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(lineWidth: 1)
                    .foregroundStyle(.D_1_D_1_D_6)
                    .frame(height: 48)
            }
        })
        .padding([.top, .horizontal],24)

    }
    
    private var HeaderView: some View{
        VStack {
            
            VStack(spacing: 24) {
                
                ZStack{
                    Image("KryupaLobby")
                        .resizable()
                        .frame(width: 124,height: 20)
                    
                    HStack{
                        Image("navBack")
                            .resizable()
                            .frame(width: 30,height: 30)
                            .asButton(.press) {
                            }
                        Spacer()
                        Image("NotificationBellIcon")
                            .frame(width: 25,height: 25)
                    }
                    .padding(.horizontal,24)
                }
                
                Text("Personal Details")
                    .font(.custom(FontContent.besMedium, size: 20))
                    .foregroundStyle(._242426)
                
            }
            
            HStack {
                
                ZStack {
                    Image("personal")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .cornerRadius(30)
                    HStack {
                        
                        Spacer()
                        VStack {
                            Image("edit")
                                .resizable()
                                .frame(width: 12, height: 12)
                                .padding(.top, 0)
                            
                            Spacer()
                        }
                        .frame(height: 60)
                    }
                    .padding(.horizontal, 8)
                }
                .frame(width: 67, height: 67)
                .overlay(
                    RoundedRectangle(cornerRadius: 33)
                        .inset(by: 1)
                        .stroke(.AEAEB_2, lineWidth: 1)
                )
                
                
                VStack(alignment: .leading) {
                    Text("John Smith")
                        .font(.custom(FontContent.besMedium, size: 17))
                        .foregroundStyle(._242426)
                    
                    Text("Male")
                        .font(.custom(FontContent.plusRegular, size: 12))
                        .foregroundStyle(._242426)
                    
                    Text("Verified")
                        .frame(width: 62 ,height: 23)
                        .font(.custom(FontContent.plusRegular, size: 11))
                        .foregroundStyle(.white)
                        .background(._018_ABE)
                        .clipShape(Capsule())
                }
                
                Spacer()
                
                VStack() {
                    HStack {
                        Image("edit-two")
                            .frame(width: 13, height: 13)
                        
                        Text("Edit Profile")
                            .font(.custom(FontContent.plusRegular, size: 11))
                            .foregroundStyle(._7_C_7_C_80)
                    }
                    Spacer()
                }
                .padding()
            }
            .padding(.horizontal, 30)
        }
        .background(.F_2_F_2_F_7)
        .frame(height: 202)
        .clipShape(
            .rect (
                bottomLeadingRadius: 20,
                bottomTrailingRadius: 20
            )
        )
        
    }
}

#Preview {
    PersonalDetailView()
}
