//
//  AddNewProfileScreenView.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 14/06/24.
//

import SwiftUI
import SwiftfulUI

struct AddNewProfileScreenView: View {
    
    @Environment(\.router) var router
    @State var selectedSection = 0
    
    @StateObject var viewModel = AddNewProfileScreenViewModel()
    
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
            .blur(radius: viewModel.showDatePicker ? 30 : 0)
            .onTapGesture {
                print("No access!")
            }
            
            if viewModel.isLoading{
                LoadingView()
            }
            
            if viewModel.showDatePicker{
                dateOfBirthPicker()
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
                Text("*")
                    .foregroundStyle(.red)
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
                    keyboard: .asciiCapable, showRed: true
                )
            }
            
            textFieldViewWithHeader(
                title: "Allergies",
                placeHolder: "Enter allergies (if you have any)",
                value: $viewModel.allergiesValue,
                keyboard: .asciiCapable,
                showRed: false
            )
            
            mobilityLevelView
            
            
            HStack{
                
                Spacer()
                SaveButton
                    .asButton(.press) {
                        viewModel.dataMedicalChecks { alertStr in
                            presentAlert(title: "Kryupa", subTitle: alertStr)
                        } next: { param in
                            
                            if viewModel.profileID == "" {
                                viewModel.param["mediaclInfo"] = param

                                viewModel.createProfile {
                                    router.showScreen(.push) { rout in
                                        AccountView()
                                    }
                                } errorMsg: { msg in
                                    presentAlert(title: "Kryupa", subTitle: msg)
                                }

                            }
                            else {
                                var newParam = param
                                newParam["medicalInfoId"] = viewModel.medicalID
                                viewModel.param["mediaclInfo"] = newParam
                                viewModel.updateProfile {
                                    router.dismissScreen()
                                }
                            }
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
    
    private var NextButton: some View {
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
            displayedComponents: .date
        )
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
        .onChange(of: viewModel.number) { oldValue, newValue in
            if viewModel.number.count > 10{
                viewModel.number.removeLast()
            }
        }
    }
    
    private var relationPersonalDropdownView: some View{
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
                selectedValue: viewModel.relationPersonal,
                placeHolder: "Select",
                values: AppConstants.relationArray) { value in
                    viewModel.relationPersonal = value
                }
        })
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
                keyboard: .asciiCapable, showRed: true
            )
            
            relationDropdownView
            
            textFieldViewWithHeader(
                title: "Email",
                placeHolder: "Email",
                value: $viewModel.email,
                keyboard: .asciiCapable, showRed: true
            )
            
            
            VStack{
                mobileNumberHeaderTitleView
                mobileNumberFieldView
            }
            
            
            HStack{
                
                Spacer()
                NextButton
                    .asButton(.press) {
                        viewModel.dataEmergancyChecks(alert: {alertStr in
                            presentAlert(title: "Kryupa", subTitle: alertStr)
                        }, next: { param in
                            viewModel.param["emergencyContact"] = param
                            selectedSection = selectedSection + 1
                        })
                    }
            }
        })
    }
    
    private var PersonalInfoView:some View{
        VStack(spacing: 25,
               content: {
            
            relationPersonalDropdownView
            
            textFieldViewWithHeader(title: "Full Legal Name", placeHolder: "Name",value: $viewModel.personalInfoData.name.toUnwrapped(defaultValue: ""),keyboard: .asciiCapable, showRed: true)
            
            selectionViewWithHeader(
                leftIcone: nil,
                rightIcon: "PersonalInfoCalender",
                value: viewModel.dateOfBirthSelected ? viewModel.personalInfoData.dob?.convertDateFormater(beforeFormat: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", afterFormat: "dd-MM-yyyy") : "",
                title: "Date Of Birth",
                placeHolder: "Select"
            )
            .background()
            .asButton(){
                viewModel.dateOfBirthSelected = true
                viewModel.showDatePicker = !viewModel.showDatePicker
            }
            
            genderDropdownView
            
            languageDropdownView
            
            selectionViewWithHeader(leftIcone: "PersonalInfoLocation", rightIcon: nil, value: viewModel.personalInfoData.address, title: "Address", placeHolder: "Input text")
            
            HStack{
                textFieldViewWithHeader(title: nil, placeHolder: "City",value: $viewModel.personalInfoData.city.toUnwrapped(defaultValue: ""),keyboard: .asciiCapable, showRed: true)
                textFieldViewWithHeader(title: nil, placeHolder: "State",value: $viewModel.personalInfoData.state.toUnwrapped(defaultValue: ""),keyboard: .asciiCapable, showRed: true)
                
            }
            
            textFieldViewWithHeader(title: nil, placeHolder: "Country",value: $viewModel.personalInfoData.country.toUnwrapped(defaultValue: ""),keyboard: .asciiCapable, showRed: true)
            
            
            HStack{
                Spacer()
                NextButton
                    .asButton(.press) {
                        viewModel.customerDataChecks { alertStr in
                            presentAlert(title: "Kryupa", subTitle: alertStr)
                        } next: { param in
                            
                            viewModel.param["personalInfo"] = param
                            selectedSection = selectedSection + 1
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
    
    
    private func textFieldViewWithHeader(title:String?, placeHolder: String, value: Binding<String>,keyboard: UIKeyboardType,showRed : Bool )-> some View{
        VStack(alignment: .leading, content: {
            if let title{
                HStack(spacing:0){
                    Text(title)
                    if showRed{
                        Text("*")
                            .foregroundStyle(.red)
                    }
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
        
        HStack(spacing: 0) {
            SegmentTextView(title: "Personal Info", select: selectedSection == 0)
                .asButton {
                    selectedSection = 0
                }
            SegmentTextView(title: "Emergency", select: selectedSection == 1)
                .asButton {
                    selectedSection = 1
                }
            SegmentTextView(title: "Medical", select: selectedSection == 2)
                .asButton {
                    selectedSection = 2
                }
        }
        .padding(2)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .foregroundStyle(.E_5_E_5_EA)
        )
        .padding(.horizontal, 24)
        .padding(.top, 20)
        
    }
    
    private func SegmentTextView(title: String, select: Bool) -> some View{
        Text(title)
            .foregroundStyle((select ? .appMain : ._7_C_7_C_80))
            .frame(maxWidth: .infinity)
            .font(.custom(FontContent.plusMedium, size: 12))
            .frame(height: 30)
            .background(
                RoundedRectangle(cornerRadius: 6)
                    .foregroundStyle(select ? .white : .E_5_E_5_EA)
            )
    }
}

#Preview {
    AddNewProfileScreenView()
}
