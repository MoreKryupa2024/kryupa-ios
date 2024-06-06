//
//  BookingCareGiverListView.swift
//  Kryupa
//
//  Created by Hemant Singh Rajput on 04/06/24.
//

import SwiftUI

struct BookingCareGiverListView: View {
    
    var careGiverNearByList: [CareGiverNearByCustomerScreenData] = [CareGiverNearByCustomerScreenData]()
    var body: some View {
        VStack(spacing:0){
            ForEach(careGiverNearByList,id: \.id){ giver in
                giverView(giver: giver)
                    .padding(.top,15)
            }
        }
    }
    
    private func giverView(giver:CareGiverNearByCustomerScreenData)-> some View{
        HStack(spacing:0){
            
            Image("profile")
                .resizable()
                .clipShape(Circle())
                .frame(width: 63,height: 63)
            
            VStack(alignment:.leading, spacing:0){
                Text(giver.name)
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .font(.custom(FontContent.besMedium, size: 17))
                
                Text("5 Years Expirenced")
                    .font(.custom(FontContent.plusRegular, size: 12))
                
                HStack{
                    Image(systemName: "star.fill")
                        .resizable()
                        .frame(width: 12,height: 12)
                    
                    Text("(100)")
                        .font(.custom(FontContent.plusRegular, size: 11))
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.leading,23)
            
            Text("$252")
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
