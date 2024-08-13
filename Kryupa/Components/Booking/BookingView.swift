//
//  BookingView.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 14/06/24.
//

import SwiftUI

struct BookingView: View {
    
    var status: String = "Active"
    var bookingData: BookingsListData?
    var statusColor: Color {
        if status == "Cancelled"{
            return .D_3180_C
        }else if status == "Draft" {
            return ._444446
        }else{
            return ._23_C_16_B
        }
    }
    
    var statusBackColor: Color {
        if status == "Cancelled"{
            return .FFE_3_E_3
        }else if status == "Draft" {
            return .E_5_E_5_EA
        }else{
            return .E_0_FFEE
        }
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 20){
            ImageLoadingView(imageURL: bookingData?.profilePictureURL ?? "")
                .frame(width: 60, height: 60)
                .cornerRadius(30)
            
            VStack(alignment: .leading, spacing: 3) {
                HStack {
                    Text(bookingData?.name ?? "")
                        .font(.custom(FontContent.besMedium, size: 15))
                        .foregroundStyle(.appMain)
                        .lineLimit(1)
                    
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
                if status != "Draft"{
                    Text("$\((bookingData?.price ?? 0).removeZerosFromEnd(num: 2))")
                        .font(.custom(FontContent.plusMedium, size: 12))
                        .foregroundStyle(._444446)
                        .lineLimit(1)
                }
                
                if let startDate = bookingData?.startDate, let endDate = bookingData?.endDate{
                    Text("\(startDate.convertDateFormater(beforeFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", afterFormat: "d MMMM")) - \(endDate.convertDateFormater(beforeFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", afterFormat: "d MMMM yyyy"))")
                        .font(.custom(FontContent.plusRegular, size: 12))
                        .foregroundStyle(._444446)
                        .lineLimit(1)
                }
                
                Text("\((bookingData?.arrayAgg ?? []).joined(separator: ","))")
                    .lineLimit(status == "Draft" ? 2 : 1)
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
