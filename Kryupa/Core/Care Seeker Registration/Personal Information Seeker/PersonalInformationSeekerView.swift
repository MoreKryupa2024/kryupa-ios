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
    @State var genderDropShow = Bool()
    @State var languageDropShow = Bool()
    
    var body: some View {
        ZStack{
            VStack(spacing:0){
                ZStack(alignment:.leading){
                    RoundedRectangle(cornerRadius: 4)
                        .foregroundStyle(.E_5_E_5_EA)
                        .frame(height: 4)
                    RoundedRectangle(cornerRadius: 4)
                        .foregroundStyle(.appMain)
                        .frame(width: 130,height: 4)
                }
                .padding(.top,20)
                
                Text("Personal Information")
                    .font(.custom(FontContent.besMedium, size: 22))
                    .frame(height: 28)
                    .padding(.top,30)
                
                ScrollView {
                    VStack(spacing: 25,
                           content: {
                        textFieldViewWithHeader(title: "Legal Name", placeHolder: "Full Legal Name",value: $viewModel.personalInfoData.name,keyboard: .asciiCapable)
                        
                        selectionViewWithHeader(
                            leftIcone: nil,
                            rightIcon: "PersonalInfoCalender",
                            value: viewModel.dateOfBirthSelected ? viewModel.personalInfoData.dob?.convertDateFormater(beforeFormat: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", afterFormat: "MM-dd-yyyy") : "",
                            title: "Date Of Birth",
                            placeHolder: "Select"
                        )
                        .background()
                        .asButton{
                            viewModel.dateOfBirthSelected = true
                            viewModel.showDatePicker = !viewModel.showDatePicker
                        }
                        
                        genderDropdownView
                        
                        
                        languageDropdownView
                        
                        AddressView(value: $viewModel.personalInfoData.address.toUnwrapped(defaultValue: ""))
                        VStack(alignment:.leading,spacing:5){
                            HStack{
                                textFieldViewWithHeader(title: nil, placeHolder: "Postal Code",value: $viewModel.personalInfoData.postalCode,keyboard: .numberPad)
                                    .onChange(of: viewModel.personalInfoData.postalCode) { oldValue, newValue in
                                        if (viewModel.personalInfoData.postalCode ?? "").count > 5{
                                            viewModel.personalInfoData.postalCode = "\((viewModel.personalInfoData.postalCode ?? "").prefix(5))"
                                        }else{
                                            if (viewModel.personalInfoData.postalCode ?? "").count == 5{
                                                viewModel.getAddress()
                                            }else{
                                                viewModel.personalInfoData.city = ""
                                                viewModel.personalInfoData.state = ""
                                                viewModel.personalInfoData.country = ""
                                                viewModel.personalInfoData.zipError = ""
                                            }
                                        }
                                    }
                                textFieldViewWithHeader(title: nil, placeHolder: "City",value: $viewModel.personalInfoData.city,keyboard: .asciiCapable)
                                    .disabled(true)
                                    .background{
                                        RoundedRectangle(cornerRadius: 8)
                                        .foregroundStyle(.D_1_D_1_D_6)
                                        .frame(height: 48)
                                        .offset(y:5)
                                    }
                            }
                            if let zipError = viewModel.personalInfoData.zipError, !(zipError.isEmpty){
                                Text(zipError)
                                    .foregroundStyle(.red)
                                    .offset(y:10)
                            }
                        }
                        
                        HStack{
                            textFieldViewWithHeader(title: nil, placeHolder: "State",value: $viewModel.personalInfoData.state,keyboard: .asciiCapable)
                                .disabled(true)
                                .background{
                                    RoundedRectangle(cornerRadius: 8)
                                    .foregroundStyle(.D_1_D_1_D_6)
                                    .frame(height: 48)
                                    .offset(y:5)
                                }
                            
                            textFieldViewWithHeader(title: nil, placeHolder: "Country",value: $viewModel.personalInfoData.country,keyboard: .asciiCapable)
                                .disabled(true)
                                .background{
                                    RoundedRectangle(cornerRadius: 8)
                                    .foregroundStyle(.D_1_D_1_D_6)
                                    .frame(height: 48)
                                    .offset(y:5)
                                }
                        }
                        
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
                
            }
            .padding([.leading,.trailing],24)
            .scrollIndicators(.hidden)
            .toolbar(.hidden, for: .navigationBar)
            .blur(radius: viewModel.showDatePicker ? 05 : 0)
            .modifier(DismissingKeyboard())
            
            if viewModel.showDatePicker{
                dateOfBirthPicker()
            }
        }
    }
    
    private func AddressView(value: Binding<String>)-> some View{
        return VStack(alignment: .leading, content: {
            
                HStack(spacing:0){
                    Text("Address")
                    Text("*")
                        .foregroundStyle(.red)
                }
                .font(.custom(FontContent.plusMedium, size: 17))
            
            
            HStack(spacing:0){
                
                Image("PersonalInfoLocation")
                    .padding(.trailing,5)
                    .frame(width: 24,height: 24)
                
                TextField(text: value) {
                    Text("Address")
                        .foregroundStyle(._7_C_7_C_80)
                }
                .keyboardType(.asciiCapable)
                .font(.custom(FontContent.plusRegular, size: 15))
                
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
    
    private var genderDropdownView: some View{
        VStack(alignment: .leading, spacing:0,
               content: {
            HStack(spacing:0){
                Text("Gender")
                Text("*")
                    .foregroundStyle(.red)
            }
            .frame(height: 21)
            .font(.custom(FontContent.plusMedium, size: 17))
            .padding(.bottom,10)
            
            DropDownView(
                selectedValue: viewModel.personalInfoData.gender,
                placeHolder: "Select",
                showDropDown: genderDropShow,
                values: AppConstants.genderArray) { value in
                    viewModel.personalInfoData.gender = value
                }onShowValue: {
                    genderDropShow = !genderDropShow
                    languageDropShow = false
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
            .font(.custom(FontContent.plusMedium, size: 17))
            .padding(.bottom,10)
            
            DropDownView(
                selectedValue: viewModel.personalInfoData.language,
                placeHolder: "Select",
                showDropDown: languageDropShow,
                values: AppConstants.languageSpeakingArray) { value in
                    viewModel.personalInfoData.language = value
                }onShowValue: {
                    languageDropShow = !languageDropShow
                    genderDropShow = false
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
        DateTimePickerScreenView(
            formate: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'",
            range: nil,
            rangeThrough: ...Date(),
            valueStr: { value in
                viewModel.personalInfoData.dob = value
                viewModel.showDatePicker = !viewModel.showDatePicker
            },
            displayedComponents: .date, cancelAction: {
                viewModel.showDatePicker = false
                viewModel.dateOfBirthSelected = true
            }
        )
    }
    
    private func selectionViewWithHeader(leftIcone: String?, rightIcon: String?, value:String?,title: String?, placeHolder: String)-> some View{
        VStack(alignment: .leading, content: {
            if let title{
                HStack(spacing:0){
                    Text(title)
                    Text("*")
                        .foregroundStyle(.red)
                }
                .font(.custom(FontContent.plusMedium, size: 17))
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
                .font(.custom(FontContent.plusMedium, size: 17))
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
