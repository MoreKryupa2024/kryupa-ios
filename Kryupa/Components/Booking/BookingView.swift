//
//  BookingView.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 14/06/24.
//

import SwiftUI
import SwiftfulUI

struct BookingView: View {
    
    var status: String = "Active"
    var bookingData: BookingsListData?
    var statusColor: Color {
        if status == "Cancelled"{
            return .D_3180_C
        }else if status == "Pending" {
            return .FFB_323
        }else if status == "Draft" {
            return ._444446
        }else if status == "Depreciated" {
            return .gray
        }else{
            return ._23_C_16_B
        }
    }
    
    var statusBackColor: Color {
        if status == "Cancelled"{
            return .FFE_3_E_3
        }else if status == "Draft" {
            return .E_5_E_5_EA
        }else if status == "Pending" {
            return .FFF_7_E_7
        }else if status == "Depreciated" {
            return .F_2_F_2_F_7
        }else{
            return .E_0_FFEE
        }
    }
    var deleteAction:((BookingsListData)->Void)? = nil
    var payNowAction:((BookingsListData)->Void)? = nil
    
    
    var body: some View {
        VStack(spacing:10){
            HStack(alignment: .top, spacing: 20){
                ImageLoadingView(imageURL: bookingData?.profilePictureURL ?? "")
                    .frame(width: 60, height: 60)
                    .cornerRadius(30)
                    .clipped()
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
                    HStack {
                        VStack(alignment: .leading, spacing: 3){
                            if let startDate = bookingData?.startDate, let endDate = bookingData?.endDate{
                                Text("\(startDate.convertDateFormater(beforeFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", afterFormat: "MMMM d")) - \(endDate.convertDateFormater(beforeFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", afterFormat: "MMMM d yyyy"))")
                                    .font(.custom(FontContent.plusRegular, size: 12))
                                    .foregroundStyle(._444446)
                                    .lineLimit(1)
                            }
                            
                            Text("\((bookingData?.arrayAgg ?? []).joined(separator: ","))")
                                .lineLimit(status == "Draft" ? 2 : 1)
                                .font(.custom(FontContent.plusRegular, size: 12))
                                .foregroundStyle(._444446)
                            if status == "Pending" && (bookingData?.status ?? "") != "Payment Pending"{
                                Text("Awaiting confirmation from caregiver")
                                    .font(.custom(FontContent.plusRegular, size: 12))
                                    .foregroundStyle(.FFB_323)
                            }
                        }
                        Spacer()
                        if status == "Draft" {
                            Image("DeleteButton")
                                .frame(width: 25,height: 25)
                                .offset(y: 10)
                                .asButton {
                                    guard let bookingData else {return}
                                    deleteAction?(bookingData)
                                }
                        }
                    }
                }
            }
            if status == "Pending" && (bookingData?.status ?? "") == "Payment Pending"{
                PayNowButton
                    .asButton {
                        guard let bookingData else {return}
                        payNowAction?(bookingData)
                    }
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
    
    private var PayNowButton: some View {
        
        Text("Pay Now")
            .font(.custom(FontContent.plusMedium, size: 16))
            .foregroundStyle(._23_C_16_B)
            .padding(.vertical,9)
            .frame(maxWidth: .infinity)
            .background{
                RoundedRectangle(cornerRadius: 16)
                    .stroke(lineWidth: 1)
                    .foregroundStyle(._23_C_16_B)
            }
            .padding(.top,5)
    }
    
}

#Preview {
    BookingView()
}
