//
//  WalletHistoryView.swift
//  Kryupa
//
//  Created by Hemant Singh Rajput on 16/07/24.
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
                    Text((transectionListData.createdAt.convertDateFormater(beforeFormat: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", afterFormat: "d MMMM yy")))
                        .font(.custom(FontContent.plusRegular, size: 13))
                        .foregroundStyle(._7_C_7_C_80)
                }
                Spacer()
                HStack(spacing:0){
                    Text(transectionListData.tnxstatus == "Credited" ? "+" : "-")
                        .foregroundStyle(transectionListData.tnxstatus == "Credited" ? .green : .red)
                    Text("$\(transectionListData.tnxamount)")
                }
                .font(.custom(FontContent.plusMedium, size: 22))
            }
        }
    }
}
