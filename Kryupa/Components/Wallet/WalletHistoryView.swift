//
//  WalletHistoryView.swift
//  Kryupa
//
//  Created by Hemant Singh Rajput on 16/07/24.
//

import SwiftUI

struct WalletHistoryView: View {
    var body: some View {
        VStack {
            HStack{
                VStack(alignment:.leading,spacing:0){
                    Text("Added")
                        .font(.custom(FontContent.plusMedium, size: 22))
                        .foregroundStyle(.appSubTitle)
                    Text("13 April 24")
                        .font(.custom(FontContent.plusRegular, size: 13))
                        .foregroundStyle(._7_C_7_C_80)
                }
                Spacer()
                HStack(spacing:0){
                    Text("+")
                        .foregroundStyle(.green)
                    Text("$124")
                }
                .font(.custom(FontContent.plusMedium, size: 22))
            }
        }
    }
}

#Preview {
    WalletHistoryView()
}
