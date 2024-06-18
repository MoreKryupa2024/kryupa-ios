//
//  AddNewProfileScreenView.swift
//  Kryupa
//
//  Created by Hemant Singh Rajput on 14/06/24.
//

import SwiftUI

struct AddNewProfileScreenView: View {
    
    @State var selectedSection = 0
    
    @StateObject private var viewModel = AddNewProfileScreenViewModel()
    
    var body: some View {
        ZStack{
            VStack{
                HeaderView(title: "Profile",showBackButton: true)
                ScrollView{
                    SegmentView
                    switch selectedSection{
                    case 1: 
                        EmergencyInfoView
                            .padding(.horizontal,24)
                            .padding(.top,24)
                        
                    case 2:
                        MedicalInfoView
                            .padding(.horizontal,24)
                            .padding(.top,24)
                        
                    default :
                        PersonalInfoView
                            .padding(.horizontal,24)
                            .padding(.top,24)
                    }
                }
                .scrollIndicators(.hidden)
            }
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
    private var medicalConditionView: some View{
        
        VStack(alignment: .leading){
            HStack(spacing:0){
                Text("Medical Condition")
                Text("*")
                    .foregroundStyle(.red)
            }
            .font(.custom(FontContent.plusMedium, size: 17))
        }
    }
    
    
    private var mobilityLevelView: some View{
        VStack(alignment: .leading, spacing:0,
               content: {
            HStack(spacing:0){
                Text("Mobility Level")
            }
            .frame(height: 21)
            .font(.custom(FontContent.plusMedium, size: 17))
            .padding(.bottom,10)
            
            DropDownView(
                selectedValue: viewModel.mobilityLevel,
                placeHolder: "Select",
                values: AppConstants.mobilityLevelArray) { value in
                    viewModel.mobilityLevel = value
                }
        })
    }
    
    private var medicalConditionDropdownView: some View{
        VStack(alignment: .leading, spacing:0,
               content: {
            medicalConditionView
                .padding(.bottom,10)
            DropDownWithCheckBoxView(
                selectedValue: viewModel.medicalConditionDropDownSelected,
                placeHolder: "View More",
                values: AppConstants.medicalConditionArray) { value in
                    viewModel.medicalConditionDropDownSelected = value
                }
                
        })
        .padding(.bottom,-10)
//        .padding(.top,10)
    }
    
    private var MedicalInfoView: some View{
        VStack(spacing: 25,
               content: {
            
            medicalConditionDropdownView
            
            if viewModel.medicalConditionDropDownSelected.contains("Other"){
                textFieldViewWithHeader(
                    title: "Other",
                    placeHolder: "(Max 100 words)",
                    value: $viewModel.medicalConditionSelected,
                    keyboard: .asciiCapable
                )
            }
            
            textFieldViewWithHeader(
                title: "Allergies",
                placeHolder: "Enter allergies (if you have any)",
                value: $viewModel.allergiesValue,
                keyboard: .asciiCapable
            )
            
            mobilityLevelView
            
            HStack{
                
                Spacer()
                SaveButton
                    .asButton(.press) {
                        viewModel.dataMedicalChecks { alertStr in
                            presentAlert(title: "Kryupa", subTitle: alertStr)
                        } next: { param in
                            var params = [String:Any]()
                            params["medicalInfo"] = param
                            
                        }
                    }
            }
        })
    }
    
    
    //MARK: Send Code Button View
    private var SaveButton: some View {
        HStack{
            Text("Save")
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
                values: AppConstants.languageSpeakingArray) { value in
                    viewModel.personalInfoData.language = value
                }
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
                values: AppConstants.genderArray) { value in
                    viewModel.personalInfoData.gender = value
                }
        })
        .padding(.bottom,-10)
    }
    
    
    //MARK: Mobile Number Header Title View
    private var mobileNumberHeaderTitleView: some View{
        HStack(spacing:0){
            Text("Enter Phone No.")
                .foregroundStyle(.appMain)
            
            Text("*")
                .foregroundStyle(.red)
            Spacer()
        }
        .font(.custom(FontContent.plusMedium, size: 17))
        .multilineTextAlignment(.center)
    }
    
    //MARK: Mobile Number Field View
    private var mobileNumberFieldView: some View{
        HStack(spacing:3) {
            Image("flagDemo")
                .frame(width: 20, height: 20)
                .padding(.leading,10)
            
            
            Text("+1")
                .font(.custom(FontContent.plusRegular, size: 15))
                .foregroundStyle(._444446)
            
            Image("DropDownDrackGray")
                .resizable()
                .frame(width: 16,height: 16)
            
            TextField(text: $viewModel.number) {
                Text("123454321")
                    .foregroundStyle(._7_C_7_C_80)
            }
            .padding(.trailing, 10)
            .keyboardType(.numberPad)
            .frame(height: 44)
            .font(.custom(FontContent.plusRegular, size: 15))
        }
        .background{
            RoundedRectangle(
                cornerRadius: 8
            )
            .stroke(lineWidth: 1)
            .foregroundStyle(.D_1_D_1_D_6)
        }
        .frame(height: 44)
    }
    
    private var relationDropdownView: some View{
        VStack(alignment: .leading, spacing:0,
               content: {
            HStack(spacing:0){
                Text("Relation")
                Text("*")
                    .foregroundStyle(.red)
            }
            .frame(height: 21)
            .font(.custom(FontContent.plusMedium, size: 17))
            .padding(.bottom,10)
            
            DropDownView(
                selectedValue: viewModel.relation,
                placeHolder: "Select",
                values: AppConstants.relationArray) { value in
                    viewModel.relation = value
                }
        })
    }
    
    
    private var EmergencyInfoView: some View{
        VStack(spacing: 25,
               content: {
            
            textFieldViewWithHeader(
                title: "Legal Name",
                placeHolder: "Input text",
                value: $viewModel.name,
                keyboard: .asciiCapable
            )
            
            relationDropdownView
            
            textFieldViewWithHeader(
                title: "Email",
                placeHolder: "Email",
                value: $viewModel.email,
                keyboard: .asciiCapable
            )
            
            
            VStack{
                mobileNumberHeaderTitleView
                mobileNumberFieldView
            }
            
            
            HStack{
                
                Spacer()
                SaveButton
                    .asButton(.press) {
                        viewModel.dataEmergancyChecks(alert: {alertStr in
                            presentAlert(title: "Kryupa", subTitle: alertStr)
                        }, next: { param in
                            var parameter = [String:Any]()
                            parameter["emergencyContact"] = param
                            
                        })
                    }
            }
        })
    }
    
    private var PersonalInfoView:some View{
        VStack(spacing: 25,
               content: {
            textFieldViewWithHeader(title: "Legal Name", placeHolder: "Name",value: $viewModel.personalInfoData.name.toUnwrapped(defaultValue: ""),keyboard: .asciiCapable)
            
            selectionViewWithHeader(
                leftIcone: nil,
                rightIcon: "PersonalInfoCalender",
                value: viewModel.dateOfBirthSelected ? viewModel.dateFormatter() : "",
                title: "Date Of Birth",
                placeHolder: "Select"
            )
            .background()
            .asButton(){
                viewModel.dateOfBirthSelected = true
                viewModel.showDatePicker = !viewModel.showDatePicker
            }
            
            if viewModel.showDatePicker{
                dateOfBirthPicker()
            }
            
            genderDropdownView
            
            languageDropdownView
            
            selectionViewWithHeader(leftIcone: "PersonalInfoLocation", rightIcon: nil, value: viewModel.personalInfoData.address, title: "Address", placeHolder: "Input text")
            
            HStack{
                textFieldViewWithHeader(title: nil, placeHolder: "City",value: $viewModel.personalInfoData.city.toUnwrapped(defaultValue: ""),keyboard: .asciiCapable)
                textFieldViewWithHeader(title: nil, placeHolder: "State",value: $viewModel.personalInfoData.state.toUnwrapped(defaultValue: ""),keyboard: .asciiCapable)
                
            }
            
            textFieldViewWithHeader(title: nil, placeHolder: "Country",value: $viewModel.personalInfoData.country.toUnwrapped(defaultValue: ""),keyboard: .asciiCapable)
            
            
            HStack{
                Spacer()
                SaveButton
                    .asButton(.press) {
                        viewModel.customerDataChecks { alertStr in
                            presentAlert(title: "Kryupa", subTitle: alertStr)
                        } next: { param in
//                            router.showScreen(.push) { rout in
//                                ExperienceandSkillsView(parameters: param)
//                            }
                        }
                    }
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
    
    
    private func textFieldViewWithHeader(title:String?, placeHolder: String, value: Binding<String>,keyboard: UIKeyboardType)-> some View{
        VStack(alignment: .leading, content: {
            if let title{
                HStack(spacing:0){
                    Text(title)
                    Text("*")
                        .foregroundStyle(.red)
                }
                .font(.custom(FontContent.plusMedium, size: 17))
            }
            TextField(text: value) {
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
    
    private var SegmentView: some View{
        
        Picker("Profile", selection: $selectedSection) {
            Text("Personal Info")
                .tag(0)
                .font(.custom(FontContent.plusRegular, size: 12))

            Text("Emergency")
                .tag(1)
                .font(.custom(FontContent.plusRegular, size: 12))
            
            Text("Medical")
                .tag(2)
                .font(.custom(FontContent.plusRegular, size: 12))
        }
        .pickerStyle(.segmented)
        .padding(.horizontal, 24)
        .padding(.top, 20)
        
    }
}

#Preview {
    AddNewProfileScreenView()
}
