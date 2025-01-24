//
//  WalletHistoryView.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 16/07/24.
//

import SwiftUI

struct WalletHistoryView: View {
    
    let transectionListData: TransectionListData
    
    var body: some View {
        VStack {
            HStack{
                VStack(alignment:.leading,spacing:0){
                    Text(transectionListData.tnxstatus)
                        .font(.custom(FontContent.plusMedium, size: 22))
                        .foregroundStyle(.appSubTitle)
                    Text(transectionListData.createdAt.convertDateFormater(beforeFormat: "yyyy-MM-dd HH:mm:ss.SSSXXXXX", afterFormat: "MMMM d yy | h:mm a"))
                        .font(.custom(FontContent.plusRegular, size: 13))
                        .foregroundStyle(._7_C_7_C_80)
                }
                Spacer()
                HStack(spacing:0){
                    Text(transectionListData.tnxstatus == "Credited" ? "+" : "-")
                        .foregroundStyle(transectionListData.tnxstatus == "Credited" ? .green : .red)
                    Text("$\(transectionListData.tnxamount.removeZerosFromEnd(num: 2))")
                }
                .font(.custom(FontContent.plusMedium, size: 22))
            }
        }
    }
}
