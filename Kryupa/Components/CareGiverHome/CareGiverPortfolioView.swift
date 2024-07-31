//
//  CareGiverPortfolioView.swift
//  Kryupa
//
//  Created by Pooja Nenava on 04/06/24.
//

import SwiftUI

struct CareGiverPortfolioView: View {
    
    var job: JobPost
    var accept:(()->Void)
    var view:(()->Void)
    let profileWidth:CGFloat = CGFloat((UIScreen.screenWidth - 106))

    var body: some View {
        VStack(spacing:10){
            
            HStack {
                ImageLoadingView(imageURL: job.customerInfo.profilePictureUrl)
                    .frame(width: 58,height: 58)
                    .cornerRadius(29)

                
                VStack(spacing: 2) {
                    Text(job.customerInfo.name)
                        .font(.custom(FontContent.besMedium, size: 16))
                        .foregroundStyle(.appMain)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("$\(job.customerInfo.price)")
                        .font(.custom(FontContent.plusRegular, size: 13))
                        .foregroundStyle(.appMain)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }

            JobDescView(startDate: job.bookingDetails.startDate, startTime: job.bookingDetails.startTime, endTime: job.bookingDetails.endTime, gender: job.customerInfo.gender, diseaseType: job.customerInfo.diseaseType)

            VStack(spacing: 2) {
                Text("Service Required:")
                    .padding(.top, 10)
                    .padding(.horizontal, 22)
                    .font(.custom(FontContent.plusRegular, size: 11))
                    .foregroundStyle(.appMain)
                    .frame(maxWidth: .infinity, alignment: .leading)


                Text(job.bookingDetails.areaOfExpertise.joined(separator: ","))
                    .padding(.bottom, 10)
                    .font(.custom(FontContent.plusRegular, size: 11))
                    .foregroundStyle(._7_C_7_C_80)
                    .padding(.horizontal, 22)
                    .frame(maxWidth: .infinity, alignment: .leading)

            }
            .frame(maxHeight: .infinity)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .inset(by: 1)
                    .stroke(.E_5_E_5_EA, lineWidth: 1)
            )
            .padding(.top, 10)
//            .padding(.horizontal, 21)


            HStack {
                Text("View Profile")
                    .font(.custom(FontContent.plusRegular, size: 16))
                    .foregroundStyle(.appMain)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 20)
                    .asButton(.press) {
                        view()
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 48)
                            .inset(by: 1)
                            .stroke(.appMain, lineWidth: 1)
                    )
                    .asButton(.press) {
                        view()
                    }
//                
//                Spacer()
//                
//                Text("Accept")
//                    .font(.custom(FontContent.plusRegular, size: 16))
//                    .foregroundStyle(.white)
//                    .frame(height: 32)
//                    .frame(width: 97)
//                    .background{
//                        RoundedRectangle(cornerRadius: 48)
//                    }
//                    .asButton(.press) {
//                        accept()
//                    }
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 21)
            
        }
        .padding([.vertical,.horizontal],20)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .inset(by: 1)
                .stroke(.E_5_E_5_EA, lineWidth: 1)
        )
        .frame(width: profileWidth)

    }
}
struct JobDescView: View {
    
//    var job: JobPost
    var startDate: String
    var startTime: String
    var endTime: String
    var gender: String
    var diseaseType: [String]

    var body: some View {
        VStack {
            
            HStack(spacing:5){
                Image("calender")
                    .resizable()
                    .frame(width: 18,height: 18)
//                Text(job.bookingDetails.startDate.convertDateFormater(beforeFormat: "YYYY-MM-dd", afterFormat: "dd MMM yyyy"))
                Text(startDate)
                    .font(.custom(FontContent.plusRegular, size: 12))
                    .foregroundStyle(._444446)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            
            HStack(spacing:5){
                Image("clock")
                    .resizable()
                    .frame(width: 18,height: 18)
//                Text("\(job.bookingDetails.startTime.convertDateFormater(beforeFormat: "HH:mm:ss", afterFormat: "h:mm a")) - \(job.bookingDetails.endTime.convertDateFormater(beforeFormat: "HH:mm:ss", afterFormat: "h:mm a"))")
                Text("\(startTime) - \(endTime)")
                    .font(.custom(FontContent.plusRegular, size: 12))
                    .foregroundStyle(._444446)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            HStack {
                
                HStack(spacing:2){
                    Image("account")
                        .resizable()
                        .frame(width: 18,height: 18)
//                    Text(job.customerInfo.gender)
                    Text(gender)
                        .minimumScaleFactor(0.01)
                        .font(.custom(FontContent.plusRegular, size: 12))
                        .foregroundStyle(._444446)
                }
                //                .frame(maxWidth: .infinity)
                
//                HStack(spacing:2){
//                    Image("weight")
//                        .resizable()
//                        .frame(width: 18,height: 18)
//                    Text("100 kg")
//                        .font(.custom(FontContent.plusRegular, size: 12))
//                        .foregroundStyle(._444446)
//                }
                //                .frame(maxWidth: .infinity)
                
                HStack(spacing:2){
                    Image("Location")
                        .resizable()
                        .frame(width: 18,height: 18)
                    Text("5 mil")
                        .font(.custom(FontContent.plusRegular, size: 12))
                        .foregroundStyle(._444446)
                }
                //                .frame(maxWidth: .infinity)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            
            HStack(spacing:5){
                Image("heartbeat")
                    .resizable()
                    .frame(width: 18,height: 18)
//                Text(job.customerInfo.diseaseType.joined(separator: ","))
                Text(diseaseType.joined(separator:","))
                    .font(.custom(FontContent.plusRegular, size: 12))
                    .foregroundStyle(._444446)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding(.top, 10)
    }
}

#Preview {
    CareGiverPortfolioView(job: JobPost(jsonData: [String : Any]()), accept: {}, view: {})
}
//(customerInfo: CustomerInfo(name: "Alex Chatterjee", gender: "Male", price: "40.0", diseaseType: ["Diabetes", "Kidney Stone"]), bookingDetails: BookingDetails(areaOfExpertise: ["Nursing", "Bathing", "House Cleaning","Doing Chores and more"], bookingType: "One Time", startDate: "2024-06-14", endDate: "2024-06-14", startTime: "09:45:18", endTime: "00:40:22"), jobID: "f9bdf7df-103e-41b9-a95e-560b85c5bde1")
