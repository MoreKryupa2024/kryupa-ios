//
//  PaymentListView.swift
//  Kryupa
//
//  Created by Pooja Nenava on 11/06/24.
//

import SwiftUI
import SwiftfulUI
import CorePayments
import PayPalWebPayments

struct PaymentListView: View {
    
    @StateObject var viewModel = PaymentListViewModel()

    var body: some View {
        ZStack{
            VStack(spacing:0) {
                HeaderView(showBackButton: true)
                SegmentView
                ScrollView {
                    if viewModel.selectedSection == 0 {
                        LazyVStack(spacing: 15) {
                            ForEach(viewModel.orderListData,id: \.id) { msg in
                                PaymentHistoryCell(orderListData: msg)
                            }
                        }
                        .padding(.top, 20)
                    }
                    else {
                        
                        if viewModel.showAddBankView {
                            BankView
                        } else {
                            LazyVStack(spacing: 15) {
                                ForEach(viewModel.bankListData,id: \.id) { item in
                                    PaymentMethodCell(bankListData:item,tag: 0, selectedPaymentMethod: self.$viewModel.selectedPaymentMethod)
                                }
                            }
                            .padding(.top, 20)
                            
                            HStack {
                                Text("Add new bank account")
                                    .font(.custom(FontContent.plusRegular, size: 15))
                                    .foregroundStyle(._444446)
                                
                                Spacer()
                                
                                Image("chevron-right")
                                    .frame(width: 30, height: 30)
                                
                            }
                            .padding(.horizontal, 23)
                            .frame(height: 48)
                            .overlay(
                                RoundedRectangle(cornerRadius: 50)
                                    .inset(by: 1)
                                    .stroke(.E_5_E_5_EA, lineWidth: 1)
                            )
                            .padding([.top, .horizontal], 24)
                            .asButton(.press) {
                                self.viewModel.showAddBankView = true
                            }
                        }
                    }
                }
            }
            .onAppear{
                viewModel.getBankList()
                viewModel.getOrderList()
            }
            .scrollIndicators(.hidden)
            .toolbar(.hidden, for: .navigationBar)
            
            if viewModel.isloading {
                LoadingView()
            }
        }
    }
    
    private var BankView: some View{
        VStack (spacing: 15){
            TextField("Bank Name", text: $viewModel.bankName)
                .frame(height: 48)
                .padding(.horizontal, 10)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .inset(by: 1)
                        .stroke(.D_1_D_1_D_6, lineWidth: 1)
                )
                .padding(.horizontal, 24)
                .keyboardType(.asciiCapable)
            
            TextField("Routing Number", text: $viewModel.routingNumber)
                .frame(height: 48)
                .padding(.horizontal, 10)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .inset(by: 1)
                        .stroke(.D_1_D_1_D_6, lineWidth: 1)
                )
                .padding(.horizontal, 24)
                .keyboardType(.numberPad)
            
            TextField("Account Number", text: $viewModel.accountNumber)
                .frame(height: 48)
                .padding(.horizontal, 10)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .inset(by: 1)
                        .stroke(.D_1_D_1_D_6, lineWidth: 1)
                )
                .padding(.horizontal, 24)
                .keyboardType(.numberPad)
            
            Text("Add Bank Account")
                .font(.custom(FontContent.plusRegular, size: 16))
                .foregroundStyle(.white)
                .frame(height: 53)
                .frame(width: 217)
                .background{
                    RoundedRectangle(cornerRadius: 48)
                }
                .padding(.top, 15)
                .asButton(.press) {
                    if viewModel.bankName.isEmpty{
                        presentAlert(title: "Kryupa", subTitle: "Please Enter Bank Name")
                    }else if viewModel.routingNumber.isEmpty{
                        presentAlert(title: "Kryupa", subTitle: "Please Enter Routing Number")
                    }else if viewModel.accountNumber.isEmpty{
                        presentAlert(title: "Kryupa", subTitle: "Please Enter Account Number")
                    }else{
                        self.viewModel.AddBankAccount()
                    }
                }
            
            Text("Cancel")
                .font(.custom(FontContent.plusRegular, size: 16))
                .foregroundStyle(.appMain)
                .frame(height: 53)
                .frame(width: 217)
                .overlay(
                    RoundedRectangle(cornerRadius: 48)
                        .inset(by: 1)
                        .stroke(.appMain, lineWidth: 1)
                )
                .asButton(.press) {
                    self.viewModel.showAddBankView = false
                }
            
        }
        .padding(.top, 20)
    }
    
    private var SegmentView: some View{
        
        Picker("Payment", selection: $viewModel.selectedSection) {
            Text("Payment History")
                .tag(0)
                .font(.custom(FontContent.plusRegular, size: 12))

            Text("Payment Method")
                .tag(1)
                .font(.custom(FontContent.plusRegular, size: 12))
        }
        .pickerStyle(.segmented)
        .padding(.horizontal, 24)
        .padding(.top, 20)
    }
}

#Preview {
    PaymentListView()
}
