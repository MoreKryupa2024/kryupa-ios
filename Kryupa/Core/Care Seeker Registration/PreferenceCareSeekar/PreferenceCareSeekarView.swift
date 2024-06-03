//
//  PreferenceCareSeekarView.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 20/05/24.
//

import SwiftUI
import SwiftfulUI
//router.dismissScreen()

struct PreferenceCareSeekarView: View {
    
    @Environment(\.router) var router
    var parameters:[String:Any] = [String:Any]()
    
    @StateObject private var viewModel = PreferenceCareSeekarViewModel()
    
    var body: some View {
        ZStack{
            ScrollView{
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
                    }
                    .frame(height: 28)
                    .padding(.top,30)
                    
                    VStack(spacing: 0,
                           content: {
                        needService
                            .padding([.leading,.trailing],24)
                        
                        sepratorView
                        
                        yearsofExperienceView
                            .padding([.leading,.trailing],24)
                            .frame(maxWidth: .infinity,alignment: .leading)
                        
                        sepratorView
                        
                        genderView
                            .padding([.leading,.trailing],24)
                        
                        sepratorView
                        
                        languageSpeakingView
                            .padding([.leading,.trailing],24)
                        
                        HStack{
                            previousButton
                                .asButton(.press) {
                                    router.dismissScreen()
                                }
                            Spacer()
                            nextButton
                                .asButton(.press) {
                                    viewModel.dataChecks(parameters: parameters) { alertStr in
                                        presentAlert(title: "Kryupa", subTitle: alertStr)
                                    } next: {
                                        router.showScreen(.push) { rout in
                                            SelectProfileImageView()
                                        }
                                    }
                                }
                        }
                        .padding(.top,30)
                        .padding(.trailing,24)
                    })
                    .padding(.top,30)
                    
                    
                    
                }
            }
            .scrollIndicators(.hidden)
            .toolbar(.hidden, for: .navigationBar)
            if viewModel.isLoading{
                LoadingView()
            }
        }
    }
    
    private var yearsofExperienceView: some View{
        
        VStack(alignment: .leading){
            HStack(spacing:0){
                Text("Years of Experience")
            }
            .font(.custom(FontContent.plusRegular, size: 16))
            
            ZStack{
                NonLazyVGrid(columns: 3, alignment: .leading, spacing: 10, items: AppConstants.yearsOfExperienceArray) { experience in
                    if let experience{
                        PillView(
                            isSelected: viewModel.yearsOfExperienceSelected == experience,
                            name: experience
                        )
                        .asButton(.press) {
                            
                            viewModel.yearsOfExperienceSelected = experience
                        }
                    }else{
                        EmptyView()
                    }
                }
            }
        }
    }
    
    
    private var sepratorView: some View{
        RoundedRectangle(cornerRadius: 4)
            .foregroundStyle(.F_2_F_2_F_7)
            .frame(height: 1)
            .padding([.top,.bottom],15)
            .padding(.leading,24)
    }
    
    private var genderView: some View{
        
        VStack(alignment: .leading){
            HStack(spacing:0){
                Text("Gender")
            }
            .font(.custom(FontContent.plusRegular, size: 16))
            
            
            ZStack{
                NonLazyVGrid(columns: 3, alignment: .leading, spacing: 10, items: AppConstants.genderArray) { gender in
                    if let gender{
                        CircleCheckBoxView(
                            isSelected: gender != viewModel.genderSelected,
                            name: gender
                        )
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .asButton(.press) {
                            viewModel.genderSelected = gender
                        }
                    }else{
                        EmptyView()
                    }
                }
            }
        }
        
    }
    
    private var needService: some View{
        
        VStack(alignment: .leading){
            HStack(spacing:0){
                Text("Need Service In")
            }
            .font(.custom(FontContent.plusRegular, size: 16))
            
            
            ZStack{
                NonLazyVGrid(columns: 2, alignment: .leading, spacing: 5, items: AppConstants.needServiceInArray) { service in
                    if let service{
                        CheckBoxView(
                            isSelected: !viewModel.needServiceInSelected.contains(service),
                            name: service
                        )
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .asButton(.press) {
                            if viewModel.needServiceInSelected.contains(service){
                                viewModel.needServiceInSelected = viewModel.needServiceInSelected.filter{ $0 != service}
                            }else{
                                viewModel.needServiceInSelected.append(service)
                            }
                        }
                    }else{
                        EmptyView()
                    }
                }
            }
        }
        
    }
    
    private var languageSpeakingView: some View{
        
        VStack(alignment: .leading){
            HStack(spacing:0){
                Text("Language Speaking")
            }
            .font(.custom(FontContent.plusRegular, size: 16))
            
            
            ZStack{
                NonLazyVGrid(columns: 3, alignment: .leading, spacing: 10, items: AppConstants.languageSpeakingArray) { languageSpeakingArray in
                    
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
                                    viewModel.languageSpeakingSelected.append(languageSpeakingArray)
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
}

#Preview {
    PreferenceCareSeekarView()
}
