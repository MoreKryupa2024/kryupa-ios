//
//  PreferenceView.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 20/05/24.
//

import SwiftUI
import SwiftfulUI

struct PreferenceView: View {
    
    @Environment(\.router) var router
    var parameters = [String:Any]()
    @StateObject private var viewModel = PreferenceViewModel()
    
    var body: some View {
        ZStack{
            VStack(spacing:0){
                ZStack(alignment:.top){
                    VStack(spacing:0){
                        
                        
                        ZStack(alignment:.leading){
                            RoundedRectangle(cornerRadius: 4)
                                .foregroundStyle(.E_5_E_5_EA)
                                .frame(height: 4)
                            RoundedRectangle(cornerRadius: 4)
                                .foregroundStyle(.appMain)
                                .frame(width: 236,height: 4)
                        }
                        .padding([.leading,.trailing],24)
                        
                        HStack{
                            Text("Preference")
                                .font(.custom(FontContent.besMedium, size: 22))
                            Image("infoIcone")
                                .asButton(.press) {
                                    viewModel.showPreference = !viewModel.showPreference
                                }
                        }
                        .frame(height: 28)
                        .padding(.top,30)
                        
                        ScrollView{
                            VStack(spacing:0){
                                
                                
                                VStack(spacing: 20,
                                       content: {
                                    
                                    mobilityLevelView
                                    
                                    languageSpeakingView
                                    
                                    distanceView
                                    
                                    HStack{
                                        previousButton
                                            .asButton(.press) {
                                                router.dismissScreen()
                                            }
                                        Spacer()
                                        nextButton
                                            .asButton(.press) {
                                                viewModel.dataChecks (parameters: parameters){ alertStr in
                                                    presentAlert(title: "Kryupa", subTitle: alertStr)
                                                } next: {
                                                    router.showScreen(.push) { rout in
                                                        SelectProfileImageView()
                                                    }
                                                }
                                            }
                                    }
                                    .padding(.top,30)
                                })
                                .padding(.top,30)
                                .padding([.leading,.trailing],24)
                            }
                        }
                        .scrollIndicators(.hidden)
                        .toolbar(.hidden, for: .navigationBar)
                    }
                    if viewModel.showPreference{
                        Image("GiverInfoDetails")
                            .resizable()
                            .frame(width: 300,height: 55)
                            .offset(x: 5,y:55)
                    }
                }
            }
            if viewModel.isLoading{
                LoadingView()
            }
        }
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
                selectedValue: viewModel.preferenceListData.mobilityLevel,
                placeHolder: "Select",
                values: AppConstants.mobilityLevelArray) { value in
                    viewModel.preferenceListData.mobilityLevel = value
                }
        })
    }
    
    private var languageSpeakingView: some View{
        
        VStack(alignment: .leading){
            HStack(spacing:0){
                Text("Language Preference")
                Text("*")
                    .foregroundStyle(.red)
            }
            .font(.custom(FontContent.plusMedium, size: 17))
            
            
            ZStack{
                NonLazyVGrid(columns: 2, alignment: .leading, spacing: 10, items: AppConstants.languageSpeakingArray) { languageSpeakingArray in
                    
                    if let languageSpeakingArray{
                        HStack(spacing:0){
                            CheckBoxView(
                                isSelected: !viewModel.languageSpeakingSelected.contains(languageSpeakingArray),
                                name: languageSpeakingArray
                            )
                            .opacity(AppConstants.languageSpeakingArray.last == languageSpeakingArray ? 0 : 1)
                            .frame(maxWidth: .infinity,alignment: .leading)
                            .asButton(.press) {
                                if viewModel.languageSpeakingSelected.contains(languageSpeakingArray){
                                    viewModel.languageSpeakingSelected = viewModel.languageSpeakingSelected.filter{ $0 != languageSpeakingArray}
                                }else{
                                    if viewModel.languageSpeakingSelected.count < 5{
                                        viewModel.languageSpeakingSelected.append(languageSpeakingArray)
                                    }
                                }
                            }
                        }
                    }else{
                        EmptyView()
                    }
                }
            }
        }
    }
    private var distanceView: some View{
        VStack(alignment: .leading, spacing:0,
               content: {
            HStack(spacing:0){
                Text("Distance")
                Text("*")
                    .foregroundStyle(.red)
            }
            .frame(height: 21)
            .font(.custom(FontContent.plusMedium, size: 17))
            .padding(.bottom,10)
            
            DropDownView(
                selectedValue: viewModel.preferenceListData.distance,
                placeHolder: "Select",
                values: AppConstants.distanceArray) { value in
                    viewModel.preferenceListData.distance = value
                }
        })
    }
}

#Preview {
    PreferenceView()
}
