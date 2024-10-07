//
//  MyServicesView.swift
//  Kryupa
//
//  Created by Pooja Nenava on 11/06/24.
//

import SwiftUI
import SwiftfulUI

struct MyServicesView: View {
    @Environment(\.router) var router
    @StateObject private var viewModel = MyServiceViewModel()
    @State var mobilityLevelDownShow:Bool = Bool()
    @State var distanceDownShow:Bool = Bool()
    var body: some View {
        ZStack{
            
            VStack(spacing:0){
                HeaderView(showBackButton: true)
//                SegmentView
//                    .padding(.top, 10)
//                    .padding(.bottom, 30)
                Text("My Services")
                    .font(.custom(FontContent.besMedium, size: 20))
                    .foregroundStyle(.appMain)
                    .padding(.vertical,30)
                switch viewModel.selectedSection{
                case 1:
                    ScrollView{
                        VStack(spacing:0){
                            VStack(spacing: 20,
                                   content: {
                                
                                mobilityLevelView
                                languageSpeakingView
                                distanceView
                                BottomButtonView
                            })
                            .padding(.top,10)
                            .padding([.leading,.trailing],24)
                        }
                    }
                    .scrollIndicators(.hidden)
                    .toolbar(.hidden, for: .navigationBar)

                default:
                    ScrollView {
                        AreaOfExpertiseView
                        line
                        MySkillsView
                        line
                        AdditionalInfoView
                        BottomButtonView
                    }
                }
                
            }
            .toolbar(.hidden, for: .navigationBar)
            
            if viewModel.isLoading{
                LoadingView()
            }
        }
        .task {
            viewModel.getMyService()
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
                showDropDown: mobilityLevelDownShow,
                values: AppConstants.mobilityLevelArray) { value in
                    viewModel.mobilityLevel = value
                }onShowValue: {
                    mobilityLevelDownShow = !mobilityLevelDownShow
                    distanceDownShow = false
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
                selectedValue: viewModel.distance,
                placeHolder: "Select",
                showDropDown: distanceDownShow,
                values: AppConstants.distanceArray) { value in
                    viewModel.distance = value
                }onShowValue: {
                    distanceDownShow = !distanceDownShow
                    mobilityLevelDownShow = false
                }
        })
    }
    
    
    private var SegmentView: some View{
        
        HStack(spacing: 0) {
            SegmentTextView(title: "My Services", select: viewModel.selectedSection == 0)
                .asButton {
                    viewModel.selectedSection = 0
                }
            SegmentTextView(title: "My Preferences", select: viewModel.selectedSection == 1)
                .asButton {
                    viewModel.selectedSection = 1
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
    
    private var BottomButtonView: some View{
                    
            HStack() {
                Text("Save")
                    .font(.custom(FontContent.plusRegular, size: 16))
                    .foregroundStyle(.white)
                    .frame(height: 53)
                    .frame(width: 135)
                    .background{
                        RoundedRectangle(cornerRadius: 48)
                    }
                    .asButton(.press) {
                        viewModel.updateMyService { error in
                            presentAlert(title: "Kryupa", subTitle: error)
                        }
                    }
                
                Spacer()
                
                Text("Cancel")
                    .font(.custom(FontContent.plusRegular, size: 16))
                    .foregroundStyle(.appMain)
                    .frame(height: 53)
                    .frame(width: 135)
                    .overlay(
                        RoundedRectangle(cornerRadius: 48)
                            .inset(by: 1)
                            .stroke(.appMain, lineWidth: 1)
                    )
                    .asButton(.press) {
                        router.dismissScreen()
                    }
            }
            .padding([.top, .horizontal], 24)
    }
    
    private var AdditionalInfoView: some View{
        
        VStack(alignment: .leading){
            HStack(spacing:0){
                Text("Additional info")
            }
            .font(.custom(FontContent.plusMedium, size: 17))
            
            
            ZStack{
                NonLazyVGrid(columns: 2, alignment: .leading, spacing: 10, items: AppConstants.additionalInfoArray) { service in
                    if let service{
                        CheckBoxView(
                            isSelected: !viewModel.additionalInfoSelected.contains(service),
                            name: service
                        )
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .asButton(.press) {
                            if viewModel.additionalInfoSelected.contains(service){
                                viewModel.additionalInfoSelected = viewModel.additionalInfoSelected.filter{ $0 != service}
                            }else{
                                viewModel.additionalInfoSelected.append(service)
                            }
                        }
                    }else{
                        EmptyView()
                    }
                }
            }
        }
        .padding(.horizontal,24)
        .padding(.top,10)
    }
    
    private var MySkillsView: some View{
        
        VStack(alignment: .leading){
            HStack(spacing:0){
                Text("My Skills")
            }
            .font(.custom(FontContent.plusMedium, size: 17))
            
            
            ZStack{
                NonLazyVGrid(columns: 2, alignment: .leading, spacing: 10, items: viewModel.mySkillsList) { service in
                    if let service{
                        CheckBoxView(
                            isSelected: !viewModel.mySkillsSelected.contains(service),
                            name: service
                        )
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .asButton(.press) {
                            if viewModel.mySkillsSelected.contains(service){
                                viewModel.mySkillsSelected = viewModel.mySkillsSelected.filter{ $0 != service}
                            }else{
                                viewModel.mySkillsSelected.append(service)
                            }
                        }
                    }else{
                        EmptyView()
                    }
                }
            }
        }
        .padding(.horizontal,24)
        .padding(.top, 10)
    }
    
    private var line: some View {
        Divider()
            .background(.F_2_F_2_F_7)
            .padding(.trailing, 30)
            .padding(.leading, 0)
            .padding(.top, 10)
    }
    
    
    private var AreaOfExpertiseView: some View{
        
        VStack(alignment: .leading){
            HStack(spacing:0){
                Text("Area of expertise")
                    .foregroundStyle(.appMain)
                Text("*")
                    .foregroundStyle(.red)
            }
            .font(.custom(FontContent.plusMedium, size: 17))
            
            ZStack{
                NonLazyVGrid(columns: 1, alignment: .leading, spacing: 10, items: viewModel.areaOfExpertiseList) { service in
                    if let service{
                        CheckBoxView(
                            isSelected: !viewModel.areaOfExpertiseSelected.contains(service),
                            name: service
                        )
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .asButton(.press) {
                            if viewModel.areaOfExpertiseSelected.contains(service){
                                viewModel.areaOfExpertiseSelected = viewModel.areaOfExpertiseSelected.filter{ $0 != service}
                            }else{
                                viewModel.areaOfExpertiseSelected.append(service)
                            }
                        }
                    }else{
                        EmptyView()
                    }
                }
            }
        }
        .padding(.horizontal,24)
        .padding(.top,10)
    }
    
}

#Preview {
    MyServicesView()
}
