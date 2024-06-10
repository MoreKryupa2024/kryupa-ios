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
    
    
    var body: some View {
        ScrollView{
            VStack(spacing:0){
                ZStack(alignment:.leading){
                    RoundedRectangle(cornerRadius: 4)
                        .foregroundStyle(.E_5_E_5_EA)
                        .frame(height: 4)
                    RoundedRectangle(cornerRadius: 4)
                        .foregroundStyle(.appMain)
                        .frame(width: 196,height: 4)
                }
                .padding([.leading,.trailing],24)
                
                
                Text("Health Information")
                    .font(.custom(FontContent.besMedium, size: 22))
                    .frame(height: 28)
                    .padding(.top,30)
                
                    
                    medicalConditionView
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .padding([.leading,.trailing,.top],24)
                
                VStack(spacing: 25,
                       content: {
                    
                    medicalConditionDropdownView
                    
                    
                    
                    textFieldViewWithHeader(
                        title: "Allergies",
                        placeHolder: "Enter allergies (if you have any)",
                        value: $viewModel.allergiesValue,
                        keyboard: .asciiCapable
                    )
                    .onTapGesture {
                        
                    }
                    
                    mobilityLevelView
                    
                    HStack{
                        previousButton
                            .asButton(.press) {
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
                                    router.showScreen(.push) { rout in
                                        PreferenceCareSeekarView(parameters: params)
                                    }
                                }
                            }
                    }
                })
                .padding(.top,10)
                .padding([.leading,.trailing],24)
                
                
            }
        }
        .scrollIndicators(.hidden)
        .toolbar(.hidden, for: .navigationBar)
        .modifier(DismissingKeyboard())
    }
    
    
    private var medicalConditionView: some View{
        
        VStack(alignment: .leading){
            HStack(spacing:0){
                Text("Medical Condition")
            }
            .font(.custom(FontContent.plusRegular, size: 17))
            
            ZStack{
                NonLazyVGrid(columns: 3, alignment: .leading, spacing: 10, items: AppConstants.medicalConditionArray) { condition in
                    if let condition{
                        PillView(
                            isSelected: viewModel.medicalConditionSelected == condition,
                            name: condition
                        )
                        .asButton(.press) {
                            viewModel.medicalConditionSelected = condition
                        }
                    }else{
                        EmptyView()
                    }
                }
            }
        }
    }
    
    private func textFieldViewWithHeader(title:String?, placeHolder: String, value: Binding<String>,keyboard: UIKeyboardType)-> some View{
        VStack(alignment: .leading, content: {
            if let title{
                HStack(spacing:0){
                    Text(title)
                }
                .font(.custom(FontContent.plusMedium, size: 16))
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
    
    //MARK: Send Code Button View
    private var previousButton: some View {
        HStack{
            Text("Previous")
                .font(.custom(FontContent.plusMedium, size: 16))
                .padding([.top,.bottom], 16)
                .padding([.leading,.trailing], 40)
        }
        .background(
            ZStack{
                Capsule(style: .circular)
                    .stroke(lineWidth: 1)
                    .fill(.appMain)
            }
        )
        .foregroundColor(.appMain)
    }
    
    
    private var mobilityLevelView: some View{
        VStack(alignment: .leading, spacing:0,
               content: {
            HStack(spacing:0){
                Text("Mobility Level")
            }
            .frame(height: 21)
            .font(.custom(FontContent.plusMedium, size: 16))
            .padding(.bottom,20)
            
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
            DropDownView(
                selectedValue: viewModel.medicalConditionDropDownSelected,
                placeHolder: "View More",
                values: AppConstants.medicalConditionArray) { value in
                    viewModel.medicalConditionDropDownSelected = value
                }
                
        })
        .padding(.top,10)
    }
}

#Preview {
    HealthInformationSeekerView()
}
