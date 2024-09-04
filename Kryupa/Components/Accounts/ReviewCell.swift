//
//  ReviewCell.swift
//  Kryupa
//
//  Created by Pooja Nenava on 12/06/24.
//

import SwiftUI

struct ReviewCell: View {
    @State var reviewData: ReviewData?
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 15) {
                
                
                
                ImageLoadingView(imageURL: reviewData?.profilePictureUrl ?? "")
                    .frame(width: 60, height: 60)
                    .cornerRadius(30)
                    .clipped()
                
                VStack(alignment: .leading) {
                    Text(reviewData?.name ?? "Nirmal")
                        .font(.custom(FontContent.besMedium, size: 15))
                        .foregroundStyle(.appMain)
                        .padding(.bottom, 1)
                    let createdDate = reviewData?.createdAt.split(separator: " ").first ?? ""
                    Text(String(createdDate).convertDateFormater(beforeFormat: "yyyy-MM-dd", afterFormat: "MMM dd"))
                        .font(.custom(FontContent.plusRegular, size: 15))
                        .foregroundStyle(._444446)
                    HStack {
                        StarsView(rating: Double(reviewData?.rating.getFullRateVal() ?? 0), maxRating: 5, size: 20)
                    }
                }
                
                Spacer()
            }
            
            Text(reviewData?.review ?? "")
                .font(.custom(FontContent.plusRegular, size: 15))
                .foregroundStyle(._444446)
                .padding(.top, 5)
            
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 11)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .inset(by: 1)
                .stroke(.E_5_E_5_EA, lineWidth: 1)
        )
        .padding(.horizontal, 24)
    }
}

#Preview {
    ReviewCell()
}
