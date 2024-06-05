//
//  CareGiverPortfolioView.swift
//  Kryupa
//
//  Created by Pooja Nenava on 04/06/24.
//

import SwiftUI

struct CareGiverPortfolioView: View {
    
    let profileWidth:CGFloat = CGFloat((UIScreen.screenWidth - 106))

    var body: some View {
        VStack(spacing:10){
            
            HStack {
                Image("jobProfile")
                    .resizable()
                    .frame(width: 58,height: 58)
                
                VStack(spacing: 2) {
                    Text("Alex Chatterjee")
                        .font(.custom(FontContent.besMedium, size: 16))
                        .foregroundStyle(._242426)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("$40.00")
                        .font(.custom(FontContent.plusRegular, size: 13))
                        .foregroundStyle(._242426)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }

            HStack(spacing:5){
                Image("calender")
                    .resizable()
                    .frame(width: 18,height: 18)
                Text("3rd March 2024")
                    .font(.custom(FontContent.plusRegular, size: 12))
                    .foregroundStyle(._444446)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }

            
            HStack(spacing:5){
                Image("clock")
                    .resizable()
                    .frame(width: 18,height: 18)
                Text("03:00 PM - 04:00 PM")
                    .font(.custom(FontContent.plusRegular, size: 12))
                    .foregroundStyle(._444446)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }

            HStack {
                
                HStack(spacing:2){
                    Image("account")
                        .resizable()
                        .frame(width: 18,height: 18)
                    Text("Female")
                        .minimumScaleFactor(0.01)
                        .font(.custom(FontContent.plusRegular, size: 12))
                        .foregroundStyle(._444446)
                }
//                .frame(maxWidth: .infinity)

                HStack(spacing:2){
                    Image("weight")
                        .resizable()
                        .frame(width: 18,height: 18)
                    Text("100 kg")
                        .font(.custom(FontContent.plusRegular, size: 12))
                        .foregroundStyle(._444446)
                }
//                .frame(maxWidth: .infinity)

                HStack(spacing:2){
                    Image("Location")
                        .resizable()
                        .frame(width: 18,height: 18)
                    Text("5 mil")
                        .font(.custom(FontContent.plusRegular, size: 12))
                        .foregroundStyle(._444446)
                }
//                .frame(maxWidth: .infinity)
            }
            .frame(maxWidth: .infinity, alignment: .leading)


            HStack(spacing:5){
                Image("heartbeat")
                    .resizable()
                    .frame(width: 18,height: 18)
                Text("Diabetes, Kidney Stone")
                    .font(.custom(FontContent.plusRegular, size: 12))
                    .foregroundStyle(._444446)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }

            VStack(spacing: 2) {
                Text("Service Required:")
                    .padding(.top, 10)
                    .padding(.horizontal, 22)
                    .font(.custom(FontContent.plusRegular, size: 11))
                    .foregroundStyle(._242426)
                    .frame(maxWidth: .infinity, alignment: .leading)


                Text("Nursing, Bathing, House Cleaning,Doing Chores and more")
                    .padding(.bottom, 10)
                    .font(.custom(FontContent.plusRegular, size: 11))
                    .foregroundStyle(._7_C_7_C_80)
                    .padding(.horizontal, 22)
                    .frame(maxWidth: .infinity, alignment: .leading)

            }
            .frame(maxHeight: .infinity)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .inset(by: 1)
                    .stroke(.E_5_E_5_EA, lineWidth: 1)
            )
            .padding(.top, 10)
            .padding(.horizontal, 21)


            HStack {
                Text("View")
                    .font(.custom(FontContent.plusRegular, size: 16))
                    .foregroundStyle(._242426)
                    .frame(height: 32)
                    .frame(width: 78)
                    .asButton(.press) {
                        
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 48)
                            .inset(by: 1)
                            .stroke(._242426, lineWidth: 1)
                    )

                
                Spacer()
                
                Text("Accept")
                    .font(.custom(FontContent.plusRegular, size: 16))
                    .foregroundStyle(.white)
                    .frame(height: 32)
                    .frame(width: 97)
                    .background{
                        RoundedRectangle(cornerRadius: 48)
                    }
                    .asButton(.press) {
                        
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

#Preview {
    CareGiverPortfolioView()
}
