//
//  PersonalInformationScreenView.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 17/05/24.
//

import SwiftUI
import SwiftfulUI

struct PersonalInformationScreenView: View {
    @State var openPlacePicker = false
    @Environment(\.router) var router
    @StateObject private var viewModel = PersonalInformationScreenViewModel()
    @State var genderDropDownShow: Bool = false
    @State var languageDropDownShow: Bool = false
    
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
                
                
                RoundedRectangle(cornerRadius: 5)
                    .overlay(content: {
                        Text("Background checks are on us, No charges involved!")
                            .font(.custom(FontContent.plusMedium, size: 12))
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.appMain)
                    })
                    .frame(height: 35)
                    .foregroundStyle(.FAE_9_A_2)
                    .padding(.top,30)
                
                HStack(content: {
                    Image("PersonalInformationMagic")
                    Spacer()
                })
                .padding(.top,-92)
                .padding(.leading,-24)
                ScrollView {
                    VStack(spacing: 25,
                           content: {
                        textFieldViewWithHeader(title: "First Name", placeHolder: "First Name",value: $viewModel.personalInfoData.name,keyboard: .asciiCapable)
                        
                        textFieldViewWithHeader(title: "Last Name", placeHolder: "Last Name",value: $viewModel.personalInfoData.lastName,keyboard: .asciiCapable)
                        
                        selectionViewWithHeader(
                            leftIcone: nil,
                            rightIcon: "PersonalInfoCalender",
                            value: viewModel.dateOfBirthSelected ? viewModel.personalInfoData.dob?.convertDateFormater(beforeFormat: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", afterFormat: "MM-dd-yyyy") : "",
                            title: "Date Of Birth",
                            placeHolder: "Select"
                        )
                        .background()
                        .asButton(){
                            viewModel.dateOfBirthSelected = true
                            viewModel.showDatePicker = !viewModel.showDatePicker
                        }
                        
                        
                        genderDropdownView
                        
                        textFieldViewWithHeader(title: "SSN", placeHolder: "Number",value: $viewModel.personalInfoData.ssn,keyboard: .numberPad)
                            .onChange(of: viewModel.personalInfoData.ssn) {
                                
                                if (viewModel.personalInfoData.ssn?.count ?? 0) > 11{
                                    viewModel.personalInfoData.ssn = String(viewModel.personalInfoData.ssn?.prefix(11) ?? "")
                                }else if (viewModel.personalInfoData.ssn?.count ?? 0) == 4 && (viewModel.personalInfoData.ssn?.suffix(1) ?? "") != "-"{
                                    viewModel.personalInfoData.ssn = "\(String(viewModel.personalInfoData.ssn?.prefix(3) ?? ""))-\(String(viewModel.personalInfoData.ssn?.suffix(1) ?? ""))"
                                }else if (viewModel.personalInfoData.ssn?.count ?? 0) == 7 && (viewModel.personalInfoData.ssn?.suffix(1) ?? "") != "-"{
                                    viewModel.personalInfoData.ssn = "\(String(viewModel.personalInfoData.ssn?.prefix(6) ?? ""))-\(String(viewModel.personalInfoData.ssn?.suffix(1) ?? ""))"
                                }else if (viewModel.personalInfoData.ssn?.count ?? 0) == 4 && (viewModel.personalInfoData.ssn?.suffix(1) ?? "") == "-"{
                                    viewModel.personalInfoData.ssn = String(viewModel.personalInfoData.ssn?.prefix(3) ?? "")
                                }else if (viewModel.personalInfoData.ssn?.count ?? 0) == 7 && (viewModel.personalInfoData.ssn?.suffix(1) ?? "") == "-"{
                                    viewModel.personalInfoData.ssn = String(viewModel.personalInfoData.ssn?.prefix(6) ?? "")
                                }
                            }
                        
                        languageDropdownView
                        
                        AddressView(value: $viewModel.personalInfoData.address.toUnwrapped(defaultValue: ""))
                            .asButton {
                                openPlacePicker = true
                            }
                            .sheet(isPresented: $openPlacePicker) {
                                PlacePicker(address: $viewModel.personalInfoData.address.toUnwrapped(defaultValue: ""),
                                            country: $viewModel.personalInfoData.country.toUnwrapped(defaultValue: ""),
                                            state: $viewModel.personalInfoData.state.toUnwrapped(defaultValue: ""),
                                            city: $viewModel.personalInfoData.city.toUnwrapped(defaultValue: ""),
                                            latitude: $viewModel.personalInfoData.latitude.toUnwrapped(defaultValue: 0.0),
                                            postalCode: $viewModel.personalInfoData.postalCode.toUnwrapped(defaultValue: ""),
                                            longitude: $viewModel.personalInfoData.longitude.toUnwrapped(defaultValue: 0.0))
                            }
                        
                        VStack(alignment:.leading,spacing:5){
                            HStack{
                                textFieldViewWithHeader(title: nil, placeHolder: "Zip Code",value: $viewModel.personalInfoData.postalCode,keyboard: .numberPad)
                                    .disabled(true)
                                    .background{
                                        RoundedRectangle(cornerRadius: 8)
                                            .foregroundStyle(.D_1_D_1_D_6)
                                            .frame(height: 48)
                                            .offset(y:5)
                                    }
                                //                                    .onChange(of: viewModel.personalInfoData.postalCode) { oldValue, newValue in
                                //                                        if (viewModel.personalInfoData.postalCode ?? "").count > 5{
                                //                                            viewModel.personalInfoData.postalCode = "\((viewModel.personalInfoData.postalCode ?? "").prefix(5))"
                                //                                        }else{
                                //                                            if (viewModel.personalInfoData.postalCode ?? "").count == 5{
                                //                                                viewModel.getAddress()
                                //                                            }else{
                                //                                                viewModel.personalInfoData.city = ""
                                //                                                viewModel.personalInfoData.state = ""
                                //                                                viewModel.personalInfoData.country = ""
                                //                                                viewModel.personalInfoData.zipError = ""
                                //                                            }
                                //                                        }
                                //                                    }
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
                                    viewModel.dataChecks { alertStr in
                                        presentAlert(title: "Kryupa", subTitle: alertStr)
                                    } next: { param in
                                        saveDefaultsData()
                                        router.showScreen(.push) { rout in
                                            ExperienceandSkillsView(parameters: param)
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
            .task {
                viewModel.personalInfoData.language = Defaults().personalInfo["language"] as? String ?? ""
                viewModel.personalInfoData.dob = Defaults().personalInfo["dob"] as? String ?? ""
                viewModel.personalInfoData.gender = Defaults().personalInfo["gender"] as? String ?? ""
                viewModel.personalInfoData.latitude = Defaults().personalInfo["latitude"] as? Double ?? 0.0
                viewModel.personalInfoData.latitude = Defaults().personalInfo["longitude"] as? Double ?? 0.0
                viewModel.personalInfoData.address = Defaults().personalInfo["address"] as? String ?? ""
                viewModel.personalInfoData.postalCode = Defaults().personalInfo["zipcode"] as? String ?? ""
                viewModel.personalInfoData.city = Defaults().personalInfo["city"] as? String ?? ""
                viewModel.personalInfoData.state = Defaults().personalInfo["state"] as? String ?? ""
                viewModel.personalInfoData.name = Defaults().personalInfo["firstname"] as? String ?? ""
                viewModel.personalInfoData.lastName = Defaults().personalInfo["lastname"] as? String ?? ""
                viewModel.personalInfoData.country = Defaults().personalInfo["country"] as? String ?? ""
                viewModel.personalInfoData.ssn = Defaults().personalInfo["ssn_no"] as? String ?? ""
            }
            
            if viewModel.showDatePicker{
                dateOfBirthPicker()
            }
        }
    }
    
    func saveDefaultsData(){
        Defaults().personalInfo = ["language": viewModel.personalInfoData.language ?? "",
                                   "dob": viewModel.personalInfoData.dob ?? "",
                                   "gender": viewModel.personalInfoData.gender ?? "",
                                   "latitude": viewModel.personalInfoData.latitude ?? 0.0,
                                   "longitude": viewModel.personalInfoData.latitude ?? 0.0,
                                   "address": viewModel.personalInfoData.address ?? "",
                                   "zipcode": viewModel.personalInfoData.postalCode ?? "",
                                   "city": viewModel.personalInfoData.city ?? "",
                                   "state": viewModel.personalInfoData.state ?? "",
                                   "firstname":viewModel.personalInfoData.name ?? "",
                                   "lastname":viewModel.personalInfoData.lastName ?? "",
                                   "country": viewModel.personalInfoData.country ?? "",
                                   "ssn_no":viewModel.personalInfoData.ssn ?? ""]
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
                showDropDown: genderDropDownShow,
                values: AppConstants.genderArray) { value in
                    viewModel.personalInfoData.gender = value
                }onShowValue: {
                    genderDropDownShow = !genderDropDownShow
                    languageDropDownShow = false
                }
        })
        .padding(.bottom,-10)
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
                showDropDown: languageDropDownShow,
                values: AppConstants.languageSpeakingArray) { value in
                    viewModel.personalInfoData.language = value
                }onShowValue: {
                    languageDropDownShow = !languageDropDownShow
                    genderDropDownShow = false
                }
            
        })
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
                .disabled(true)
                
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
    PersonalInformationScreenView()
}
