//
//  BookingView.swift
//  Kryupa
//
//  Created by Hemant Singh Rajput on 14/06/24.
//

import SwiftUI

struct BookingView: View {
    
    var status: String = "Active"
    var statusColor: Color {
        if status == "Cancelled"{
            return .D_3180_C
        }else{
            return ._23_C_16_B
        }
    }
    
    var statusBackColor: Color {
        if status == "Cancelled"{
            return .FFE_3_E_3
        }else{
            return .E_0_FFEE
        }
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 20){
            Image("reviewUser")
                .resizable()
                .frame(width: 60, height: 60)
                .cornerRadius(30)
            
            VStack(alignment: .leading, spacing: 3) {
                HStack {
                    Text("Alexa Chatterjee")
                        .font(.custom(FontContent.besMedium, size: 15))
                        .foregroundStyle(.appMain)
                    
                    Spacer()
                    
                    Text(status)
                        .padding()
                        .frame(height: 23)
                        .font(.custom(FontContent.plusMedium, size: 11))
                        .foregroundStyle(statusColor)
                        .background(
                            RoundedRectangle(cornerRadius: 12).fill(statusBackColor)
                        )
                }

                Text("$325.21")
                    .font(.custom(FontContent.plusMedium, size: 12))
                    .foregroundStyle(._444446)
                
                Text("3rd March - 5th March 2024 ")
                    .font(.custom(FontContent.plusRegular, size: 12))
                    .foregroundStyle(._444446)
                
                Text("Companionship")
                    .font(.custom(FontContent.plusRegular, size: 12))
                    .foregroundStyle(._444446)
            }
        }
        .padding([.vertical,.horizontal],10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .inset(by: 1)
                .stroke(.E_5_E_5_EA, lineWidth: 1)
        )
        .padding(.horizontal, 24)
    }
}

#Preview {
    BookingView()
}
