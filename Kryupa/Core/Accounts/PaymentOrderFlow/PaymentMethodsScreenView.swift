//
//  PaymentMethodsScreenView.swift
//  Kryupa
//
//  Created by Hemant Singh Rajput on 16/07/24.
//

import SwiftUI
import SwiftfulUI

struct PaymentMethodsScreenView: View {
    
    @Environment(\.router) var router
    
    var body: some View {
        ZStack{
            VStack{
                HeaderView(title: "Payment", showBackButton: true)
                VStack(spacing:15){
                    ZelleView
                        .asButton(.press) {
                            router.showScreen(.push) { rout in
                                MoneyAddedScreenView()
                            }
                        }
                    PaypalView
                        .asButton(.press) {
                            router.showScreen(.push) { rout in
                                MoneyAddedScreenView()
                            }
                        }
                    VenmoView
                        .asButton(.press) {
                            router.showScreen(.push) { rout in
                                MoneyAddedScreenView()
                            }
                        }
                    Spacer()
                }
            }
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
    private var PaypalView: some View{
        HStack(spacing:20){
            Image("Paypal")
                .resizable()
                .frame(width: 21,height: 25)
            Text("Continue With Paypal")
                .font(.custom(FontContent.plusRegular, size: 15))
        }
        .frame(maxWidth: .infinity)
        .frame(height: 48)
        .overlay {
            RoundedRectangle(cornerRadius: 24)
                .stroke(lineWidth: 1.0)
                .foregroundStyle(.E_5_E_5_EA)
                
        }
        .padding(.horizontal,24)
    }
    
    private var VenmoView: some View{
        HStack(spacing:20){
            Image("Venmo")
                .resizable()
                .frame(width: 25,height: 25)
            Text("Continue With Venmo")
                .font(.custom(FontContent.plusRegular, size: 15))
        }
        .frame(maxWidth: .infinity)
        .frame(height: 48)
        .overlay {
            RoundedRectangle(cornerRadius: 24)
                .stroke(lineWidth: 1.0)
                .foregroundStyle(.E_5_E_5_EA)
                
        }
        .padding(.horizontal,24)
    }
    
    private var ZelleView: some View{
        HStack(spacing:20){
            Image("Zelle")
                .resizable()
                .frame(width: 39,height: 25)
            Text("Continue With Zelle")
                .font(.custom(FontContent.plusRegular, size: 15))
        }
        .frame(maxWidth: .infinity)
        .frame(height: 48)
        .overlay {
            RoundedRectangle(cornerRadius: 24)
                .stroke(lineWidth: 1.0)
                .foregroundStyle(.E_5_E_5_EA)
                
        }
        .padding(.horizontal,24)
    }
}

#Preview {
    PaymentMethodsScreenView()
}
