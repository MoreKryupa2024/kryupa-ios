//
//  PaymentListView.swift
//  Kryupa
//
//  Created by Pooja Nenava on 11/06/24.
//

import SwiftUI

struct PaymentListView: View {
    
    @State var selectedPaymentMethod: Int
    @State var selectedSection = 0
    @State var showAddBankView = false
    @State var bankName: String = ""
    @State var fullName: String = ""
    @State var accountNumber: String = ""

    var body: some View {
        ScrollView {
            HeaderView(showBackButton: true)
            SegmentView
            
            if selectedSection == 0 {
                LazyVStack(spacing: 15) {
                    ForEach(0...2) {
                        msg in

                        PaymentHistoryCell()
                    }
                }
                .padding(.top, 20)
            }
            else {
                
                if showAddBankView {
                    BankView
                }
                else {
                    LazyVStack(spacing: 15) {
                        ForEach(0...2) {
                            item in

                            PaymentMethodCell(tag: item, selectedPaymentMethod: self.$selectedPaymentMethod)
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
                        self.showAddBankView = true
                    }
                }
            }
        }
        .scrollIndicators(.hidden)
        .toolbar(.hidden, for: .navigationBar)
    }
    
    private var BankView: some View{
        VStack (spacing: 15){
            TextField("Bank Name", text: $bankName)
                .frame(height: 48)
                .padding(.horizontal, 10)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .inset(by: 1)
                        .stroke(.D_1_D_1_D_6, lineWidth: 1)
                )
                .padding(.horizontal, 24)
            
            TextField("Full Name", text: $fullName)
                .frame(height: 48)
                .padding(.horizontal, 10)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .inset(by: 1)
                        .stroke(.D_1_D_1_D_6, lineWidth: 1)
                )
                .padding(.horizontal, 24)
            
            TextField("Account Number", text: $accountNumber)
                .frame(height: 48)
                .padding(.horizontal, 10)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .inset(by: 1)
                        .stroke(.D_1_D_1_D_6, lineWidth: 1)
                )
                .padding(.horizontal, 24)
            
            Text("Add Bank Account")
                .font(.custom(FontContent.plusRegular, size: 16))
                .foregroundStyle(.white)
                .frame(height: 53)
                .frame(width: 217)
                .background{
                    RoundedRectangle(cornerRadius: 48)
                }
                .padding(.top, 15)
            
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
                    self.showAddBankView = false
                }
            
        }
        .padding(.top, 20)
    }
    
    private var SegmentView: some View{
        
        Picker("Payment", selection: $selectedSection) {
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
    PaymentListView(selectedPaymentMethod: 0)
}
