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
                
                    if viewModel.selectedSection == 0 {
                        if viewModel.orderListData.count == 0{
                            VStack{
                                Spacer()
                                Image("PaymentEmpty")
                                    .resizable()
                                    .aspectRatio(283/268, contentMode: .fit)
                                    .padding(.horizontal,46)
                                Text("Your Transaction List Looks Empty")
                                Spacer()
                            }
                        }else{
                            ScrollView {
                                VStack(spacing: 15) {
                                    ForEach(viewModel.orderListData,id: \.id) { msg in
                                        PaymentHistoryCell(orderListData: msg)
                                    }
                                }
                                .padding(.top, 20)
                            }
                        }
                    }
                    else {
                        ScrollView {
                            if viewModel.showAddBankView {
                                BankView
                            } else {
                                VStack(spacing: 15) {
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
        
        HStack(spacing: 0) {
            SegmentTextView(title: "Payment History", select: viewModel.selectedSection == 0)
                .asButton {
                    viewModel.selectedSection = 0
                }
            SegmentTextView(title: "Payment Method", select: viewModel.selectedSection == 1)
                .asButton {
                    if AppConstants.SeekCare == Defaults().userType{
                        viewModel.selectedSection = 0
                    }else{
                        viewModel.selectedSection = 1
                    }
                }
        }
        .padding(2)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .foregroundStyle(.E_5_E_5_EA)
        )
        .padding(.horizontal, 24)
        .padding(.top, 20)
    }
    
    private func SegmentTextView(title: String, select: Bool) -> some View{
        Text(title)
            .foregroundStyle((select ? .appMain : ._7_C_7_C_80))
            .frame(maxWidth: .infinity)
            .font(.custom(FontContent.plusMedium, size: 12))
            .frame(height: 30)
            .background(
                RoundedRectangle(cornerRadius: 6)
                    .foregroundStyle(select ? .white : .E_5_E_5_EA)
            )
    }
}

#Preview {
    PaymentListView()
}
