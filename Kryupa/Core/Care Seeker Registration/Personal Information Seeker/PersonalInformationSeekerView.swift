//
//  PersonalInformationSeekerView.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 20/05/24.
//

import SwiftUI
import SwiftfulUI

struct PersonalInformationSeekerView: View {
    
    @Environment(\.router) var router
    @StateObject private var viewModel = PersonalInformationScreenViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing:0){
                ZStack(alignment:.leading){
                    RoundedRectangle(cornerRadius: 4)
                        .foregroundStyle(.E_5_E_5_EA)
                        .frame(height: 4)
                    RoundedRectangle(cornerRadius: 4)
                        .foregroundStyle(.appMain)
                        .frame(width: 130,height: 4)
                }
                
                Text("Personal Information")
                    .font(.custom(FontContent.besMedium, size: 22))
                    .frame(height: 28)
                    .padding(.top,30)
                
                
                VStack(spacing: 25,
                       content: {
                    textFieldViewWithHeader(title: "Legal Name", placeHolder: "Name",value: $viewModel.personalInfoData.name,keyboard: .asciiCapable)
                    
                    selectionViewWithHeader(
                        leftIcone: nil,
                        rightIcon: "PersonalInfoCalender",
                        value: viewModel.dateOfBirthSelected ? viewModel.dateFormatter() : "",
                        title: "Date Of Birth",
                        placeHolder: "Select"
                    )
                    .background()
                    .asButton{
                        viewModel.dateOfBirthSelected = true
                        viewModel.showDatePicker = !viewModel.showDatePicker
                    }
                    
                    if viewModel.showDatePicker{
                        dateOfBirthPicker()
                    }
                    
                    genderDropdownView
                    
                    
                    languageDropdownView
                    
                    selectionViewWithHeader(leftIcone: "PersonalInfoLocation", rightIcon: nil, value: viewModel.personalInfoData.address, title: "Address", placeHolder: "Input text")
                        .onTapGesture {
                            router.showScreen(.push) { rout in
                                Test()
                            }
                        }
                                        
                    
                    HStack{
                        textFieldViewWithHeader(title: nil, placeHolder: "City",value: $viewModel.personalInfoData.city,keyboard: .asciiCapable)
                        textFieldViewWithHeader(title: nil, placeHolder: "State",value: $viewModel.personalInfoData.state,keyboard: .asciiCapable)
                        
                    }
                    
                    textFieldViewWithHeader(title: nil, placeHolder: "Country",value: $viewModel.personalInfoData.country,keyboard: .asciiCapable)
                    
                    
                    HStack{
                        Spacer()
                        nextButton
                            .asButton(.press) {
                                viewModel.customerDataChecks { alertStr in
                                    presentAlert(title: "Kryupa", subTitle: alertStr)
                                } next: { param in
                                    router.showScreen(.push) { rout in
                                        EmergencyContactView(parameters: param)
                                    }
                                }
                            }
                    }
                    
                })
                .padding(.top,25)
                
            }
            .padding([.leading,.trailing],24)
        }
        
        .scrollIndicators(.hidden)
        .toolbar(.hidden, for: .navigationBar)
        .modifier(DismissingKeyboard())
    }
    
    private var genderDropdownView: some View{
        VStack(alignment: .leading, spacing:0,
               content: {
            HStack(spacing:0){
                Text("Gender")
                Text("*")
                    .foregroundStyle(.red)
            }
            .frame(height: 21)
            .font(.custom(FontContent.plusMedium, size: 16))
            .padding(.bottom,10)
            
            DropDownView(
                selectedValue: viewModel.personalInfoData.gender,
                placeHolder: "Select",
                values: AppConstants.genderArray) { value in
                    viewModel.personalInfoData.gender = value
                }
        })
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
            .font(.custom(FontContent.plusMedium, size: 16))
            .padding(.bottom,10)
            
            DropDownView(
                selectedValue: viewModel.personalInfoData.language,
                placeHolder: "Select",
                values: AppConstants.languageSpeakingArray) { value in
                    viewModel.personalInfoData.language = value
                }
        })
    }
    
    //MARK: Send Code Button View
    private var nextButton: some View {
        HStack{
            Text("Next")
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
    
    private func dateOfBirthPicker()-> some View{
        VStack{
            HStack{
                Spacer()
                Text("Done")
                    .padding(10)
                    .foregroundStyle(.white)
                    .background{
                        Color.blue
                    }
                    .cornerRadius(5)
                    
            }
            .asButton(.press) {
                viewModel.personalInfoData.dob = viewModel.dateFormatter(formate: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                viewModel.showDatePicker = !viewModel.showDatePicker
            }
            DatePicker("Birthdate", selection: $viewModel.date, in: ...Date(), displayedComponents: .date)
                .datePickerStyle(.graphical)
        }
        
        
    }
    
    private func selectionViewWithHeader(leftIcone: String?, rightIcon: String?, value:String?,title: String?, placeHolder: String)-> some View{
        VStack(alignment: .leading, content: {
            if let title{
                HStack(spacing:0){
                    Text(title)
                    Text("*")
                        .foregroundStyle(.red)
                }
                .font(.custom(FontContent.plusMedium, size: 16))
            }
            
            HStack(spacing:0){
                if let leftIcone{
                    Image(leftIcone)
                        .padding(.trailing,5)
                        .frame(width: 24,height: 24)
                }
                
                if let value = value, value.isEmpty{
                    Text(placeHolder)
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .foregroundStyle(._7_C_7_C_80)
                }else{
                    Text(value ?? "")
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .foregroundStyle(.appMain)
                }
                
                if let rightIcon{
                    Image(rightIcon)
                        .padding(.trailing,12)
                        .frame(width: 24,height: 24)
                }
            }
            .font(.custom(FontContent.plusRegular, size: 15))
            .padding([.leading,.trailing],10)
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(lineWidth: 1)
                    .foregroundStyle(.D_1_D_1_D_6)
                    .frame(height: 48)
            }
            .padding(.top,10)
        })
    }
    
    
    private func textFieldViewWithHeader(title:String?, placeHolder: String, value: Binding<String?>,keyboard: UIKeyboardType)-> some View{
        VStack(alignment: .leading, content: {
            if let title{
                HStack(spacing:0){
                    Text(title)
                    Text("*")
                        .foregroundStyle(.red)
                }
                .font(.custom(FontContent.plusMedium, size: 16))
            }
            TextField(text: value.toUnwrapped(defaultValue: "")) {
                Text(placeHolder)
                    .foregroundStyle(._7_C_7_C_80)
                
            }
            .keyboardType(keyboard)
            .font(.custom(FontContent.plusRegular, size: 15))
            .padding([.leading,.trailing],10)
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(lineWidth: 1)
                    .foregroundStyle(.D_1_D_1_D_6)
                    .frame(height: 48)
            }
            .padding(.top,10)
        })
    }
    
}

#Preview {
    PersonalInformationSeekerView()
}
