//
//  BookingCareGiverListView.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 04/06/24.
//

import SwiftUI
import SwiftfulUI

struct BookingCareGiverListView: View {
    
    var careGiverNear: CareGiverNearByCustomerScreenData
    var body: some View {
        giverView(giver: careGiverNear)
    }
    
    private func giverView(giver:CareGiverNearByCustomerScreenData)-> some View{
        HStack(spacing:0){
            
            ImageLoadingView(imageURL:giver.profile)
                .frame(width: 64,height: 64)
                .clipShape(.rect(cornerRadius: 32))
                .clipped()
            VStack(alignment:.leading, spacing:0){
                Text(giver.name)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .font(.custom(FontContent.besMedium, size: 17))
                
                Text("\(giver.yearsOfExprience) Years Expirenced")
                    .font(.custom(FontContent.plusRegular, size: 12))
                    .padding(.bottom,5)
                HStack{
                    StarsView(rating: 3.5, maxRating: 5, size: 12)
                    
                    Text("(100)")
                        .font(.custom(FontContent.plusRegular, size: 11))
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.leading,23)
            
            Text("$\(giver.price)")
                .font(.custom(FontContent.plusMedium, size: 15))
                .frame(maxHeight: .infinity,alignment: .center)
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
//
//#Preview {
//    BookingCareGiverListView()
//}
