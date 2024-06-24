//
//  BookingCareGiverListView.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 04/06/24.
//

import SwiftUI
import SwiftfulUI

struct BookingCareGiverListView: View {
    var onSelectedValue: ((CareGiverNearByCustomerScreenData)->Void)? = nil
    var careGiverNearByList: [CareGiverNearByCustomerScreenData] = [CareGiverNearByCustomerScreenData]()
    var body: some View {
        VStack(spacing:0){
            ForEach(careGiverNearByList,id: \.id){ giver in
                giverView(giver: giver)
                    .asButton(.press) {
                        onSelectedValue?(giver)
                    }
                    .padding(.top,15)
            }
        }
    }
    
    private func giverView(giver:CareGiverNearByCustomerScreenData)-> some View{
        HStack(spacing:0){
            
            AsyncImage(url: URL(string: giver.profile),content: { image in
                image
                    .resizable()
            },placeholder: {
                ProgressView()
            })
                .frame(width: 64,height: 64)
                .clipShape(.rect(cornerRadius: 32))
            
            VStack(alignment:.leading, spacing:0){
                Text(giver.name)
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .font(.custom(FontContent.besMedium, size: 17))
                
                Text("\(giver.yearsOfExprience) Years Expirenced")
                    .font(.custom(FontContent.plusRegular, size: 12))
                
                HStack{
                    StarsView(rating: 3.5, maxRating: 5, size: 12)
                    
                    Text("(100)")
                        .font(.custom(FontContent.plusRegular, size: 11))
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.leading,23)
            
            Text("$\(giver.price)")
                .font(.custom(FontContent.plusMedium, size: 12))
                .frame(maxHeight: .infinity,alignment: .top)
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
    BookingCareGiverListView()
}
