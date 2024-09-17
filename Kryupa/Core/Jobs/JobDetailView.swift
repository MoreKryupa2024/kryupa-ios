//
//  JobDetailView.swift
//  Kryupa
//
//  Created by Pooja Nenava on 17/06/24.
//

import SwiftUI
import SwiftfulUI

struct JobDetailView: View {

    @StateObject var viewModel = JobsViewModel()
    @StateObject private var viewModelHome = CareGiverHomeScreenViewModel()
    var jobID: String = "912d5565-8c0c-4eb7-b96f-9c8873a9f418"
    @Environment(\.router) var router

    var body: some View {
        ZStack{
            VStack(spacing:0){
                HeaderView(showBackButton: true)
                ScrollView {
                    UserView
                    ServiceRequiredView
                    line
                    JobDescView(startDate:viewModel.startDate.convertDateFormater(beforeFormat: "yyyy-MM-dd", 
                                                                                  afterFormat: "MMM dd yyyy"),
                                hours: "\(viewModel.jobDetailModel?.totalhours ?? 0)",
                                price: "\(viewModel.jobDetailModel?.bookingPricing ?? 0)",
                                startTime: viewModel.jobDetailModel?.startTime.convertDateFormater(beforeFormat: "HH:mm:ss",
                                                                                                   afterFormat: "h:mm a") ?? "",
                                endTime: viewModel.jobDetailModel?.endTime.convertDateFormater(beforeFormat: "HH:mm:ss",
                                                                                               afterFormat: "h:mm a") ?? "",
                                gender: viewModel.jobDetailModel?.gender ?? "",
                                diseaseType: viewModel.jobDetailModel?.diseaseType ?? [""])
                        .padding(.horizontal, 24)
                        .padding(.top, 18)
                    if (viewModel.otherDiseaseType != "-") {
                        OtherMedicalConditionView
                        line
                    }
                    
                    JobSchedule
                    line
                    
                    if getArrayOfSkillsRequired().count != 0{
                        getGridView(heading: "Skills Required", skillsList: getArrayOfSkillsRequired())
                        line
                    }
                    
                    if getArrayOfPersonalPrefernces().count != 0{
                        getGridView(heading: "Personal Preferences", skillsList: getArrayOfPersonalPrefernces())
                    }
                    
                    if let approchStatus = viewModel.jobDetailModel?.approchStatus{
                        if approchStatus == "Connecting Request"{
                            bottomButtonView
                        } else if approchStatus == "Rejected By Caregiver"{
                          Text("You have declined this booking request")
                                .font(.custom(FontContent.plusMedium, size: 15))
                                .padding(.top,30)
                            
                        } else {
                            Text("You have accepeted this booking request")
                                .font(.custom(FontContent.plusMedium, size: 15))
                                .padding(.top,30)
                        }
                    }
                }
                .toolbar(.hidden, for: .navigationBar)
                .task {
                    viewModel.getJobsDetail(approachID: jobID) {}
                    NotificationCenter.default.addObserver(forName: .showInboxScreen, object: nil, queue: nil,
                                                         using: self.setChatScreen)
                }
            }
            if viewModel.isloading{
                LoadingView()
            }
        }
    }
    
    private func setChatScreen(_ notification: Notification){
        router.dismissScreenStack()
    }
    
    private var JobSchedule: some View{
        VStack(alignment: .leading,spacing: 10){
            
            Text("Job Schedule")
                .font(.custom(FontContent.plusMedium, size: 17))
                .foregroundStyle(._7_C_7_C_80)
                .frame(maxWidth: .infinity,alignment: .leading)
            
            VStack(spacing:7){
                ForEach(viewModel.jobDetailModel?.serviceDetails ?? [], id: \.serviceDate) { data in
                    HStack{
                        Text(data.serviceDate.convertDateFormater(beforeFormat: "yyyy-MM-dd", afterFormat: "EEEE, MMM d yyyy"))
                        Spacer()
                        Text("\(viewModel.jobDetailModel?.startTime.convertDateFormater(beforeFormat: "HH:mm:ss", afterFormat: "h:mm a") ?? "") - \(viewModel.jobDetailModel?.endTime.convertDateFormater(beforeFormat: "HH:mm:ss", afterFormat: "h:mm a") ?? "")")//h:mm a
                    }
                    .font(.custom(FontContent.plusRegular, size: 15))
                }
            }
        }
        .padding(.horizontal,24)
        .padding(.top,17)
    }
    
    func getGridView(heading: String, skillsList: [SkillData]) -> some View{
                
        VStack(alignment: .leading){
            HStack(spacing:0){
                Text(heading)
                    .font(.custom(FontContent.plusMedium, size: 17))
                    .foregroundStyle(._7_C_7_C_80)
                    .frame(maxWidth: .infinity,alignment: .leading)
            }
            
            ZStack{
                NonLazyVGrid(columns: 2, alignment: .leading, spacing: 10, items: skillsList) { skill in

                    HStack {
                        Image(skill?.image ?? "")
                            .resizable()
                            .frame(width: 22, height: 22)
                        
                        Text(skill?.title ?? "")
                            .font(.custom(FontContent.plusRegular, size: 15))
                            .foregroundStyle(.appMain)
                        
                        Spacer()
                    }
                }
            }
        }
        .padding(.horizontal,24)
        .padding(.top, 24)
    }
    
    private var bottomButtonView: some View {
        VStack(spacing: 30){
            HStack(spacing: 30) {
                Text("Decline")
                    .font(.custom(FontContent.plusRegular, size: 16))
                    .foregroundStyle(.appMain)
                    .frame(height: 35)
                    .frame(width: 99)
                    .asButton(.press) {
                        viewModelHome.acceptRejectJob(approchID: jobID, status: "Rejected By Caregiver") {
                            presentAlert(title: "Kryupa", subTitle: "You have declined the booking request.")
                            router.dismissScreen()
                        }
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 48)
                            .inset(by: 1)
                            .stroke(.appMain, lineWidth: 1)
                    )

                Text("Accept")
                    .font(.custom(FontContent.plusRegular, size: 16))
                    .foregroundStyle(.white)
                    .frame(height: 35)
                    .frame(width: 97)
                    .background{
                        RoundedRectangle(cornerRadius: 48)
                    }
                    .asButton(.press) {
                        viewModelHome.acceptRejectJob(approchID: jobID, status: "Job Acceptance") {
                            presentAlert(title: "Kryupa", subTitle: "You have successfully accepted the booking request.")
                            router.dismissScreen()
//                            if viewModel.isComingfromChat{
//                                router.dismissScreen()
//                            }else{
//                                let ChatScreenViewModel = ChatScreenViewModel()
//                                guard let jobDetailModel = viewModel.jobDetailModel else {
//                                    return
//                                }
//                                let selectedChat = ChatListData(jsonData: [
//                                    "id":jobDetailModel.contactID,
//                                    "user2_id":jobDetailModel.caregiversID,
//                                    "user1_id":jobDetailModel.customerID,
//                                    "name":jobDetailModel.name,
//                                    "profile_picture_url":jobDetailModel.profilePictureURL
//                                ])
//                                
//                                ChatScreenViewModel.selectedChat = selectedChat
//                                router.showScreen(.push) { rout in
//                                        ChatView(userName: (viewModel.jobDetailModel?.name ?? ""),viewModel: ChatScreenViewModel)
//                                }
//                            }
                        }
                    }
            }
        }
        .padding(.top , 24)
    }
    
    private var JobScheduleView: some View {
        VStack(alignment: .leading) {
            Text("Job Schedule")
                .font(.custom(FontContent.plusMedium, size: 13))
                .foregroundStyle(._7_C_7_C_80)
                .padding(.bottom, 10)


            ForEach (0...6) { _ in
                
                HStack {
                    Text("Sunday")
                        .font(.custom(FontContent.plusRegular, size: 12))
                        .foregroundStyle(.appMain)
                    
                    Spacer()
                    
                    Text("6:00 AM - 12:00 PM")
                        .font(.custom(FontContent.plusRegular, size: 12))
                        .foregroundStyle(.appMain)
                }                
            }
        }
        .padding([.top, .horizontal], 24)
        
    }
    
    private var OtherMedicalConditionView: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Other Medical Conditions")
                    .font(.custom(FontContent.plusMedium, size: 17))
                    .foregroundStyle(._7_C_7_C_80)

                Text(viewModel.otherDiseaseType)
                    .font(.custom(FontContent.plusRegular, size: 15))
                    .foregroundStyle(.appMain)
            }
            
            Spacer()
        }
        .padding(.top, 16)
        .padding(.horizontal, 24)

    }
    
    private var line: some View {
        Divider()
            .background(.F_2_F_2_F_7)
            .padding(.top, 24)
            .padding(.horizontal, 24)
            .frame(height: 2)
    }

    
    private var UserView: some View{
        VStack {
            HStack {
                ImageLoadingView(imageURL: viewModel.jobDetailModel?.profilePictureURL ?? "")
                    .frame(width: 126, height: 126)
                    .cornerRadius(63)
                    .clipped()
            }
            .frame(width: 138, height: 138)
            .overlay(
                RoundedRectangle(cornerRadius: 69)
                    .inset(by: 1)
                    .stroke(.E_5_E_5_EA, lineWidth: 1)
            )
            
            Text(viewModel.jobDetailModel?.name ?? "")
                .font(.custom(FontContent.besMedium, size: 20))
                .foregroundStyle(.appMain)
            
            if !viewModel.isComingfromChat{
                Text("Message")
                    .font(.custom(FontContent.plusMedium, size: 16))
                    .foregroundStyle(.white)
                    .padding(.vertical,10)
                    .padding(.horizontal,20)
                    .asButton(.press) {
                        let ChatScreenViewModel = ChatScreenViewModel()
                        guard let jobDetailModel = viewModel.jobDetailModel else {
                            return
                        }
                        let selectedChat = ChatListData(jsonData: [
                            "id":jobDetailModel.contactID,
                            "user2_id":jobDetailModel.caregiversID,
                            "user1_id":jobDetailModel.customerID,
                            "name":jobDetailModel.name,
                            "profile_picture_url":jobDetailModel.profilePictureURL
                        ])
                        
                        ChatScreenViewModel.selectedChat = selectedChat
                        router.showScreen(.push) { rout in
                                ChatView(userName: (viewModel.jobDetailModel?.name ?? ""),viewModel: ChatScreenViewModel)
                        }
                    }
                    .background{
                        RoundedRectangle(cornerRadius: 24)
                    }
                    .padding(.top,10)
            }
        }
        .padding(.top, 24)
    }
    
    private var ServiceRequiredView: some View{
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text("Service Required")
                    .font(.custom(FontContent.plusMedium, size: 17))
                    .foregroundStyle(._7_C_7_C_80)

                Text(viewModel.jobDetailModel?.areasOfExpertise.joined(separator: ",") ?? "hjafsgfjh,ahgsfjh")
                    .font(.custom(FontContent.plusRegular, size: 15))
                    .foregroundStyle(.appMain)
            }
            Spacer()
        }
        .padding([.top, .horizontal], 24)

    }
    
    func getArrayOfSkillsRequired() -> [SkillData] {
        
        var arr = [SkillData]()
        
        for value in (viewModel.jobDetailModel?.additionalSkills ?? []) {
            arr.append(SkillData(image: value.replacingOccurrences(of: "/", with: ""), title: value))
        }
        
        return arr
    }
    
    func getArrayOfPersonalPrefernces() -> [SkillData] {
        
        var arr = [SkillData]()
        
        for value in (viewModel.jobDetailModel?.additionalInfo ?? []) {
            arr.append(SkillData(image: value.replacingOccurrences(of: "/", with: ""), title: value))
        }
        
        return arr
    }

}

struct SkillData {
    var image: String
    var title: String
}

#Preview {
    JobDetailView(jobID: "")
}
//(customerInfo: CustomerInfo(name: "Alex Chatterjee", gender: "Male", price: "40.0", diseaseType: ["Diabetes", "Kidney Stone"]), bookingDetails: BookingDetails(areaOfExpertise: ["Nursing", "Bathing", "House Cleaning","Doing Chores and more"], bookingType: "One Time", startDate: "2024-06-14", endDate: "2024-06-14", startTime: "09:45:18", endTime: "00:40:22"), jobID: "f9bdf7df-103e-41b9-a95e-560b85c5bde1")
