//
//  PaymentMethodCell.swift
//  Kryupa
//
//  Created by Pooja Nenava on 11/06/24.
//

import SwiftUI

struct PaymentMethodCell: View {
    let tag: Int
    @Binding var selectedPaymentMethod: Int
    @State private var showingAlert = false

    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Text("Bank Name:")
                    .font(.custom(FontContent.besMedium, size: 16))
                    .foregroundStyle(.appMain)

                Spacer()
                
                Text("Wells Fargo")
                    .font(.custom(FontContent.plusRegular, size: 12))
                    .foregroundStyle(._7_C_7_C_80)
            }
            .padding(.top, 21)
            .padding(.horizontal, 23)
            
            HStack {
                Text("Account Number:")
                    .font(.custom(FontContent.besMedium, size: 16))
                    .foregroundStyle(.appMain)

                Spacer()
                
                Text("********5486")
                    .font(.custom(FontContent.plusRegular, size: 12))
                    .foregroundStyle(._7_C_7_C_80)
            }            
            .padding(.horizontal, 23)

            
            HStack {
                Text("Location:")
                    .font(.custom(FontContent.besMedium, size: 16))
                    .foregroundStyle(.appMain)

                Spacer()
                
                Text("California")
                    .font(.custom(FontContent.plusRegular, size: 12))
                    .foregroundStyle(._7_C_7_C_80)
            }
            .padding(.bottom, 21)
            .padding(.horizontal, 23)

            
            /*Text("Activate")
                .font(.custom(FontContent.plusRegular, size: 16))
                .foregroundStyle(.white)
                .frame(height: 35)
                .frame(width: 104)
                .background{
                    RoundedRectangle(cornerRadius: 48)
                }
                .asButton(.press) {
                    isSelected = !isSelected
                }
                .padding(.bottom, 15)*/

        }
        .background(
            RoundedRectangle(cornerRadius: 15).fill(selectedPaymentMethod == tag ? Color.F_2_F_2_F_7 : .clear)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .inset(by: 1)
                .stroke(.E_5_E_5_EA, lineWidth: selectedPaymentMethod == tag ? 0 : 1)
        )
        .onTapGesture {
            showingAlert = true
        }
        .alert("Confirm to activate this account", isPresented: $showingAlert) {
            Button("Confirm", role: .cancel) {
                self.selectedPaymentMethod = self.tag
            }
        }
        .padding(.horizontal, 24)

//        .asButton(.press) {
//            if selectedPaymentMethod == tag {
//                selectedPaymentMethod = -1
//            }
//            else {
//                viewModel.paymentMethodSelected = tag
//            }
//        }
    }
}

#Preview {
    @State var number = 10
    return PaymentMethodCell(tag: 0, selectedPaymentMethod: $number)
}
