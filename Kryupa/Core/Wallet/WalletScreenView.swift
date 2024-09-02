//
//  WalletScreenView.swift
//  Kryupa
//
//  Created by Hemant Singh Rajput on 16/07/24.
//

import SwiftUI
import SwiftfulUI

struct WalletScreenView: View {
    
    @Environment(\.router) var router
    
    @StateObject var viewModel = PaymentViewModel()
    
    var body: some View {
        ZStack {
            VStack(spacing:0){
                HeaderView(showBackButton: true)
                ScrollView {
                    VStack(spacing:0){
                        
                        Text("Your Wallet Balance")
                            .font(.custom(FontContent.plusRegular, size: 12))
                            .foregroundStyle(._7_C_7_C_80)
                            .padding(.top,30)
                        
                        Text("$\((viewModel.walletAmountData?.mainAmount ?? 0).removeZerosFromEnd(num: 2))")
                            .font(.custom(FontContent.besSemiBold, size: 34))
                            .foregroundStyle(._018_ABE)
                            .padding(.top,5)
                        
                        Text("AddMoney")
                            .font(.custom(FontContent.plusRegular, size: 16))
                            .foregroundStyle(.white)
                            .padding(.horizontal,26)
                            .padding(.vertical,16)
                            .background{
                                RoundedRectangle(cornerRadius: 48)
                            }
                            .asButton(.press) {
                                let addMoneyViewModel = PaymentViewModel()
                                addMoneyViewModel.walletAmountData = viewModel.walletAmountData
                                router.showScreen(.push) { rout in
                                    AddMoneyScreenView(viewModel: addMoneyViewModel)
                                }
                            }
                            .padding(.top,30)
                        
                        VStack(spacing:0){
                            HStack(content: {
                                Text("Transactions")
                                Spacer()
                                Text("See All")
                                    .underline(true)
                                    .asButton {
                                        router.showScreen(.push) { rout in
                                            WalletTransectionHistoryScreenView()
                                        }
                                    }
                            })
                            .font(.custom(FontContent.plusMedium, size: 12))
                            .foregroundStyle(._7_C_7_C_80)
                            .padding(.horizontal,24)
                            .padding(.bottom,15)
                            .padding(.top,30)
                            
                            if viewModel.transectionListData.count > 6{
                                ForEach(0...5, id: \.self) { (data) in
                                    WalletHistoryView(transectionListData: viewModel.transectionListData[data])
                                        .padding(.horizontal,24)
                                        .padding(.bottom,15)
                                }
                            }else{
                                ForEach(Array(viewModel.transectionListData.enumerated()), id: \.offset) { (index,data) in
                                    WalletHistoryView(transectionListData: data)
                                        .padding(.horizontal,24)
                                        .padding(.bottom,15)
                                }
                            }
                            
                        }
                        .background {
                            Rectangle()
                                .foregroundStyle(.white)
                                .clipShape(
                                    .rect(
                                        topLeadingRadius: 30,
                                        bottomLeadingRadius: 0,
                                        bottomTrailingRadius: 0,
                                        topTrailingRadius: 30
                                    )
                                )
                                
                        }
                        .padding(.top,30)
                    }
                }
            }
            .onAppear{
                viewModel.pageNumber = 1
                viewModel.getWalletBalance()
                NotificationCenter.default.addObserver(forName: .showInboxScreen, object: nil, queue: nil,
                                                     using: self.setChatScreen)
            }
            
            if viewModel.isloading{
                LoadingView()
            }
        }
        .background(.gray.opacity(0.20))
        .scrollIndicators(.hidden)
        .toolbar(.hidden, for: .navigationBar)
        
    }

    private func setChatScreen(_ notification: Notification){
        router.dismissScreenStack()
    }
}

#Preview {
    WalletScreenView()
}
