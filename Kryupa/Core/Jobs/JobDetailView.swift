//
//  JobDetailView.swift
//  Kryupa
//
//  Created by Pooja Nenava on 17/06/24.
//

import SwiftUI
import SwiftfulUI

struct JobDetailView: View {

    var job: JobPost
    
    var body: some View {
        ScrollView {
            HeaderView(showBackButton: true)
            UserView
            ServiceRequiredView
            line
            JobDescView(job: job)
                .padding(.horizontal, 24)
                .padding(.top, 24)
            OtherMedicalConditionView
            line
            JobScheduleView
            line
            getGridView(heading: "Skills Required", skillsList: [
                SkillData(image: "smoking", title: "Feeding"),
                SkillData(image: "car", title: "Transportation"),
                SkillData(image: "shower-head", title: "Bathing / dressing"),
                SkillData(image: "shopping", title: "Errands / Shopping"),
                SkillData(image: "tools-kitchen-2", title: "Meal Preparation"),
                SkillData(image: "vacuum-cleaner", title: "Light Housekeeping")
            ])
            line
            getGridView(heading: "Personal Preferences", skillsList: [
                SkillData(image: "injection", title: "Covid Vaccinated"),
                SkillData(image: "smoking", title: "Non Smoker"),
                SkillData(image: "First_Aid", title: "CRP First Aid Trained"),
                SkillData(image: "car", title: "Own Transportation")
            ])
            bottomButtonView
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
    func getGridView(heading: String, skillsList: [SkillData]) -> some View{
                
        VStack(alignment: .leading){
            HStack(spacing:0){
                Text(heading)
                    .font(.custom(FontContent.plusMedium, size: 13))
                    .foregroundStyle(._7_C_7_C_80)
            }
            
            
            ZStack{
                NonLazyVGrid(columns: 2, alignment: .leading, spacing: 10, items: skillsList) { skill in

                    HStack {
                        Image(skill!.image)
                            .resizable()
                            .frame(width: 20, height: 20)
                        
                        Text(skill!.title)
                            .font(.custom(FontContent.plusRegular, size: 12))
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
        HStack(spacing: 30) {
            Text("Decline")
                .font(.custom(FontContent.plusRegular, size: 16))
                .foregroundStyle(.appMain)
                .frame(height: 35)
                .frame(width: 99)
                .asButton(.press) {
                    
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
                    .font(.custom(FontContent.plusMedium, size: 13))
                    .foregroundStyle(._7_C_7_C_80)

                Text("BP, Depression, Bipolar, Borderline")
                    .font(.custom(FontContent.plusRegular, size: 12))
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
                Image("giveReview")
                    .resizable()
                    .frame(width: 126, height: 126)
                    .cornerRadius(63)
            }
            .frame(width: 138, height: 138)
            .overlay(
                RoundedRectangle(cornerRadius: 69)
                    .inset(by: 1)
                    .stroke(.E_5_E_5_EA, lineWidth: 1)
            )
            
            Text("Tiana Gouse")
                .font(.custom(FontContent.besMedium, size: 20))
                .foregroundStyle(.appMain)

            Text("$214.21")
                .font(.custom(FontContent.plusRegular, size: 12))
                .foregroundStyle(.appMain)

        }
        .padding(.top, 24)
    }
    
    private var ServiceRequiredView: some View{
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text("Service Required")
                    .font(.custom(FontContent.plusMedium, size: 13))
                    .foregroundStyle(._7_C_7_C_80)

                Text("Nursing, Physical Therapy, Occupational Therapy")
                    .font(.custom(FontContent.plusRegular, size: 12))
                    .foregroundStyle(.appMain)
            }
            Spacer()
        }
        .padding([.top, .horizontal], 24)

    }
}

struct SkillData {
    var image: String
    var title: String
}

#Preview {
    JobDetailView(job: JobPost(customerInfo: CustomerInfo(name: "Alex Chatterjee", gender: "Male", price: "40.0", diseaseType: ["Diabetes", "Kidney Stone"]), bookingDetails: BookingDetails(areaOfExpertise: ["Nursing", "Bathing", "House Cleaning","Doing Chores and more"], bookingType: "One Time", startDate: "2024-06-14", endDate: "2024-06-14", startTime: "09:45:18", endTime: "00:40:22"), jobID: "f9bdf7df-103e-41b9-a95e-560b85c5bde1"))
}
