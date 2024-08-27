//
//  JobCell.swift
//  Kryupa
//
//  Created by Pooja Nenava on 17/06/24.
//

import SwiftUI

struct JobCell: View {
    
    let jobPostData: JobPost
    var body: some View {
        HStack {
            
            ImageLoadingView(imageURL: jobPostData.customerInfo.profilePictureUrl)
                .frame(width: 63, height: 63)
                .cornerRadius(31)
                .clipped()
            
            VStack(alignment: .leading) {
                HStack {
                    Text(jobPostData.customerInfo.name)
                        .font(.custom(FontContent.besMedium, size: 17))
                        .foregroundStyle(.appMain)

                    Spacer()
                    
                    Text("$\(jobPostData.customerInfo.price)")
                        .font(.custom(FontContent.plusMedium, size: 12))
                        .foregroundStyle(.appMain)
                }
                
                Text("\(jobPostData.bookingDetails.startDate.convertDateFormater(beforeFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", afterFormat: "d MMMM")) - \(jobPostData.bookingDetails.endDate.convertDateFormater(beforeFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", afterFormat: "d MMMM yyyy"))")
                    .font(.custom(FontContent.plusRegular, size: 12))
                    .foregroundStyle(._444446)

                Text(jobPostData.bookingDetails.areaOfExpertise.joined(separator: ", "))
                    .font(.custom(FontContent.plusRegular, size: 12))
                    .foregroundStyle(._444446)
            }

        }
        .frame(height: 81)
        .padding(.horizontal, 10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .inset(by: 1)
                .stroke(.E_5_E_5_EA, lineWidth: 1)
        )
        .padding(.horizontal, 24)
    }
}
