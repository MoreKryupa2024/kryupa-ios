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
            .blur(radius: viewModel.showDatePicker ? 05 : 0)
            .onTapGesture {
                print("No access!")
            }
            
            if viewModel.isloading{
                LoadingView()
            }
            
            if viewModel.showDatePicker{
                switch viewModel.dateState{
                case 1:
                    
                    DateTimePickerScreenView(
                        givenDate: viewModel.startTimeValue,
                        formate: "HH:mm:ss",
                        range: range(),
                        rangeThrough: nil,
                        valueStr: { value in
                            viewModel.startTime = value
                            if value > "23:00:00" && viewModel.segSelected == "One Time"{
                                viewModel.endTime = "23:59:00"
                            }else{
                                viewModel.endTime = setFutureDate(value: viewModel.startTime, currFormate: "HH:mm:ss", givenFormate: "HH:mm:ss", incrementValue: 1, component: .hour)
                            }
                            viewModel.showDatePicker = false
                        },
                        displayedComponents: .hourAndMinute) { value in
                            if dateFormatChange(dateFormat: "HH:mm:ss", dates: value) > "23:00:00" && viewModel.segSelected == "One Time"{
                                guard let date = dateFormatChangeToDate(dateFormat: "HH:mm:ss", dates: "23:59:00") else { return }
                                viewModel.endTimeValue = date
                            }else{
                                guard let incrementedDate = Calendar.current.date(byAdding: .hour, value: 1, to: value) else {
                                    return
                                }
                                viewModel.endTimeValue = incrementedDate
                            }
                        }cancelAction: {
                            viewModel.showDatePicker = false
                        }

                case 2:
                    DateTimePickerScreenView(
                        givenDate: viewModel.endTimeValue,
                        formate: "HH:mm:ss",
                        range: viewModel.segSelected != "One Time" ? nil : viewModel.endTimeValue...,
                        rangeThrough: nil,
                        valueStr: { value in
                            viewModel.endTime = value
                            viewModel.showDatePicker = false
                        },
                        displayedComponents: .hourAndMinute) { value in
                            viewModel.endTimeValue = value
                        }cancelAction: {
                            viewModel.showDatePicker = false
                        }
                    
                case 3:
                    DateTimePickerScreenView(
                        givenDate: viewModel.startDateValue,
                        formate: "yyyy-MM-dd'T'HH:mm:ssZ",
                        range: Date()...,
                        rangeThrough: nil,
                        valueStr: { value in
                            
                            let currentDate = dateFormatChange(dateFormat: "yyyy-MM-dd", dates: Date())
                            let pickedDate = value.split(separator: "T").first ?? ""
                            
                            if currentDate == pickedDate && viewModel.startTime < dateFormatChange(dateFormat: "HH:mm:ss", dates: Date()){
                                viewModel.startTime = dateFormatChange(dateFormat: "HH:mm:ss", dates: Date())//.addingTimeInterval(14400))
                                viewModel.startTimeValue =  Date()
                                viewModel.endTimeValue = Date().addingTimeInterval(3600)//.addingTimeInterval(18000)
                                viewModel.endTime = dateFormatChange(dateFormat: "HH:mm:ss", dates: Date().addingTimeInterval(3600))
                            }
                            viewModel.startDate = value
                            viewModel.endDate = setFutureDate(value: viewModel.startDate, currFormate: "yyyy-MM-dd'T'HH:mm:ssZ", givenFormate: "yyyy-MM-dd'T'HH:mm:ssZ", incrementValue: 1, component: .day)
                            viewModel.showDatePicker = false
                        },
                        displayedComponents: .date){ value in
                            guard let incrementedDate = Calendar.current.date(byAdding: .day, value: 1, to: value) else {
                                return
                            }
                            viewModel.startDateValue = value
                            viewModel.endDateValue = incrementedDate
                    }cancelAction: {
                        viewModel.showDatePicker = false
                    }
                    
                case 4:
                    DateTimePickerScreenView(
                        givenDate: viewModel.endDateValue,
                        formate: "yyyy-MM-dd'T'HH:mm:ssZ",
                        range: viewModel.endDateValue...,
                        rangeThrough: nil,
                        valueStr: { value in
                            viewModel.endDate = value
                            viewModel.showDatePicker = false
                        },
                        displayedComponents: .date){ value in
                            viewModel.endDateValue = value
                        }cancelAction: {
                            viewModel.showDatePicker = false
                        }
                default:
                    EmptyView()
                }
            }
        }
        .task{
            
            if viewModel.isRecommended {
                viewModel.getCustomerRequirements { error in
                    presentAlert(title: "Kryupa", subTitle: error)
                }
            }
            viewModel.endTime = setFutureDate(value: viewModel.startTime, currFormate: "HH:mm:ss", givenFormate: "HH:mm:ss", incrementValue: 1, component: .hour)
            viewModel.endDate = setFutureDate(value: viewModel.startDate, currFormate: "yyyy-MM-dd'T'HH:mm:ssZ", givenFormate: "yyyy-MM-dd'T'HH:mm:ssZ", incrementValue: 1, component: .day)
            viewModel.getBookingForRelativeList{ error in
                presentAlert(title: "Kryupa", subTitle: error)
            }
        }
    }
    
    private func range()-> (PartialRangeFrom<Date>)?{
        
        let date = Date()
        let calendar = Calendar.current
        let day = "\(calendar.component(.day, from: date))"
        if viewModel.segSelected == "One Time"{
            let startDay = (viewModel.selectedDay.numDay)
            if startDay == day{
                let currentDate =  date//.addingTimeInterval(14400)
                return currentDate...
            }else{
                return nil
            }
            
        }else{
            let startDay = (viewModel.startDate.convertDateFormater(beforeFormat: "yyyy-MM-dd'T'HH:mm:ssZ", afterFormat: "d"))
            
            if startDay == day{
                let currentDate =  date//.addingTimeInterval(14400)
                return currentDate...
            }else{
                return nil
            }
        }
    }
    
    private func setFutureDate(value: String , currFormate: String, givenFormate: String, incrementValue: Int, component:Calendar.Component)-> String{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = currFormate
        guard let date = dateFormatter.date(from: value) else {
            return ""
        }
        
        guard let incrementedDate = Calendar.current.date(byAdding: component, value: incrementValue, to: date) else {
            return ""
        }
        
        dateFormatter.dateFormat = givenFormate
        let strDate = dateFormatter.string(from: incrementedDate)
        
        return strDate
    }
    
    private func addOrSubtractMonth(value: Int, date: Date, component:Calendar.Component) -> Date {
        Calendar.current.date(byAdding: component, value: value, to: date)!
    }

    
    private var DateTimeView: some View{
        
        VStack{
            Text("Pick Date & Time")
                .frame(maxWidth: .infinity,alignment: .leading)
                .font(.custom(FontContent.plusMedium, size: 17))
            if viewModel.segSelected == "One Time"{
                WeakDayContentView
                    .id(viewModel.selectedDay.numDay)
            }else{
                RecurringContentView
            }
            HStack(spacing:29){
                Text(viewModel.startTime.convertDateFormater(beforeFormat: "HH:mm:ss", afterFormat: "h:mm a"))
                    .asButton(.press) {
                        viewModel.dateState = 1
                        viewModel.showDatePicker = true
                    }
                    
                Text("-")
                Text(viewModel.endTime.convertDateFormater(beforeFormat: "HH:mm:ss", afterFormat: "h:mm a"))
                    .asButton(.press) {
                        viewModel.dateState = 2
                        viewModel.showDatePicker = true
                    }
                    
            }
            .font(.custom(FontContent.besMedium, size: 22))
        }
        .padding(.horizontal,24)
        .padding(.top,15)
    }
    
    private var WeakDayContentView: some View{
        WeakDayView(selectionCount: 8,selectedValue: viewModel.selectedDay){ selectedWeak in
            let currentDate = dateFormatChange(dateFormat: "yyyy-MM-dd", dates: Date())
            let pickedDate = selectedWeak.serverDate.split(separator: "T").first ?? ""
            
            viewModel.selectedDay = selectedWeak
            if currentDate == pickedDate && viewModel.startTime < dateFormatChange(dateFormat: "HH:mm:ss", dates: Date()){
                DispatchQueue.main.async {
                    viewModel.startTime = dateFormatChange(dateFormat: "HH:mm:ss", dates: Date())//.addingTimeInterval(14400))
                    viewModel.startTimeValue =  Date()
                    viewModel.endTimeValue = Date().addingTimeInterval(3600)//.addingTimeInterval(18000)
                    viewModel.endTime = dateFormatChange(dateFormat: "HH:mm:ss", dates: Date().addingTimeInterval(3600))
                }
            }
        }
    }
    
    private var RecurringContentView: some View{
        HStack(spacing:0){
            VStack(spacing:0){
                Text(viewModel.startDate.convertDateFormater(beforeFormat: "yyyy-MM-dd'T'HH:mm:ssZ", afterFormat: "d"))
                    .frame(maxWidth: .infinity,maxHeight: .infinity)
                    .background(.E_5_E_5_EA)
                    .font(.custom(FontContent.besSemiBold, size: 34))
                
                Text(viewModel.startDate.convertDateFormater(beforeFormat: "yyyy-MM-dd'T'HH:mm:ssZ", afterFormat: "MMMM"))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical,4)
                    .background(.appMain)
                    .foregroundStyle(.white)
                    .font(.custom(FontContent.plusRegular, size: 16))
            }
            .frame(width: 105,height: 79)
            .asButton(.press) {
                viewModel.dateState = 3
                viewModel.showDatePicker = true
            }
            
            
            RoundedRectangle(cornerRadius: 5)
                .foregroundStyle(._7_C_7_C_80)
                .frame(width: 35,height: 5)
                .frame(maxWidth: .infinity,maxHeight: .infinity)
                
            
            VStack(spacing:0){
                Text(viewModel.endDate.convertDateFormater(beforeFormat: "yyyy-MM-dd'T'HH:mm:ssZ", afterFormat: "d"))
                    .frame(maxWidth: .infinity,maxHeight: .infinity)
                    .background(.E_5_E_5_EA)
                    .font(.custom(FontContent.besSemiBold, size: 34))
                
                Text(viewModel.endDate.convertDateFormater(beforeFormat: "yyyy-MM-dd'T'HH:mm:ssZ", afterFormat: "MMMM"))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical,4)
                    .background(.appMain)
                    .foregroundStyle(.white)
                    .font(.custom(FontContent.plusRegular, size: 16))
            }
            .frame(width: 105,height: 79)
            .asButton(.press) {
                viewModel.dateState = 4
                viewModel.showDatePicker = true
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
                    if viewModel.startTime > "23:00:00"{
                        viewModel.endTime = "23:59:00"
                        guard let date = dateFormatChangeToDate(dateFormat: "HH:mm:ss", dates: "23:59:00") else { return }
                        viewModel.endTimeValue = date
                    }
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
        }else if viewModel.needServiceInSelected != recommendedUserBookingData.preferredServiceType{
            return false
        }else{
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
