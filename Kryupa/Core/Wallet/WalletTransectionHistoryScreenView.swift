//
//  WalletTransectionHistoryScreenView.swift
//  Kryupa
//
//  Created by Hemant Singh Rajput on 16/07/24.
//

import SwiftUI

struct WalletTransectionHistoryScreenView: View {
    var body: some View {
        ZStack {
            VStack(spacing:0){
                HeaderView(showBackButton: true)
                ScrollView {
                    VStack(spacing:0){
                        Text("Transactions")
                            .padding(.vertical,24)
                            .font(.custom(FontContent.besMedium, size: 20))
                        
                        ForEach(0...10) { data in
                            WalletHistoryView()
                                .padding(.horizontal,24)
                                .padding(.bottom,15)
                        }
                    }
                }
                .scrollIndicators(.hidden)
                .toolbar(.hidden, for: .navigationBar)
            }
        }
    }
}

#Preview {
    WalletTransectionHistoryScreenView()
}
