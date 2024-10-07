//
//  HealthInformationSeekerView.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 20/05/24.
//

import SwiftUI
import SwiftfulUI

struct HealthInformationSeekerView: View {
    
    @Environment(\.router) var router
    var parameters:[String:Any] = [String:Any]()
    
    @StateObject private var viewModel = HealthInformationSeekerViewModel()
    @State var medicalConditionDownShow:Bool = Bool()
    @State var mobilityLevelDownShow:Bool = Bool()
    
    var body: some View {
        
            VStack(spacing:0){
                ZStack(alignment:.leading){
                    RoundedRectangle(cornerRadius: 4)
                        .foregroundStyle(.E_5_E_5_EA)
                        .frame(height: 4)
                    RoundedRectangle(cornerRadius: 4)
                        .foregroundStyle(.appMain)
                        .frame(width: 196,height: 4)
                }
                .padding(.horizontal,24)
                .padding(.top,20)
                
                
                Text("Health Information")
                    .font(.custom(FontContent.besMedium, size: 22))
                    .frame(height: 28)
                    .padding(.top,30)
                
                ScrollView{
                    medicalConditionView
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .padding([.leading,.trailing,.top],24)
                
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
                        .onTapGesture {
                            medicalConditionDownShow = false
                        }
                    }
                    
                    textFieldViewWithHeader(
                        title: "Allergies",
                        placeHolder: "Enter allergies (if you have any)",
                        value: $viewModel.allergiesValue,
                        keyboard: .asciiCapable
                    )
                    
                    NeedHelpInView
                    
                    HStack{
                        previousButton
                            .asButton(.press) {
                                saveDefaultsData()
                                router.dismissScreen()
                            }
                        Spacer()
                        nextButton
                            .asButton(.press) {
                                viewModel.dataChecks { alertStr in
                                    presentAlert(title: "Kryupa", subTitle: alertStr)
                                } next: { param in
                                    var params = parameters
                                    params["medicalInfo"] = param
                                    saveDefaultsData()
                                    router.showScreen(.push) { rout in
                                        PreferenceCareSeekarView(parameters: params)
                                    }
                                }
                            }
                    }
                })
                .padding(.top,10)
                .padding(.horizontal,24)
            }
        }
        .scrollIndicators(.hidden)
        .toolbar(.hidden, for: .navigationBar)
        .modifier(DismissingKeyboard())
        .task {
            viewModel.allergiesValue = Defaults().healthInfo["allergies"] as? String ?? ""
            viewModel.canHelpInSelect = Defaults().healthInfo["mobility_level"] as? [String] ?? []
            viewModel.medicalConditionSelected = Defaults().healthInfo["other_disease_type"] as? String ?? ""
            viewModel.medicalConditionDropDownSelected = Defaults().healthInfo["disease_type"] as? [String] ?? []
        }
    }
    
    func saveDefaultsData(){
        Defaults().healthInfo = [
            "allergies": viewModel.allergiesValue,
            "mobility_level": viewModel.canHelpInSelect,
            "other_disease_type": viewModel.medicalConditionSelected,
            "disease_type": viewModel.medicalConditionDropDownSelected
        ]
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
    
    private func textFieldViewWithHeader(title:String?, placeHolder: String, value: Binding<String>,keyboard: UIKeyboardType)-> some View{
        VStack(alignment: .leading, content: {
            if let title{
                HStack(spacing:0){
                    Text(title)
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
    
    
    //MARK: Send Code Button View
    private var nextButton: some View {
        HStack{
            Text("Next")
                .font(.custom(FontContent.plusMedium, size: 16))
                .padding([.top,.bottom], 16)
        }
        .frame(width: 144)
        .background(
            ZStack{
                Capsule(style: .circular)
                    .fill(.appMain)
            }
        )
        .foregroundColor(.white)
        
    }
    
    //MARK: Send Code Button View
    private var previousButton: some View {
        HStack{
            Text("Previous")
                .font(.custom(FontContent.plusMedium, size: 16))
                .padding([.top,.bottom], 16)
        }
        .frame(width: 144)
        .background(
            ZStack{
                Capsule(style: .circular)
                    .stroke(lineWidth: 1)
                    .fill(.appMain)
            }
        )
        .foregroundColor(.appMain)
    }
    
    private var NeedHelpInView: some View{
        
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
            DropDownWithCheckBoxView(
                selectedValue: viewModel.medicalConditionDropDownSelected,
                placeHolder: "View More",
                showDropDown: medicalConditionDownShow,
                values: AppConstants.medicalConditionArray) { value in
                    viewModel.medicalConditionDropDownSelected = value
                }onShowValue: {
                    medicalConditionDownShow = !medicalConditionDownShow
                    mobilityLevelDownShow = false
                }
                
        })
        .padding(.bottom,-10)
    }
}

#Preview {
    HealthInformationSeekerView()
}
