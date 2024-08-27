//
//  ReviewListView.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 05/06/24.
//

import SwiftUI

struct ReviewListView: View {
    var reviewList: [ReviewListData] = [ReviewListData]()
    
    var body: some View {
        VStack(spacing:0){
            
            ForEach(reviewList, id: \.reviewID){ data in
                ReviewView(reviewData: data)
                    .padding(.top,15)
            }
        }
    }
    
    private func ReviewView(reviewData:ReviewListData)-> some View{
        VStack(alignment:.leading){
            HStack(spacing:0){
                
                ImageLoadingView(imageURL: reviewData.reviewedByProfilePictureURL)
                    .frame(width: 64,height: 64)
                    .clipShape(.rect(cornerRadius: 32))
                    .clipped()
                VStack(alignment:.leading, spacing:5){
                    Text(reviewData.reviewedByName)
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .font(.custom(FontContent.besMedium, size: 17))
                    
                    Text("5 Years Expirenced")
                        .font(.custom(FontContent.plusRegular, size: 12))
                    
                    StarsView(rating: reviewData.rating, maxRating: 5, size: 12)
                        
                }
                .frame(maxWidth: .infinity)
                .padding(.leading,23)
            }
            
            Text(reviewData.review)
                .font(.custom(FontContent.plusRegular, size: 11))
        }
        .padding(.vertical,9)
        .padding(.horizontal,10)
        .background{
            RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 1.0)
                .foregroundStyle(.E_5_E_5_EA)
        }
    }
}

#Preview {
    ReviewListView()
}
