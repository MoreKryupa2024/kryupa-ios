//
//  PaymentHistoryCell.swift
//  Kryupa
//
//  Created by Pooja Nenava on 11/06/24.
//

import SwiftUI

struct PaymentHistoryCell: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            HStack {
                Text("Transaction #546")
                    .font(.custom(FontContent.besMedium, size: 15))
                    .foregroundStyle(.appMain)
                
                Spacer()
                
                Text("Paid")
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
            
            Text("Monday, 07-03-24")
                .font(.custom(FontContent.plusRegular, size: 12))
                .foregroundStyle(._444446)
                .padding(.horizontal, 23)
                .padding(.top, 0)

            Text("$325.21")
                .font(.custom(FontContent.plusRegular, size: 12))
                .foregroundStyle(._444446)
                .padding(.horizontal, 23)
                .padding(.bottom, 10)
                .padding(.top, 1)
        }
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .inset(by: 1)
                .stroke(.E_5_E_5_EA, lineWidth: 1)
        )
        .padding(.horizontal, 24)
    }
}

#Preview {
    PaymentHistoryCell()
}
