//
//  ReviewDetailView.swift
//  Kryupa
//
//  Created by Pooja Nenava on 13/06/24.
//

import SwiftUI

struct ReviewDetailView: View {
    var body: some View {
        ScrollView {
            HeaderView()
            VStack {
                
                UserView
                line
                DescView
                line
                ReviewView
            }
        }
    }
    
    private var ReviewView: some View{
        VStack(alignment: .leading, spacing: 10) {
            Text("Review:")
                .font(.custom(FontContent.plusMedium, size: 13))
                .foregroundStyle(._7_C_7_C_80)
            
            HStack(spacing: 1) {
                ForEach (0...3) {_ in
                    Image("star")
                        .resizable()
                        .frame(width: 20, height: 20)
                }
            }
            
            Text("Lorem ipsum dolor sit amet consectetur. Dui in parturient odio pellentesque metus. Et rutrum mauris nunc ipsum eros vulputate tortor. Sagittis enim feugiat mauris ultricies vitae facilisis diam. Enim quis diam porttitor praesent eget gravida. Eget sit dictum nunc in. Egestas odio varius morbi enim placerat sed mi mauris pellentesque. Blandit est etiam tincidunt euismod nibh diam tempus arcu nulla.")
                .font(.custom(FontContent.plusRegular, size: 12))
                .foregroundStyle(._444446)
        }
        .padding([.horizontal, .top], 24)
    }
    
    private var UserView: some View{
        VStack(spacing: 5) {
            HStack{
                Image("reviewUser")
                    .resizable()
                    .frame(width: 126, height: 126)
                    .cornerRadius(63)
                
            }
            .frame(width: 138, height: 138)
            .overlay(
                RoundedRectangle(cornerRadius: 69)
                    .inset(by: 1)
                    .stroke(.E_5_E_5_EA, lineWidth: 1)
            )
            
            Text("Alexa Chatterjee")
                .font(.custom(FontContent.besMedium, size: 20))
                .foregroundStyle(.appMain)
            
            HStack {
                ForEach (0...3) {_ in
                    Image("star")
                        .resizable()
                        .frame(width: 12, height: 12)
                }
                Text("(100)")
                    .font(.custom(FontContent.plusRegular, size: 11))
                    .foregroundStyle(.appMain)
            }
        }
        .padding(.top, 20)
    }
    
    private var DescView: some View{
        VStack(spacing: 10) {
            HStack {
                Text("Rate per hour:")
                    .font(.custom(FontContent.plusRegular, size: 15))
                    .foregroundStyle(.appMain)
                
                Spacer()
                
                Text("$20.23")
                    .font(.custom(FontContent.plusRegular, size: 16))
                    .foregroundStyle(.appMain)
            }
            
            HStack {
                Text("Number of hours:")
                    .font(.custom(FontContent.plusRegular, size: 15))
                    .foregroundStyle(.appMain)
                
                Spacer()
                
                Text("6")
                    .font(.custom(FontContent.plusRegular, size: 16))
                    .foregroundStyle(.appMain)
            }
            
            HStack {
                Text("Total:")
                    .font(.custom(FontContent.plusRegular, size: 15))
                    .foregroundStyle(.appMain)
                
                Spacer()
                
                Text("$121.38")
                    .font(.custom(FontContent.plusRegular, size: 16))
                    .foregroundStyle(.appMain)
            }
        }
        .padding([.horizontal, .top], 24)
    }
    
    private var line: some View {
        Divider()
            .background(.F_2_F_2_F_7)
            .padding(.top, 24)
            .padding(.horizontal, 24)
            .frame(height: 2)
    }
}

#Preview {
    ReviewDetailView()
}
