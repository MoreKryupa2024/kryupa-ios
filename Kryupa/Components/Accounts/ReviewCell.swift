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
        LazyVStack(alignment: .leading) {
            HStack(spacing: 15) {
                
                AsyncImage(url: URL(string: reviewData?.profilePictureUrl ?? ""),content: { image in
                    image
                        .resizable()
                },placeholder: {
                    if reviewData?.profilePictureUrl != "" && reviewData?.profilePictureUrl != nil{
                        ProgressView()
                    }
                    else {
                        Image("personal")
                            .resizable()
                    }
                })
                .frame(width: 60, height: 60)
                .cornerRadius(30)
                
                VStack(alignment: .leading) {
                    Text(reviewData?.name ?? "")
                        .font(.custom(FontContent.besMedium, size: 15))
                        .foregroundStyle(.appMain)
                    let createdDate = reviewData?.createdAt.split(separator: " ").first ?? ""
                    Text(String(createdDate).convertDateFormater(beforeFormat: "yyyy-MM-dd", afterFormat: "dd MMM"))
                        .font(.custom(FontContent.plusRegular, size: 12))
                        .foregroundStyle(._444446)
                    HStack {
                        
                        ForEach (0...(reviewData?.rating.getFullRateVal() ?? 0)) {_ in
                            Image("star")
                                .frame(width: 12, height: 12)
                        }
                        
                        if ((reviewData?.rating.addHalfRateVal()) != nil) {
                            Image("star_half")
                                .frame(width: 12, height: 12)
                        }
                        
                        if reviewData?.rating.getNoRateValue() ?? 0 > 0 {
                            ForEach (0...(reviewData?.rating.getNoRateValue() ?? 0)) {_ in
                                Image("star_unselected")
                                    .frame(width: 12, height: 12)
                            }
                        }
                        
                    }
                }
                
                Spacer()
            }
            
            Text(reviewData?.review ?? "")
                .font(.custom(FontContent.plusRegular, size: 12))
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
