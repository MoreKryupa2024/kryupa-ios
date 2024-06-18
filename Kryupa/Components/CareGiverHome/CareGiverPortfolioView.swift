//
//  CareGiverPortfolioView.swift
//  Kryupa
//
//  Created by Pooja Nenava on 04/06/24.
//

import SwiftUI

struct CareGiverPortfolioView: View {
    
    var job: JobPost

    let profileWidth:CGFloat = CGFloat((UIScreen.screenWidth - 106))

    var body: some View {
        VStack(spacing:10){
            
            HStack {
                Image("jobProfile")
                    .resizable()
                    .frame(width: 58,height: 58)
                
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

            HStack(spacing:5){
                Image("calender")
                    .resizable()
                    .frame(width: 18,height: 18)
                Text(job.bookingDetails.startDate.convertDateFormater(beforeFormat: "YYYY-MM-dd", afterFormat: "dd MMM YYYY"))
                    .font(.custom(FontContent.plusRegular, size: 12))
                    .foregroundStyle(._444446)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }

            
            HStack(spacing:5){
                Image("clock")
                    .resizable()
                    .frame(width: 18,height: 18)
                Text("\(job.bookingDetails.startTime.convertDateFormater(beforeFormat: "HH:mm:ss", afterFormat: "h:mm a")) - \(job.bookingDetails.endTime.convertDateFormater(beforeFormat: "HH:mm:ss", afterFormat: "h:mm a"))")
                    .font(.custom(FontContent.plusRegular, size: 12))
                    .foregroundStyle(._444446)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }

            HStack {
                
                HStack(spacing:2){
                    Image("account")
                        .resizable()
                        .frame(width: 18,height: 18)
                    Text(job.customerInfo.gender)
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
                Text(job.customerInfo.diseaseType.map{String($0)}.joined(separator: ","))
                    .font(.custom(FontContent.plusRegular, size: 12))
                    .foregroundStyle(._444446)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }

            VStack(spacing: 2) {
                Text("Service Required:")
                    .padding(.top, 10)
                    .padding(.horizontal, 22)
                    .font(.custom(FontContent.plusRegular, size: 11))
                    .foregroundStyle(.appMain)
                    .frame(maxWidth: .infinity, alignment: .leading)


                Text(job.bookingDetails.areaOfExpertise.map{String($0)}.joined(separator: ","))
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
            .padding(.horizontal, 21)


            HStack {
                Text("View")
                    .font(.custom(FontContent.plusRegular, size: 16))
                    .foregroundStyle(.appMain)
                    .frame(height: 32)
                    .frame(width: 78)
                    .asButton(.press) {
                        
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 48)
                            .inset(by: 1)
                            .stroke(.appMain, lineWidth: 1)
                    )

                
                Spacer()
                
                Text("Accept")
                    .font(.custom(FontContent.plusRegular, size: 16))
                    .foregroundStyle(.white)
                    .frame(height: 32)
                    .frame(width: 97)
                    .background{
                        RoundedRectangle(cornerRadius: 48)
                    }
                    .asButton(.press) {
                        
                    }
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

//#Preview {
//    CareGiverPortfolioView(job: JobPost(customerInfo: CustomerInfoData(name: "Alex Chatterjee", gender: "Male", price: "$40.00", diseaseType: ["Diabetes", "Heart Conditions"]), bookingDetails: BookingDetailsData(areaOfExpertise: ["Nursing", "Physical Tharapy"], bookingType: "One Time", startDate: "2024-06-04", endDate: "2024-06-04", startTime: "15:44:05", endTime: "15:56:00"), jobId: "abc"))
//}
