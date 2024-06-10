//
//  EmergencyContactView.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 20/05/24.
//

import SwiftUI

struct EmergencyContactView: View {
    
    @Environment(\.router) var router
    var parameters:[String:Any] = [String:Any]()
    
    @StateObject private var viewModel = EmergencyContactViewModel()
    
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
                
                
                Text("Emergency Contact")
                    .font(.custom(FontContent.besMedium, size: 22))
                    .frame(height: 28)
                    .padding(.top,30)
                
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
                        previousButton
                            .asButton(.press) {
                                router.dismissScreen()
                            }
                        Spacer()
                        nextButton
                            .asButton(.press) {
                                viewModel.dataChecks(alert: {alertStr in
                                    presentAlert(title: "Kryupa", subTitle: alertStr)
                                }, next: { param in
                                    var parameter = parameters
                                    parameter["emergencyContact"] = param
                                    router.showScreen(.push) { rout in
                                        HealthInformationSeekerView(parameters: parameter)
                                    }
                                })
                            }
                    }
                })
                .padding(.top,30)
                .padding([.leading,.trailing],24)
                
                
            }
        }
        .scrollIndicators(.hidden)
        .toolbar(.hidden, for: .navigationBar)
        .modifier(DismissingKeyboard())
    }
    
    //MARK: Mobile Number Header Title View
    private var mobileNumberHeaderTitleView: some View{
        HStack(spacing:0){
            Text("Enter Phone No.")
                .font(.custom(FontContent.plusMedium, size: 16))
                .multilineTextAlignment(.center)
                .foregroundStyle(.appMain)
            Text("*")
                .font(.custom(FontContent.plusMedium, size: 16))
                .multilineTextAlignment(.center)
                .foregroundStyle(.red)
            Spacer()
        }
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
    
    
    private func textFieldViewWithHeader(title:String?, placeHolder: String, value: Binding<String>,keyboard: UIKeyboardType)-> some View{
        VStack(alignment: .leading, content: {
            if let title{
                HStack(spacing:0){
                    Text(title)
                    Text("*")
                        .foregroundStyle(.red)
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
    
    private var relationDropdownView: some View{
        VStack(alignment: .leading, spacing:0,
               content: {
            HStack(spacing:0){
                Text("Relation")
                Text("*")
                    .foregroundStyle(.red)
            }
            .frame(height: 21)
            .font(.custom(FontContent.plusMedium, size: 16))
            .padding(.bottom,10)
            
            DropDownView(
                selectedValue: viewModel.relation,
                placeHolder: "Select",
                values: AppConstants.relationArray) { value in
                    viewModel.relation = value
                }
        })
    }
}

#Preview {
    EmergencyContactView()
}
