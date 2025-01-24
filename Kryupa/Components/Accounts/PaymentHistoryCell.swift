//
//  PaymentHistoryCell.swift
//  Kryupa
//
//  Created by Pooja Nenava on 11/06/24.
//

import SwiftUI

struct PaymentHistoryCell: View {
    
    var orderListData: OrderListData
    var isSelected: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            HStack {
                Text("Received From")
                    .font(.custom(FontContent.plusRegular, size: 15))
                    .foregroundStyle(._444446)
                
                Spacer()
                
                Text("$\(orderListData.bookingPricing.removeZerosFromEnd(num: 2))")
                    .padding()
                    .frame(height: 23)
                    .font(.custom(FontContent.plusMedium, size: 11))
                    .foregroundStyle(._23_C_16_B)
                    .background(
                        RoundedRectangle(cornerRadius: 12).fill(Color.E_0_FFEE)
                    )
            }
            .padding(.horizontal, 23)
            .padding(.top, 10)
            
            Text("\(orderListData.name)")
                .font(.custom(FontContent.besMedium, size: 16))
                .foregroundStyle(.appMain)
                .padding(.horizontal, 23)
                .padding(.top, 0)

            let date = orderListData.createdAt.components(separatedBy: " ").first ?? ""
            HStack{
                Text("\(date.convertDateFormater(beforeFormat: "yyyy-MM-dd", afterFormat: "EEEE, MM-dd-yyyy"))")
                    .font(.custom(FontContent.plusRegular, size: 15))
                    .foregroundStyle(._444446)
                    .padding(.bottom, 10)
                    .padding(.top, 1)
                Spacer()
                if isSelected{
                    Image("chevron-up")
                        .resizable()
                        .frame(width: 30, height: 30)
                }
            }
            .padding(.horizontal, 23)
            if isSelected{
                VStack(spacing:10){
                    Rectangle()
                        .frame(height: 1)
                        .foregroundStyle(.E_5_E_5_EA)
                        .padding(.vertical,5)
                    let startTime = orderListData.startTime.convertDateFormater(beforeFormat: "HH:mm:ss", afterFormat: "h:mm a")
                    let endTime = orderListData.endTime.convertDateFormater(beforeFormat: "HH:mm:ss", afterFormat: "h:mm a")
                    HStack{
                        Text("Time:")
                        Spacer()
                        Text("\(startTime) - \(endTime)")
                            .foregroundStyle(._7_C_7_C_80)
                    }
                    .font(.custom(FontContent.plusRegular, size: 15))
                    
                    HStack{
                        Text("Type:")
                        Spacer()
                        Text(orderListData.bookingType)
                            .foregroundStyle(._7_C_7_C_80)
                    }
                    .font(.custom(FontContent.plusRegular, size: 15))
                    HStack{
                        Text("Service:")
                        Spacer()
                        Text(orderListData.areaOfExperties)
                            .foregroundStyle(._7_C_7_C_80)
                    }
                    .font(.custom(FontContent.plusRegular, size: 15))
                }
                .padding(.horizontal, 23)
                .padding(.bottom, 15)
            }
        }
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .inset(by: 1)
                .stroke(.E_5_E_5_EA, lineWidth: 1)
        )
        .padding(.horizontal, 24)
    }
}
