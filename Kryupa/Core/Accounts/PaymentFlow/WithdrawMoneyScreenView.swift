//
//  WithdrawMoneyScreenView.swift
//  Kryupa
//
//  Created by Nirmal on 18/12/24.
//

import SwiftUI
import SwiftfulUI

struct WithdrawMoneyScreenView: View {
    
    @StateObject var viewModel = PaymentListViewModel()
    @Environment(\.router) var router
    @State var showKeyboard = false
    
    var body: some View {
        ZStack{
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
                .asButton {
                    showKeyboard = true
                }
                
                HStack(spacing:15){
                    capsuleView(value: "100")
                    capsuleView(value: "200")
                    capsuleView(value: "500")
                }
                .padding(.top,17)
                .padding(.horizontal, 24)
                
                VStack(spacing: 15) {
                    ForEach(viewModel.bankListData,id: \.id) { item in
                        bankView(bankListData: item)
                            .asButton {
                                let isSelected = (viewModel.selectedbankData ?? BankListData(jsonData: [:])).id == item.id
                                if isSelected {
                                    viewModel.selectedbankData = nil
                                }else{
                                    viewModel.selectedbankData = item
                                }
                            }
                    }
                }
                .padding(.top,40)
                
                Spacer(minLength: 60)
            }
            .background()
            .onTapGesture {
                showKeyboard = false
            }
            .onAppear() {
                viewModel.getBankList()
            }
            .toolbar(.hidden, for: .navigationBar)
            
            VStack(spacing:0){
                Spacer()
                Text("Withdrawn Money")
                    .frame(maxWidth: .infinity)
                    .font(.custom(FontContent.plusRegular, size: 16))
                    .foregroundStyle(.white)
                    .frame(height: 52)
                    .background{
                        RoundedRectangle(cornerRadius: 48)
                    }
                    .padding(.horizontal,25)
                    .asButton(.press) {
                        if (Int(viewModel.amount) ?? 0 ) > Int((viewModel.walletAmountData?.mainAmount ?? 0)){
                            presentAlert(title: "Kryupa", subTitle: "Enterd Amount is Greater than Wallet Amount")
                        }else if viewModel.bankListData.count == 0{
                            presentAlert(title: "Kryupa", subTitle: "You Have to Add Bank Details First in Payment section")
                        }else if viewModel.selectedbankData == nil{
                            presentAlert(title: "Kryupa", subTitle: "Please select Bank")
                        } else{
                            viewModel.withdrawToStripeAccount {
                                router.dismissScreen()
                                presentAlert(title: "Kryupa", subTitle: "Amount Withdrawn Successfully")
                            } errorAction: { error in
                                presentAlert(title: "Kryupa", subTitle: error)
                            }
                        }
                    }
                    .padding(.top,90)
                    .padding(.bottom, showKeyboard ? 15 : 0)
                    .background(
                        LinearGradient(gradient: Gradient(colors: showKeyboard ? [.white, .white, .black.opacity(0.50)] : [.white]), startPoint: .top, endPoint: .bottom)
                    )
                
                if showKeyboard {
                    KeyboardView
                }
            }
            
            if viewModel.isloading {
                LoadingView()
            }
        }
    }
    
    private func bankView(bankListData: BankListData)-> some View{
        let isSelected = (viewModel.selectedbankData ?? BankListData(jsonData: [:])).id == bankListData.id
        return HStack {
            Text("\(bankListData.bankName) (\(bankListData.accountNumber.suffix(4)))")
                .font(.custom(FontContent.plusRegular, size: 15))
                .foregroundStyle(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 21)
            
            
            Image(isSelected ? "selectedBankRadio" : "unSelectedBankRadio")
                .resizable()
                .frame(width: 24, height: 24)
                .padding(.trailing, 15)
        }
        .frame(height: 52)
        .background(
            RoundedRectangle(cornerRadius: 48)
                .foregroundStyle(isSelected ? .E_5_E_5_EA : .white)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 48)
                .stroke(.E_5_E_5_EA, lineWidth: 1) // Border color and width
        )
        .padding(.horizontal, 25)
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
    }
    
    private func capsuleView(value: String)-> some View{
        return Text("+$\(value)")
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
    WithdrawMoneyScreenView()
}
