//
//  AddMoneyScreenView.swift
//  Kryupa
//
//  Created by Hemant Singh Rajput on 24/07/24.
//

import SwiftUI

struct AddMoneyScreenView: View {
    
    @StateObject var viewModel = PaymentViewModel()
    @Environment(\.router) var router
    
    var body: some View {
        VStack(spacing:0){
            HeaderView(showBackButton: true)
            TextField(text: $viewModel.amount) {
                Text("0.00")
                    .foregroundStyle(._018_ABE)
            }
            .foregroundStyle(._018_ABE)
            .multilineTextAlignment(.center)
            .keyboardType(.numberPad)
            .font(.custom(FontContent.besMedium, size: 30))
            .padding(.top,90)
            .padding(.horizontal,24)
            
            Text("Add Money")
                .font(.custom(FontContent.plusRegular, size: 16))
                .foregroundStyle(.white)
                .frame(height: 52)
                .padding(.horizontal,25)
                .background{
                    RoundedRectangle(cornerRadius: 48)
                }
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
            Spacer()
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    AddMoneyScreenView()
}
