//
//  PaymentOrderScreenView.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 16/07/24.
//

import SwiftUI

struct PaymentOrderScreenView: View {
    
    @Environment(\.router) var router
    @StateObject var viewModel = PaymentViewModel()
    var serviceId: String = ""
    @State var showPaymentMethodScreen = false
    var paymentConfirmAction: (()->Void)? = nil
    var backAction: (()->Void)? = nil
    
    var body: some View {
        ZStack {
            VStack(spacing:0){
                HeaderView(showBackButton: true) {
                    backAction?()
                }
                
                ScrollView{
                    let diffrenceAmount = (viewModel.paymentOrderData?.bookingPricingForCustomer ?? 0)-(viewModel.walletAmountData?.mainAmount ?? 0.0)
                    VStack(spacing:0){
                        Text("Payment")
                            .font(.custom(FontContent.besMedium, size: 20))
                            .padding(.top,30)
                        HStack{
                            Image("warningRed")
                                .resizable()
                                .frame(width: 24,height: 24)
                            Text("Your current wallet balance is $\((viewModel.walletAmountData?.mainAmount ?? 0.0).removeZerosFromEnd(num: 2))")
                                .font(.custom(FontContent.plusMedium, size: 15))
                        }
                        .padding(.top,15)
                        .foregroundStyle((diffrenceAmount > 0) ? .red : .green)
                        
                        VStack(alignment:.leading,spacing:5){
                            if let startDate = viewModel.paymentOrderData?.startDate {
                                Text("\(startDate.convertDateFormater(beforeFormat: "yyyy-MM-dd", afterFormat: "EEEE, MMMM d"))")
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
            if showPaymentMethodScreen{
                PaymentMethodsScreenView(viewModel: viewModel,paymentConfirmAction: {
                    paymentConfirmAction?()
                }, backAction: {
                    showPaymentMethodScreen = false
                })
                    .background(.white)
            }
            if viewModel.isloading{
                LoadingView()
            }
        }
        .onAppear{
            viewModel.getServiceId(serviceId: self.serviceId)
            viewModel.getWalletBalance()
        }
        .scrollIndicators(.hidden)
        .toolbar(.hidden, for: .navigationBar)
    }
    
    private var buttonView: some View{
        HStack(spacing: 40) {
            let diffrenceAmount = (viewModel.paymentOrderData?.bookingPricingForCustomer ?? 0)-(viewModel.walletAmountData?.mainAmount ?? 0.0)
            Text((diffrenceAmount > 0) ? "Add & Pay" : "Confirm")
                .font(.custom(FontContent.plusRegular, size: 16))
                .foregroundStyle(.white)
                .frame(height: 35)
                .padding(.horizontal,20)
                .background{
                    RoundedRectangle(cornerRadius: 48)
                }
                .asButton(.press) {
                    if (viewModel.paymentOrderData?.bookingPricingForCustomer ?? 0) == 0{
                        return
                    }
                    if (diffrenceAmount > 0){
                        viewModel.amount = "\(diffrenceAmount)"
                        viewModel.fromPaymentFlow = true
                        showPaymentMethodScreen = true
                    }else{
                        paymentConfirmAction?()
                    }
                }
            
            Text("Cancel")
                .font(.custom(FontContent.plusRegular, size: 16))
                .foregroundStyle(.appMain)
                .frame(height: 35)
                .frame(width: 99)
                .overlay(
                    RoundedRectangle(cornerRadius: 48)
                        .inset(by: 1)
                        .stroke(.appMain, lineWidth: 1)
                )
                .asButton(.press) {
                    backAction?()
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
                Text("$\((viewModel.paymentOrderData?.pricePerHour ?? 0).removeZerosFromEnd(num: 2))")
                    .font(.custom(FontContent.plusRegular, size: 16))
            }
            HStack{
                Text("Number of hours:")
                    .font(.custom(FontContent.plusLight, size: 15))
                Spacer()
                Text((viewModel.paymentOrderData?.hours ?? 0).removeZerosFromEnd(num: 2))
                    .font(.custom(FontContent.plusRegular, size: 16))
            }
            if AppConstants.SeekCare == Defaults().userType{
                HStack {
                    Text("Platform Fee:")
                        .font(.custom(FontContent.plusRegular, size: 15))
                        .foregroundStyle(.appMain)
                    Spacer()
                    Text("2%")
                        .font(.custom(FontContent.plusRegular, size: 16))
                        .foregroundStyle(.appMain)
                }
            }
            HStack{
                Text("Total:")
                    .font(.custom(FontContent.plusLight, size: 15))
                Spacer()
                Text("$\((viewModel.paymentOrderData?.bookingPricingForCustomer ?? 0).removeZerosFromEnd(num: 2))")
                    .font(.custom(FontContent.plusRegular, size: 16))
                
            }
            let diffrenceAmount = (viewModel.paymentOrderData?.bookingPricingForCustomer ?? 0)-(viewModel.walletAmountData?.mainAmount ?? 0.0)
            if (diffrenceAmount > 0){
                HStack{
                    Spacer()
                    Text("Add $\(diffrenceAmount.removeZerosFromEnd(num: 2)) more to complete trasnaction")
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
            
            Text(viewModel.paymentOrderData?.areasOfExpertise ?? "None")
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
//                Image("editAddress")
//                    .resizable()
//                    .frame(width: 53,height: 21)
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
