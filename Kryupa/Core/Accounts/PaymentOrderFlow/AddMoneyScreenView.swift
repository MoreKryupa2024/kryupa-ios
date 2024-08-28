//
//  AddMoneyScreenView.swift
//  Kryupa
//
//  Created by Hemant Singh Rajput on 24/07/24.
//

import SwiftUI
import SwiftfulUI

struct AddMoneyScreenView: View {
    
    @StateObject var viewModel = PaymentViewModel()
    @Environment(\.router) var router
    
    var body: some View {
        VStack(spacing:0){
            HeaderView(showBackButton: true)
            Text("Your Wallet Current Balance is $\((viewModel.walletAmountData?.mainAmount ?? 0).removeZerosFromEnd(num: 2))")
                .font(.custom(FontContent.plusRegular, size: 17))
                .foregroundStyle(._7_C_7_C_80)
                .padding(.top,45)
            HStack(alignment:.center,spacing: 0){
                Spacer()
                Text("$")
                Text(viewModel.amount)
                Spacer()
            }
            .foregroundStyle(._018_ABE)
            .font(.custom(FontContent.besMedium, size: 30))
            .frame(width: 267, height: 70)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.D_1_D_1_D_6, lineWidth: 1)
            )
            .padding(.top,45)
            
            HStack(spacing:15){
                capsuleView(value: "100")
                capsuleView(value: "200")
                capsuleView(value: "500")
            }
            .padding(.top,17)
            .padding(.horizontal, 24)
            
            Spacer()
            Text("Add Money")
                .frame(maxWidth: .infinity)
                .font(.custom(FontContent.plusRegular, size: 16))
                .foregroundStyle(.white)
                .frame(height: 52)
                .background{
                    RoundedRectangle(cornerRadius: 48)
                }
                .padding(.horizontal,25)
                .asButton(.press) {
                    if (Int(viewModel.amount) ?? 0 ) > 0{
                        router.showScreen(.push) { rout in
                            PaymentMethodsScreenView(viewModel: viewModel)
                        }
                    }else{
                        presentAlert(title: "Kryupa", subTitle: "Please Enter Amount")
                    }
                }
                .padding(.top,90)
            KeyboardView
            
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
    private var KeyboardView: some View{
        VStack{
            HStack{
                KeyboardButtonView(value: "1")
                KeyboardButtonView(value: "2")
                KeyboardButtonView(value: "3")
            }
            HStack{
                KeyboardButtonView(value: "4")
                KeyboardButtonView(value: "5")
                KeyboardButtonView(value: "6")
            }
            HStack{
                KeyboardButtonView(value: "7")
                KeyboardButtonView(value: "8")
                KeyboardButtonView(value: "9")
            }
            HStack{
                KeyboardButtonView(value: "0").opacity(0)
                KeyboardButtonView(value: "0")
                Image("KeyboardDelete")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24,height: 24)
                    .frame(maxWidth: .infinity)
                    .asButton {
                        if !viewModel.amount.isEmpty && self.viewModel.amount != "0.00"{
                            self.viewModel.amount.removeLast()
                        }
                    }
            }
        }
        .padding([.top,.bottom,.horizontal], 15)
        .background(.D_1_D_1_D_6)
        .padding(.top,20)
    }
    
    private func capsuleView(value: String)-> some View{
        return Text("$\(value)")
            .foregroundStyle(._7_C_7_C_80)
            .font(.custom(FontContent.plusMedium, size: 15))
            .frame(width: 77,height: 36)
            .overlay(
                RoundedRectangle(cornerRadius: 18)
                    .stroke(.D_1_D_1_D_6, lineWidth: 1)
            )
            .asButton {
                self.viewModel.amount = value
            }
    }
    
    private func KeyboardButtonView(value: String)-> some View{
        return Text(value)
            .font(.custom(FontContent.plusMedium, size: 16))
            .frame(maxWidth: .infinity)
            .frame(height: 46)
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .foregroundStyle(.white)
            )
            .asButton {
                if (self.viewModel.amount.isEmpty && value == "0"){
                    
                }else if self.viewModel.amount == "0.00" && value != "0"{
                    self.viewModel.amount = value
                }else if self.viewModel.amount == "0.00" && value == "0"{
                    
                }else{
                    self.viewModel.amount += value
                }
            }
    }
}

#Preview {
    AddMoneyScreenView()
}
