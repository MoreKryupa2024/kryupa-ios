//
//  BookingFormScreenView.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 31/05/24.
//

import SwiftUI
import SwiftfulUI

struct BookingFormScreenView: View {
    
    @Environment(\.router) var router
    
    @StateObject var viewModel = BookingFormScreenViewModel()
    var notificatioSsetBookingId = NotificationCenter.default
    @State var bookingForDropShow:Bool = Bool()
    
    var body: some View {
        ZStack{
            VStack(spacing:15){
                HeaderView(showBackButton:viewModel.isRecommended)
                
                ScrollView {
                    VStack(spacing: 0){
                        Text("Let Us Find Best Caregiver\nFor You")
                            .font(.custom(FontContent.besMedium, size: 20))
                            .multilineTextAlignment(.center)
                            .padding(.top,05)
                        
                        BookingForDropdownView
                            .padding(.top,20)
                            .id(viewModel.bookingFor)
                        
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
        .task{
            if viewModel.isRecommended {
                viewModel.getCustomerRequirements { error in
                    presentAlert(title: "Kryupa", subTitle: error)
                }
            }
            viewModel.getBookingForRelativeList{ error in
                presentAlert(title: "Kryupa", subTitle: error)
            }
        }
    }

    
    private var DateTimeView: some View{
        
        VStack(spacing:15){
            Text("Pick Date & Time")
                .frame(maxWidth: .infinity,alignment: .leading)
                .font(.custom(FontContent.plusMedium, size: 17))
            if viewModel.segSelected == "One Time"{
                OneTimeContentView
            }else{
                RecurringContentView
            }
            
            SelectTimeContentView
            
            DurationTimeContentView
        }
        .padding(.horizontal,24)
        .padding(.top,15)
    }
    
    private var OneTimeContentView: some View{
        VStack{
            HStack{
                Text("Select Date")
                    .font(.custom(FontContent.plusRegular, size: 16))
                    .padding(.leading,24)
                Spacer()

                Text(dateFormatChange(dateFormat: "d MMM", dates: viewModel.startDateValue))
                    .font(.custom(FontContent.plusRegular, size: 16))
                    .padding(.vertical,8)
                    .padding(.horizontal,20)
                    .background{
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(lineWidth: 1)
                    }
                    .padding(.trailing,24)
                    .asButton {
                        withAnimation(.bouncy) {
                            viewModel.showDatePicker = true
                        }
                    }
            }
            .padding(.vertical,16)
            .background{
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 1)
                    .foregroundStyle(.E_5_E_5_EA)
            }
            if viewModel.showDatePicker{
                VStack(spacing:0){
                    DatePicker(selection:$viewModel.startDateValue, in: Date()..., displayedComponents: .date) {}
                        .datePickerStyle(.graphical)
                    
                    Text("Done")
                        .frame(maxWidth: .infinity)
                        .padding(10)
                        .foregroundStyle(.white)
                        .background{
                            Color.blue
                        }
                        .cornerRadius(10)
                        .padding([.leading,.trailing,.bottom],10)
                        .asButton(.press) {
                            withAnimation(.bouncy) {
                                let startDate = (dateFormatChange(dateFormat: "yyyy-MM-dd", dates: viewModel.startDateValue))
                                let currentDate = (dateFormatChange(dateFormat: "yyyy-MM-dd", dates: Date()))
                                if (startDate == currentDate){
                                    viewModel.startTimeValue = Date()
                                }
                                viewModel.showDatePicker = false
                            }
                        }
                }
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 1)
                        .foregroundStyle(.D_1_D_1_D_6)
                    
                )
                .padding(.top,10)
            }
        }
    }
    
    private var SelectTimeContentView: some View{
        VStack{
            HStack{
                Text("Select Time")
                    .font(.custom(FontContent.plusRegular, size: 16))
                    .padding(.leading,24)
                Spacer()
                
                Text(dateFormatChange(dateFormat: "h:mm a", dates: viewModel.startTimeValue))
                    .font(.custom(FontContent.plusRegular, size: 16))
                    .padding(.vertical,8)
                    .padding(.horizontal,20)
                    .background{
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(lineWidth: 1)
                    }
                    .padding(.trailing,24)
                    .asButton {
                        withAnimation(.bouncy) {
                            viewModel.showTimePicker = true
                        }
                    }
            }
            .padding(.vertical,16)
            .background{
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 1)
                    .foregroundStyle(.E_5_E_5_EA)
            }
            
            
            if viewModel.showTimePicker{
                
                VStack(spacing:0){
                    
                    
                    if (Date() < viewModel.startDateValue) && viewModel.segSelected == "One Time"{
                        DatePicker(selection:$viewModel.startTimeValue, displayedComponents: .hourAndMinute) {}
                            .datePickerStyle(.wheel)
                    }else if viewModel.segSelected != "One Time" && !viewModel.dateArray.contains(dateFormatChange(dateFormat: "yyyy-MM-dd", dates: Date())){
                        DatePicker(selection:$viewModel.startTimeValue, displayedComponents: .hourAndMinute) {}
                            .datePickerStyle(.wheel)
                    }else{
                        DatePicker(selection:$viewModel.startTimeValue, in: Date()..., displayedComponents: .hourAndMinute) {}
                            .datePickerStyle(.wheel)
                    }
                    
                    Text("Done")
                        .frame(maxWidth: .infinity)
                        .padding(10)
                        .foregroundStyle(.white)
                        .background{
                            Color.blue
                        }
                        .cornerRadius(5)
                        .padding([.leading,.trailing,.bottom],10)
                        .asButton(.press) {
                            withAnimation(.bouncy) {
                                viewModel.showTimePicker = false
                            }
                        }
                }
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 1)
                        .foregroundStyle(.D_1_D_1_D_6)
                    
                )
                .padding(.top,10)
            }
        }
    }
    
    private var DurationTimeContentView: some View{
        HStack{
            Text("Duration")
                .font(.custom(FontContent.plusRegular, size: 16))
                .padding(.leading,24)
            Spacer()
            
            HStack(spacing:15) {
                Image("minus")
                    .asButton(.press) {
                        if Int(viewModel.duration) == 1 {
                            viewModel.duration = 1
                        } else {
                            viewModel.duration = viewModel.duration - 1
                        }
                    }
                Text(String("\(viewModel.duration)"))
                    .font(.custom(FontContent.plusRegular, size: 16))
                Image("plus")
                    .asButton(.press) {
                        viewModel.duration = viewModel.duration + 1
                    }
            }
            .padding(.horizontal, 15)
            .frame(height: 32)
            .overlay(
                RoundedRectangle(cornerRadius: 60)
                    .inset(by: 1)
                    .stroke(.D_1_D_1_D_6, lineWidth: 1)
            )
        }
        .padding(.trailing,24)
        .padding(.vertical,16)
        .background{
            RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 1)
                .foregroundStyle(.E_5_E_5_EA)
        }
    }
    
    private var RecurringContentView: some View{
        MultiDatePicker(selection: $viewModel.startDateSValue, in: Date()...) {}
            .datePickerStyle(.graphical)
            .onChange(of: viewModel.startDateSValue, { oldValue, newValue in
                viewModel.dateArray = []
                if viewModel.startDateSValue.count > 0 {
                    
                    for i in viewModel.startDateSValue{
                        viewModel.dateArray.append(dateFormatChange(dateFormat: "yyyy-MM-dd", dates: i.date ?? Date()))
                        print(i)
                    }
                }
                if viewModel.dateArray.contains(dateFormatChange(dateFormat: "yyyy-MM-dd", dates: Date())){
                    viewModel.startTimeValue = Date()
                }
            })
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 1)
                    .foregroundStyle(.D_1_D_1_D_6)
                    
            )
            .padding(.bottom,15)
            .padding(.top,10)
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
                    viewModel.startTimeValue = Date()
                    viewModel.startDateValue = Date()
                    viewModel.startDateSValue = []
                }
            Text("Recurring")
                .padding(.vertical,6)
                .frame(maxWidth: .infinity)
                .background(viewModel.segSelected == "Recurring" ? .white : .E_5_E_5_EA)
                .foregroundStyle(viewModel.segSelected == "Recurring" ? .appMain : ._7_C_7_C_80)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .asButton(.press) {
                    viewModel.segSelected = "Recurring"
                    viewModel.startDateSValue = []
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
                Text("*")
                    .foregroundStyle(.red)
            }
            .font(.custom(FontContent.plusMedium, size: 17))
            
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
                                        viewModel.languageSpeakingSelected.append(languageSpeakingArray)
                                    }
                                viewModel.languageSpeakingSelected = viewModel.languageSpeakingSelected.sorted(by: { $0 < $1 })
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
                Text("*")
                    .foregroundStyle(.red)
            }
            .font(.custom(FontContent.plusMedium, size: 17))
            
            
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
            .font(.custom(FontContent.plusMedium, size: 17))
            .padding(.bottom,20)
            
            DropDownView(
                selectedValue: viewModel.bookingFor,
                placeHolder: "Select",
                showDropDown: bookingForDropShow,
                values: viewModel.bookingForList.map{$0.name}) { value in
                    viewModel.bookingFor = value
                }onShowValue: {
                    bookingForDropShow = !bookingForDropShow
                }
        })
        .padding(.horizontal,24)
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
                Text("*")
                    .foregroundStyle(.red)
            }
            .font(.custom(FontContent.plusMedium, size: 17))
            .frame(maxWidth: .infinity,alignment: .leading)
            
            
            ZStack{
                NonLazyVGrid(columns: 1, alignment: .leading, spacing: 5, items: viewModel.needServiceInArray) { data in
                    if let data{
                        CircleCheckBoxView(
                            isSelected: !viewModel.needServiceInSelected.contains(data.service),
                            name: data.service,
                            price: Double(data.amount),
                            color: viewModel.needServiceInSelected == [] ? .appMain : viewModel.needServiceInSelected.contains(data.service) ? .appMain : .AEAEB_2
                        )
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .padding(.bottom,5)
                        .asButton(.press) {
                            if viewModel.needServiceInSelected.contains(data.service){
                                viewModel.needServiceInSelected = viewModel.needServiceInSelected.filter{ $0 != data.service}
                                }else{
                                    viewModel.needServiceInSelected = []
                                    viewModel.needServiceInSelected.append(data.service)
                                }
                            viewModel.needServiceInSelected = viewModel.needServiceInSelected.sorted(by: { $0 < $1 })
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
            .font(.custom(FontContent.plusMedium, size: 17))
            
            
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
                            viewModel.additionalSkillsSelected = viewModel.additionalSkillsSelected.sorted(by: { $0 < $1 })
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
            .font(.custom(FontContent.plusMedium, size: 17))
            
            
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
                            
                            viewModel.additionalInfoSelected = viewModel.additionalInfoSelected.sorted(by: { $0 < $1 })
                        }
                    }else{
                        EmptyView()
                    }
                }
            }
        }
        .padding(.horizontal,24)
    }
    
    private func recommnededCheck()-> Bool{
        guard let recommendedUserBookingData = viewModel.recommendedUserBookingData else{
            return false
        }
        
        if viewModel.genderSelected != recommendedUserBookingData.gender{
            return false
        }else if viewModel.yearsOfExperienceSelected != recommendedUserBookingData.yearOfExperience{
            return false
        }else if viewModel.languageSpeakingSelected != recommendedUserBookingData.preferredLang{
            return false
        }/*else if viewModel.needServiceInSelected != recommendedUserBookingData.preferredServiceType{
            return false
        }*/else{
            return true
        }
     
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
                    viewModel.createBooking { bookingId in
                        if viewModel.isRecommended && recommnededCheck() {
                            let bookingDict:[String: String] = ["bookingId": bookingId]
                            router.dismissScreen()
                            notificatioSsetBookingId.post(name: .setBookingId,
                                                                            object: nil, userInfo: bookingDict)
                        }else{
                            viewModel.bookingID = bookingId
                            router.showScreen(.push) { rout in
                                CareGiverNearByCustomerScreenView(bookingID: bookingId)
                            }
                        }
                    } alert: { error in
                        presentAlert(title: "Kryupa", subTitle: error)
                    }

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
                    viewModel.languageSpeakingSelected = ["English"]
                    viewModel.needServiceInSelected = []
                    viewModel.additionalInfoSelected = []
                    viewModel.additionalSkillsSelected = []
                    viewModel.yearsOfExperienceSelected = "Any"
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
