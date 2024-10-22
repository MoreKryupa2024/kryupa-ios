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
                    .clipped()
                
                VStack(spacing: 2) {
                    Text(job.customerInfo.name)
                        .font(.custom(FontContent.besMedium, size: 16))
                        .foregroundStyle(.appMain)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("$\(job.customerInfo.price)")
                        .font(.custom(FontContent.plusMedium, size: 15))
                        .foregroundStyle(.appMain)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }

            JobDescView(startDate: "\(job.bookingDetails.startDate.convertDateFormater(beforeFormat: "YYYY-MM-dd", afterFormat: "MMM dd yyyy"))",
                        startTime: (job.bookingDetails.startTime.convertDateFormater(beforeFormat: "HH:mm:ss",
                                                                                     afterFormat: "h:mm a")),
                        endTime: (job.bookingDetails.endTime.convertDateFormater(beforeFormat: "HH:mm:ss",
                                                                                 afterFormat: "h:mm a")), 
                        gender: job.customerInfo.gender,
                        diseaseType: job.customerInfo.diseaseType)
            

            VStack(spacing: 2) {
                Text("Service Required:")
                    .padding(.top, 5)
                    .padding(.horizontal, 15)
                    .font(.custom(FontContent.plusRegular, size: 13))
                    .foregroundStyle(.appMain)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(job.bookingDetails.areaOfExpertise.joined(separator: ","))
                    .padding(.bottom, 5)
                    .font(.custom(FontContent.plusRegular, size: 15))
                    .foregroundStyle(._7_C_7_C_80)
                    .padding(.horizontal, 15)
                    .frame(maxWidth: .infinity, alignment: .leading)

            }
            .frame(maxHeight: .infinity)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .inset(by: 1)
                    .stroke(.E_5_E_5_EA, lineWidth: 1)
            )
            .padding(.top, 10)


            HStack {
                Text("View Booking")
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
    var hours: String = ""
    var price: String = ""
    var startTime: String
    var endTime: String
    var gender: String
    var diseaseType: [String]

    var body: some View {
        VStack {
            
            HStack(spacing:5){
                Image("calender")
                    .resizable()
                    .frame(width: 22,height: 22)
//                Text(job.bookingDetails.startDate.convertDateFormater(beforeFormat: "YYYY-MM-dd", afterFormat: "dd MMM yyyy"))
                Text(startDate)
                    .font(.custom(FontContent.plusRegular, size: 15))
                    .foregroundStyle(._444446)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            
            HStack(spacing:5){
                Image("clock")
                    .resizable()
                    .frame(width: 22,height: 22)
//                Text("\(job.bookingDetails.startTime.convertDateFormater(beforeFormat: "HH:mm:ss", afterFormat: "h:mm a")) - \(job.bookingDetails.endTime.convertDateFormater(beforeFormat: "HH:mm:ss", afterFormat: "h:mm a"))")
                Text("\(startTime) - \(endTime)")
                    .font(.custom(FontContent.plusRegular, size: 15))
                    .foregroundStyle(._444446)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            if !price.isEmpty || !hours.isEmpty{
                HStack(spacing:15){
                    if !hours.isEmpty{
                        HStack(spacing:2){
                            
                            Image("hours")
                                .resizable()
                                .frame(width: 22,height: 22)
                            Text("\(hours) Hours")
                                .font(.custom(FontContent.plusRegular, size: 15))
                                .foregroundStyle(._444446)
                        }
                    }
                    if !price.isEmpty{
                        HStack(spacing:2){
                            Image("dollar")
                                .resizable()
                                .frame(width: 22,height: 22)
                            Text("\(price)")
                                .font(.custom(FontContent.plusRegular, size: 15))
                                .foregroundStyle(._444446)
                        }
                    }
                    Spacer()
                }
            }
            
            HStack {
                
                HStack(spacing:2){
                    Image("account")
                        .resizable()
                        .frame(width: 22,height: 22)
//                    Text(job.customerInfo.gender)
                    Text(gender)
                        .minimumScaleFactor(0.01)
                        .font(.custom(FontContent.plusRegular, size: 15))
                        .foregroundStyle(._444446)
                }
                //                .frame(maxWidth: .infinity)
                

                //                .frame(maxWidth: .infinity)
                
//                HStack(spacing:2){
//                    Image("Location")
//                        .resizable()
//                        .frame(width: 22,height: 22)
//                    Text("5 mil")
//                        .font(.custom(FontContent.plusRegular, size: 15))
//                        .foregroundStyle(._444446)
//                }
                //                .frame(maxWidth: .infinity)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            
            HStack(spacing:5){
                Image("heartbeat")
                    .resizable()
                    .frame(width: 22,height: 22)
//                Text(job.customerInfo.diseaseType.joined(separator: ","))
                Text(diseaseType.joined(separator:","))
                    .font(.custom(FontContent.plusRegular, size: 15))
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
