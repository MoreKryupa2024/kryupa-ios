//
//  AddNewProfileScreenView.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 14/06/24.
//

import SwiftUI
import SwiftfulUI

struct AddNewProfileScreenView: View {
    @State var openPlacePicker = false
    @Environment(\.router) var router
    @State var selectedSection = 0
    
    @StateObject var viewModel = AddNewProfileScreenViewModel()
    @State var mobilityLevelDownShow:Bool = Bool()
    @State var distanceDownShow:Bool = Bool()
    @State var languageDownShow:Bool = Bool()
    @State var genderDownShow:Bool = Bool()
    @State var relationPersonalDownShow:Bool = Bool()
    @State var relationDownShow:Bool = Bool()
    @State var medicalConditionDownShow:Bool = Bool()
    
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
            .blur(radius: viewModel.showDatePicker ? 05 : 0)
            
            if viewModel.isLoading{
                LoadingView()
            }
            
            if viewModel.showDatePicker{
                dateOfBirthPicker()
            }
        }
        .task {
            NotificationCenter.default.addObserver(forName: .showInboxScreen, object: nil, queue: nil,
                                                 using: self.setChatScreen)
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    private func setChatScreen(_ notification: Notification){
        router.dismissScreenStack()
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
        VStack(alignment: .leading){
            HStack(spacing:0){
                Text("Need Help In")
            }
            .font(.custom(FontContent.plusMedium, size: 17))
            
            ZStack{
                NonLazyVGrid(columns: 1, alignment: .leading, spacing: 10, items: AppConstants.canHelpInArray) { service in
                    if let service{
                        CheckBoxView(
                            isSelected: !(viewModel.canHelpInSelect).contains(service),
                            name: service
                        )
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .asButton(.press) {
                            if (viewModel.canHelpInSelect).contains(service){
                                viewModel.canHelpInSelect = (viewModel.canHelpInSelect).filter{ $0 != service}
                            } else {
                                viewModel.canHelpInSelect.append(service)
                            }
                            viewModel.canHelpInSelect = (viewModel.canHelpInSelect).sorted(by: { $0 < $1 })
                        }
                    }else{
                        EmptyView()
                    }
                }
            }
        }
    }
    
    private var medicalConditionDropdownView: some View{
        VStack(alignment: .leading, spacing:0,
               content: {
            medicalConditionView
                .padding(.bottom,10)
            DropDownWithCheckBoxView(
                selectedValue: viewModel.medicalConditionDropDownSelected,
                placeHolder: "View More",
                showDropDown: medicalConditionDownShow,
                values: AppConstants.medicalConditionArray) { value in
                    viewModel.medicalConditionDropDownSelected = value
                }onShowValue: {
                    medicalConditionDownShow = !medicalConditionDownShow
                    mobilityLevelDownShow = false
                    distanceDownShow = false
                    languageDownShow = false
                    genderDownShow = false
                    relationPersonalDownShow = false
                    relationDownShow = false
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
                .onTapGesture {
                    medicalConditionDownShow = false
                }
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
                                    router.dismissScreen()
                                } errorMsg: { msg in
                                    presentAlert(title: "Kryupa", subTitle: msg)
                                }
                            }
                            else {
                                updateData()
                            }
                        }
                    }
            }
        })
    }
    
    func updateData(){
        viewModel.customerDataChecks { alertStr in
            presentAlert(title: "Kryupa", subTitle: alertStr)
        } next: { param in
            viewModel.param["personalInfo"] = param
            viewModel.dataEmergancyChecks(alert: { alertStr in
                presentAlert(title: "Kryupa", subTitle: alertStr)
            }, next: { param in
                viewModel.param["emergencyContact"] = param
                viewModel.dataMedicalChecks { alertStr in
                    presentAlert(title: "Kryupa", subTitle: alertStr)
                } next: { param in
                    var newParam = param
                    newParam["medicalInfoId"] = viewModel.medicalID
                    viewModel.param["mediaclInfo"] = newParam
                    viewModel.updateProfile {
                        router.dismissScreen()
                    }
                }
            })
        }
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
            givenDate: viewModel.date,
            formate: "yyyy-MM-dd",
            range: nil,
            rangeThrough: ...Date(),
            valueStr: { value in
                viewModel.personalInfoData.dob = value
                viewModel.showDatePicker = !viewModel.showDatePicker
            },
            displayedComponents: .date, cancelAction:  {
                viewModel.showDatePicker = false
                viewModel.dateOfBirthSelected = true
            })
        .padding(.horizontal,24)
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
                showDropDown: languageDownShow,
                values: AppConstants.languageSpeakingArray) { value in
                    viewModel.personalInfoData.language = value
                }onShowValue: {
                    languageDownShow = !languageDownShow
                    mobilityLevelDownShow = false
                    distanceDownShow = false
                    genderDownShow = false
                    relationPersonalDownShow = false
                    relationDownShow = false
                    medicalConditionDownShow = false
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
                showDropDown: genderDownShow,
                values: AppConstants.genderArray) { value in
                    viewModel.personalInfoData.gender = value
                }onShowValue: {
                    genderDownShow = !genderDownShow
                    languageDownShow = false
                    mobilityLevelDownShow = false
                    distanceDownShow = false
                    relationPersonalDownShow = false
                    relationDownShow = false
                    medicalConditionDownShow = false
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
            
//            Image("DropDownDrackGray")
//                .resizable()
//                .frame(width: 16,height: 16)
            
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
            viewModel.number = viewModel.number.applyPatternOnNumbers(pattern: "(###) ###-####", replacementCharacter: "#")
            if viewModel.number.count > 14{
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
                showDropDown: relationPersonalDownShow,
                values: AppConstants.relationArray) { value in
                    viewModel.relationPersonal = value
                }onShowValue: {
                    relationPersonalDownShow = !relationPersonalDownShow
                    genderDownShow = false
                    languageDownShow = false
                    mobilityLevelDownShow = false
                    distanceDownShow = false
                    relationDownShow = false
                    medicalConditionDownShow = false
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
                showDropDown: relationDownShow,
                values: AppConstants.relationArray) { value in
                    viewModel.relation = value
                }onShowValue: {
                    relationDownShow = !relationDownShow
                    relationPersonalDownShow = false
                    genderDownShow = false
                    languageDownShow = false
                    mobilityLevelDownShow = false
                    distanceDownShow = false
                    medicalConditionDownShow = false
                }
        })
    }
    
    private var EmergencyInfoView: some View{
        VStack(spacing: 25,
               content: {
            
            textFieldViewWithHeader(
                title: "Preferred Name",
                placeHolder: "Full Preferred Name",
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
                if viewModel.profileID == "" {
                    NextButton
                        .asButton(.press) {
                            viewModel.dataEmergancyChecks(alert: {alertStr in
                                presentAlert(title: "Kryupa", subTitle: alertStr)
                            }, next: { param in
                                viewModel.param["emergencyContact"] = param
                                selectedSection = selectedSection + 1
                            })
                        }
                }else{
                    SaveButton
                        .asButton(.press) {
                            updateData()
                        }
                }
            }
        })
    }
    
    
    
    private var PersonalInfoView:some View{
        VStack(spacing: 25,
               content: {
            
            relationPersonalDropdownView
            
            textFieldViewWithHeader(title: "First Name", placeHolder: "First Name",value: $viewModel.personalInfoData.name.toUnwrapped(defaultValue: ""),keyboard: .asciiCapable, showRed: true)
            
            textFieldViewWithHeader(title: "Last Name", placeHolder: "Last Name",value: $viewModel.personalInfoData.lastName.toUnwrapped(defaultValue: ""),keyboard: .asciiCapable, showRed: true)
            
            selectionViewWithHeader(
                leftIcone: nil,
                rightIcon: "PersonalInfoCalender",
                value: viewModel.dateOfBirthSelected ? viewModel.personalInfoData.dob?.convertDateFormater(beforeFormat: "YYYY-MM-dd", afterFormat: "MM-dd-yyyy") : "",
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
                    textFieldViewWithHeader(title: nil, placeHolder: "Zip Code",value: $viewModel.personalInfoData.postalCode.toUnwrapped(defaultValue: ""),keyboard: .numberPad, showRed: true)
                        .disabled(true)
                        .background{
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundStyle(.D_1_D_1_D_6)
                                .frame(height: 48)
                                .offset(y:5)
                        }
//                        .onChange(of: viewModel.personalInfoData.postalCode) { oldValue, newValue in
//                            if (viewModel.personalInfoData.postalCode ?? "").count > 5{
//                                viewModel.personalInfoData.postalCode = "\((viewModel.personalInfoData.postalCode ?? "").prefix(5))"
//                            }else{
//                                if (viewModel.personalInfoData.postalCode ?? "").count == 5{
//                                    viewModel.getAddress()
//                                }else{
//                                    viewModel.personalInfoData.city = ""
//                                    viewModel.personalInfoData.state = ""
//                                    viewModel.personalInfoData.country = ""
//                                    viewModel.personalInfoData.zipError = ""
//                                }
//                            }
//                        }
                    textFieldViewWithHeader(title: nil, placeHolder: "City",value: $viewModel.personalInfoData.city.toUnwrapped(defaultValue: ""),keyboard: .asciiCapable, showRed: true)
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
                textFieldViewWithHeader(title: nil, placeHolder: "State",value: $viewModel.personalInfoData.state.toUnwrapped(defaultValue: ""),keyboard: .asciiCapable, showRed: true)
                    .disabled(true)
                    .background{
                        RoundedRectangle(cornerRadius: 8)
                        .foregroundStyle(.D_1_D_1_D_6)
                        .frame(height: 48)
                        .offset(y:5)
                    }
                
                textFieldViewWithHeader(title: nil, placeHolder: "Country",value: $viewModel.personalInfoData.country.toUnwrapped(defaultValue: ""),keyboard: .asciiCapable, showRed: true)
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
                if viewModel.profileID == "" {
                    NextButton
                        .asButton(.press) {
                            viewModel.customerDataChecks { alertStr in
                                presentAlert(title: "Kryupa", subTitle: alertStr)
                            } next: { param in
                                viewModel.param["personalInfo"] = param
                                selectedSection = selectedSection + 1
                            }
                        }
                }else{
                    SaveButton
                        .asButton(.press) {
                            updateData()
                        }
                }
            }
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
