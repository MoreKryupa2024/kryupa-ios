//
//  BookingFormScreenView.swift
//  Kryupa
//
//  Created by Hemant Singh Rajput on 31/05/24.
//

import SwiftUI
import SwiftfulUI

struct BookingFormScreenView: View {
    
    @Environment(\.router) var router
    
    @StateObject private var viewModel = BookingFormScreenViewModel()
    
    
    var body: some View {
        ZStack{
            VStack(spacing:0){
                HeaderView
                
                ScrollView {
                    VStack(spacing: 0){
                        Text("Let Us Find Best Caregiver\nFor You")
                            .font(.custom(FontContent.besMedium, size: 20))
                            .multilineTextAlignment(.center)
                            .padding(.top,20)
                        
                        BookingForDropdownView
                            .padding(.top,20)
                        
                        sepratorView
                            .padding(.top,15)
                        
                        needService
                        
                        sepratorView
                        
                        SegmentController
                        
                        DateTimeView
                        
                        sepratorView
                        
                        genderView
                        
                        sepratorView
                        
                        languageSpeakingView
                        
                        sepratorView
                        
                        yearsofExperienceView
                        
                        sepratorView
                        
                        AdditionalSkillsView
                        
                        sepratorView
                        
                        AdditionalInfoView
                            .padding(.bottom,15)
                    }
                }
                .scrollIndicators(.hidden)
                .toolbar(.hidden, for: .navigationBar)
                
                BottomButtonView
            }
            if viewModel.isloading{
                LoadingView()
            }
        }
        .onAppear{
            viewModel.getBookingForRelativeList()
        }
    }
    
    private var DateTimeView: some View{
        
        VStack{
            Text("Pick Date & Time")
                .frame(maxWidth: .infinity,alignment: .leading)
                .font(.custom(FontContent.plusRegular, size: 17))
            if viewModel.segSelected == "One Time"{
                WeakDayContentView
            }else{
                RecurringContentView
            }
            HStack(spacing:29){
                Text("8:00 am")
                    .asButton(.press) {
                        
                    }
                    
                Text("-")
                Text("9:00 pm")
                    .asButton(.press) {
                        
                    }
                    
            }
            .font(.custom(FontContent.besMedium, size: 22))
        }
        .padding(.horizontal,24)
        .padding(.top,15)
    }
    
    private var WeakDayContentView: some View{
        WeakDayView(selectionCount: 8,selectedValue: viewModel.selectedDay){ selectedWeak in
            viewModel.selectedDay = selectedWeak
//            viewModel.getSlotList()
        }
    }
    
    private var RecurringContentView: some View{
        HStack(spacing:0){
            VStack(spacing:0){
                Text("18")
                    .frame(maxWidth: .infinity,maxHeight: .infinity)
                    .background(.E_5_E_5_EA)
                    .font(.custom(FontContent.besSemiBold, size: 34))
                
                Text("January")
                    .frame(maxWidth: .infinity)
                    .padding(.vertical,4)
                    .background(.appMain)
                    .foregroundStyle(.white)
                    .font(.custom(FontContent.plusRegular, size: 16))
            }
            .frame(width: 105,height: 79)
            .asButton(.press) {
                
            }
            
            
            Capsule()
                .frame(width: 35,height: 5)
                .background()
                .frame(maxWidth: .infinity,maxHeight: .infinity)
                
            
            VStack(spacing:0){
                Text("19")
                    .frame(maxWidth: .infinity,maxHeight: .infinity)
                    .background(.E_5_E_5_EA)
                    .font(.custom(FontContent.besSemiBold, size: 34))
                
                Text("January")
                    .frame(maxWidth: .infinity)
                    .padding(.vertical,4)
                    .background(.appMain)
                    .foregroundStyle(.white)
                    .font(.custom(FontContent.plusRegular, size: 16))
            }
            .frame(width: 105,height: 79)
            .asButton(.press) {
                
            }
            
        }
        
    }
    
    private var SegmentController: some View{
        HStack(spacing:0){
            Text("One Time")
                .padding(.vertical,6)
                .frame(maxWidth: .infinity)
                .background(viewModel.segSelected == "One Time" ? .white : .E_5_E_5_EA)
                .foregroundStyle(viewModel.segSelected == "One Time" ? .appMain : ._7_C_7_C_80)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .asButton(.press) {
                    viewModel.segSelected = "One Time"
                }
            Text("Recurring")
                .padding(.vertical,6)
                .frame(maxWidth: .infinity)
                .background(viewModel.segSelected == "Recurring" ? .white : .E_5_E_5_EA)
                .foregroundStyle(viewModel.segSelected == "Recurring" ? .appMain : ._7_C_7_C_80)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .asButton(.press) {
                    viewModel.segSelected = "Recurring"
                }
        }
        .padding([.horizontal,.vertical],3)
        .font(.custom(FontContent.plusMedium, size: 12))
        .background(.E_5_E_5_EA)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .padding(.horizontal,24)
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
        .padding([.leading,.trailing],24)
        .frame(maxWidth: .infinity,alignment: .leading)
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
        .padding(.horizontal,24)
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
        .padding(.horizontal,24)
    }
    
    private var BookingForDropdownView: some View{
        VStack(alignment: .leading, spacing:0,
               content: {
            HStack(spacing:0){
                Text("Booking For")
                Text("*")
                    .foregroundStyle(.red)
            }
            .frame(height: 21)
            .font(.custom(FontContent.plusRegular, size: 16))
            .padding(.bottom,20)
            
            DropDownView(
                selectedValue: viewModel.bookingFor,
                placeHolder: "Select",
                values: viewModel.bookingForList.map{$0.name}) { value in
                    viewModel.bookingFor = value
                }
        })
        .padding(.horizontal,24)
    }
    
    private var HeaderView: some View{
        ZStack{
            Image("KryupaLobby")
                .resizable()
                .frame(width: 124,height: 20)
            
            HStack{
                Image("navBack")
                    .resizable()
                    .frame(width: 30,height: 30)
                    .asButton(.press) {
                        router.dismissScreen()
                    }
                Spacer()
                Image("NotificationBellIcon")
                    .frame(width: 25,height: 25)
            }
            .padding(.horizontal,24)
        }
    }
    
    private var sepratorView: some View{
        RoundedRectangle(cornerRadius: 4)
            .foregroundStyle(.F_2_F_2_F_7)
            .frame(height: 1)
            .padding(.vertical,15)
            .padding(.trailing,48)
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
        .padding(.horizontal,24)
    }
    
    private var AdditionalSkillsView: some View{
        
        VStack(alignment: .leading){
            HStack(spacing:0){
                Text("Additional Skills")
            }
            .font(.custom(FontContent.plusRegular, size: 16))
            
            
            ZStack{
                NonLazyVGrid(columns: 2, alignment: .leading, spacing: 10, items: AppConstants.additionalSkillsAraay) { service in
                    if let service{
                        CheckBoxView(
                            isSelected: !viewModel.additionalSkillsSelected.contains(service),
                            name: service
                        )
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .asButton(.press) {
                            if viewModel.additionalSkillsSelected.contains(service){
                                viewModel.additionalSkillsSelected = viewModel.additionalSkillsSelected.filter{ $0 != service}
                            }else{
                                viewModel.additionalSkillsSelected.append(service)
                            }
                        }
                    }else{
                        EmptyView()
                    }
                }
            }
        }
        .padding(.horizontal,24)
    }
    
    private var AdditionalInfoView: some View{
        
        VStack(alignment: .leading){
            HStack(spacing:0){
                Text("Additional info")
            }
            .font(.custom(FontContent.plusRegular, size: 16))
            
            
            ZStack{
                NonLazyVGrid(columns: 1, alignment: .leading, spacing: 10, items: AppConstants.additionalInfoArray) { service in
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
    }
    
    private var BottomButtonView: some View{
        
        HStack(alignment: .center,spacing: 40){
            Text("Confirm")
                .foregroundStyle(.white)
                .padding(.horizontal,20)
                .padding(.vertical,8)
                .background{
                    RoundedRectangle(cornerRadius: 16)
                }
                .padding(.top,5)
                .asButton(.press) {
                    
                }
            
            Text("Reset")
                .foregroundStyle(.appMain)
                .padding(.horizontal,20)
                .padding(.vertical,8)
                .background{
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(lineWidth: 1)
                }
                .padding(.top,5)
                .asButton(.press) {
                    viewModel.bookingFor = ""
                    viewModel.genderSelected = ""
                    viewModel.languageSpeakingSelected = []
                    viewModel.needServiceInSelected = []
                    viewModel.additionalInfoSelected = []
                    viewModel.additionalSkillsSelected = []
                    viewModel.yearsOfExperienceSelected = ""
                }
        }
        .padding(.vertical,5)
        .frame(maxWidth: .infinity)
        .background(.F_2_F_2_F_7)
    }
}

#Preview {
    BookingFormScreenView()
}
