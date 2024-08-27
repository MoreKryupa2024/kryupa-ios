//
//  WalletTransectionHistoryScreenView.swift
//  Kryupa
//
//  Created by Hemant Singh Rajput on 16/07/24.
//

import SwiftUI

struct WalletTransectionHistoryScreenView: View {
    @StateObject var viewModel = PaymentViewModel()
    
    var body: some View {
        ZStack {
            VStack(spacing:0){
                HeaderView(showBackButton: true)
                ScrollView {
                    VStack(spacing:0){
                        Text("Transactions")
                            .padding(.vertical,24)
                            .font(.custom(FontContent.besMedium, size: 20))
                        
                        ForEach(viewModel.transectionListData, id: \.id) { data in
                            WalletHistoryView(transectionListData: data)
                                .padding(.horizontal,24)
                                .padding(.bottom,15)
                        }
                    }
                }
                .scrollIndicators(.hidden)
                .toolbar(.hidden, for: .navigationBar)
            }
            .task {
                viewModel.getTransectionList()
            }
        }
    }
}

#Preview {
    WalletTransectionHistoryScreenView()
}
