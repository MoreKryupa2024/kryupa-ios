//
//  ReviewListView.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 05/06/24.
//

import SwiftUI

struct ReviewListView: View {
    
    var body: some View {
        VStack(spacing:0){
            ForEach(1...10){ index in
                ReviewView
                    .padding(.top,15)
            }
        }
    }
    
    private var ReviewView: some View{
        VStack{
            HStack(spacing:0){
                
                Image("profile")
                    .resizable()
                    .clipShape(Circle())
                    .frame(width: 63,height: 63)
                
                VStack(alignment:.leading, spacing:5){
                    Text("Alexa Chatterjee")
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .font(.custom(FontContent.besMedium, size: 17))
                    
                    Text("5 Years Expirenced")
                        .font(.custom(FontContent.plusRegular, size: 12))
                    
                    Image(systemName: "star.fill")
                        .resizable()
                        .frame(width: 12,height: 12)
                }
                .frame(maxWidth: .infinity)
                .padding(.leading,23)
            }
            
            Text("Lorem ipsum dolor sit amet consectetur. Tempus commodo cursus libero nullam vitae. Tempus neque duis enim tellus tortor elit eu commodo netus.")
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
