//
//  PaymentOrderScreenView.swift
//  Kryupa
//
//  Created by Hemant Singh Rajput on 16/07/24.
//

import SwiftUI

struct PaymentOrderScreenView: View {
    @Environment(\.router) var router
    @StateObject var viewModel = PaymentViewModel()
    
    var body: some View {
        ZStack {
            VStack(spacing:0){
                HeaderView(showBackButton: true)
                
                ScrollView{
                    VStack(spacing:0){
                        Text("Payment")
                            .font(.custom(FontContent.besMedium, size: 20))
                            .padding(.top,30)
                        HStack{
                            Image("warningRed")
                                .resizable()
                                .frame(width: 24,height: 24)
                            Text("Your current wallet balance is $12.45")
                                .font(.custom(FontContent.plusMedium, size: 13))
                        }
                        .padding(.top,15)
                        .foregroundStyle(.red)
                        
                        VStack(alignment:.leading,spacing:5){
                            if let startDate = viewModel.paymentOrderData?.startDate, let endDate = viewModel.paymentOrderData?.endDate{
                                Text("\(startDate.convertDateFormater(beforeFormat: "yyyy-MM-dd", afterFormat: "EEEE, d MMMM")) - \(endDate.convertDateFormater(beforeFormat: "yyyy-MM-dd", afterFormat: "d MMMM yyyy"))")
                                    .font(.custom(FontContent.besMedium, size: 16))
                                    .frame(maxWidth: .infinity,alignment: .leading)
                            }
                            
                            if let startTime = viewModel.paymentOrderData?.startTime, let endTime = viewModel.paymentOrderData?.endTime{
                                Text("\(startTime.convertDateFormater(beforeFormat: "HH:mm:ss", afterFormat: "h:mma")) - \(endTime.convertDateFormater(beforeFormat: "HH:mm:ss", afterFormat: "h:mma"))")
                                    .font(.custom(FontContent.plusRegular, size: 11))
                            }
                        }
                        
                        .padding(.horizontal,26)
                        .padding(.vertical,10)
                        .background{
                            Rectangle()
                                .foregroundStyle(.E_5_E_5_EA)
                                .clipShape(.rect(cornerRadius: 10))
                        }
                        .padding(.horizontal,24)
                        .padding(.top,15)
                        
                        sepratorView
                        
                        addressView
                        
                        sepratorView
                        
                        priceView
                        
                        sepratorView
                        
                        serviceView
                        
                        sepratorView
                        
                        caregiverView
                        
                        buttonView
                    }
                }
            }
            
            if viewModel.isloading{
                LoadingView()
            }
            
            if viewModel.showPaypal {
                PaypalScreenView(orderId: viewModel.orderId) { payPalClient, result in
                    print("Paypal Payment Success")
                    viewModel.showPaypal = false
                    print(payPalClient)
                    print(result)
                    router.showScreen(.push) { rout in
                        PaymentConfirmScreenView()
                    }
                } payPalError: { payPalClient, error in
                    print(payPalClient)
                    print(error)
                    viewModel.showPaypal = false
                    print("Paypal Payment Send Error")
                } payPalDidCancel: { payPalClient in
                    viewModel.showPaypal = false
                    print("Paypal Payment Cancel")
                }

            }
        }
        .task{
            viewModel.getPaymentOrderDetails()
        }
        .scrollIndicators(.hidden)
        .toolbar(.hidden, for: .navigationBar)
    }
    
    private var buttonView: some View{
        HStack(spacing: 40) {
            Text("Confirm")
                .font(.custom(FontContent.plusRegular, size: 16))
                .foregroundStyle(.white)
                .frame(height: 32)
                .frame(width: 97)
                .background{
                    RoundedRectangle(cornerRadius: 48)
                }
                .asButton(.press) {
                    viewModel.getPaypalOrderID()
                }
            
            Text("Cancel")
                .font(.custom(FontContent.plusRegular, size: 16))
                .foregroundStyle(.appMain)
                .frame(height: 32)
                .frame(width: 99)
                .overlay(
                    RoundedRectangle(cornerRadius: 48)
                        .inset(by: 1)
                        .stroke(.appMain, lineWidth: 1)
                )
                .asButton(.press) {
                    router.dismissScreen()
                }
        }
        .padding(.vertical,24)
    }
    
    private var priceView: some View{
        VStack(alignment:.leading,spacing:5){
            HStack{
                Text("Rate per hour:")
                    .font(.custom(FontContent.plusLight, size: 15))
                Spacer()
                Text("$\(viewModel.paymentOrderData?.pricePerHour ?? 0)")
                    .font(.custom(FontContent.plusRegular, size: 16))
            }
            HStack{
                Text("Number of hours:")
                    .font(.custom(FontContent.plusLight, size: 15))
                Spacer()
                Text((viewModel.paymentOrderData?.hours ?? ""))
                    .font(.custom(FontContent.plusRegular, size: 16))
            }
            HStack{
                Text("Total:")
                    .font(.custom(FontContent.plusLight, size: 15))
                Spacer()
                Text("$\(viewModel.paymentOrderData?.bookingPricing ?? 0)")
                    .font(.custom(FontContent.plusRegular, size: 16))
            }
            if 2+2 == 4{
                HStack{
                    Spacer()
                    Text("Add $100 more to complete trasnaction")
                        .font(.custom(FontContent.plusRegular, size: 11))
                        .foregroundStyle(.red)
                }
            }
        }
        .padding(.horizontal,24)
    }
    
    private var serviceView: some View{
        VStack(alignment:.leading,spacing:5){
            HStack{
                Text("Service Required:")
                    .font(.custom(FontContent.plusRegular, size: 17))
                Spacer()
            }
            
            Text("Nursing, Physical Therapy, Occupational Therapy")
                .foregroundStyle(._242426)
                .font(.custom(FontContent.plusRegular, size: 12))
        }
        .padding(.horizontal,24)
    }
        
    private var caregiverView: some View{
        VStack(alignment:.leading,spacing:5){
            HStack{
                Text("Caregiver:")
                    .font(.custom(FontContent.plusRegular, size: 17))
                Spacer()
            }
            
            Text(viewModel.paymentOrderData?.name ?? "")
                .foregroundStyle(._242426)
                .font(.custom(FontContent.plusRegular, size: 12))
        }
        .padding(.horizontal,24)
    }
    
    private var addressView: some View{
        VStack(alignment:.leading,spacing:5){
            HStack{
                Text("Address:")
                    .font(.custom(FontContent.plusRegular, size: 17))
                Spacer()
                Image("editAddress")
                    .resizable()
                    .frame(width: 53,height: 21)
            }
            
            Text(viewModel.paymentOrderData?.fulladdress ?? "")
                .foregroundStyle(._242426)
                .font(.custom(FontContent.plusRegular, size: 12))
        }
        .padding(.horizontal,24)
    }
    
    private var sepratorView: some View{
        Rectangle()
            .foregroundStyle(.F_2_F_2_F_7)
            .frame(height: 1)
            .padding(.vertical,21)
            .padding(.horizontal,24)
        
    }
}

#Preview {
    PaymentOrderScreenView()
}
