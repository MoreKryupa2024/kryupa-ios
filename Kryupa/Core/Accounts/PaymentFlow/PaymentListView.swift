//
//  PaymentListView.swift
//  Kryupa
//
//  Created by Pooja Nenava on 11/06/24.
//

import SwiftUI
import SwiftfulUI
import CorePayments
import Combine
import PayPalWebPayments

struct PaymentListView: View {
    
    @StateObject var viewModel = PaymentListViewModel()

    @State var bankTypeShow: Bool = false
    var body: some View {
        ZStack{
            VStack(spacing:0) {
                HeaderView(showBackButton: true)
                if AppConstants.GiveCare == Defaults().userType{
                    SegmentView
//                    Text("Payment History")
//                        .font(.custom(FontContent.besMedium, size: 20))
//                        .foregroundStyle(.appMain)
//                        .padding(.top,30)
                }else{
                    Text("Payment History")
                        .font(.custom(FontContent.besMedium, size: 20))
                        .foregroundStyle(.appMain)
                        .padding(.top,30)
                }
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
                                    ForEach(Array(viewModel.orderListData.enumerated()), id: \.element.idCustom) { index, data in
                                        
                                        if AppConstants.GiveCare == Defaults().userType{
                                            PaymentHistoryCell(orderListData: data, isSelected: viewModel.isSelectedCell == index)
                                                .asButton {
                                                    if viewModel.isSelectedCell == index{
                                                        self.viewModel.isSelectedCell = -1
                                                    }else{
                                                        self.viewModel.isSelectedCell = index
                                                    }
                                                }
                                        }else{
                                            seekerPayedView(orderData: data,isSelected: viewModel.isSelectedCell == index)
                                                .asButton {
                                                    if viewModel.isSelectedCell == index{
                                                        self.viewModel.isSelectedCell = -1
                                                    }else{
                                                        self.viewModel.isSelectedCell = index
                                                    }
                                                }
                                        }
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
            .modifier(DismissingKeyboard())
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
    
    private func seekerPayedView(orderData:OrderListData,isSelected: Bool)-> some View{
        return VStack(spacing:10){
            HStack(spacing:15){
                
                ImageLoadingView(imageURL:orderData.profilePictureURL)
                    .frame(width: 64,height: 64)
                    .clipShape(.rect(cornerRadius: 32))
                    .clipped()
                VStack(alignment:.leading, spacing:0){
                    HStack{
                        Text(orderData.name)
                            .lineLimit(1)
                            .frame(maxWidth: .infinity,alignment: .leading)
                            .font(.custom(FontContent.besMedium, size: 17))
                        Spacer()
                        Text("Paid")
                            .padding()
                            .frame(height: 23)
                            .font(.custom(FontContent.plusMedium, size: 11))
                            .foregroundStyle(._23_C_16_B)
                            .background(
                                RoundedRectangle(cornerRadius: 12).fill(Color.E_0_FFEE)
                            )
                    }
                    let startDate = orderData.startDate.components(separatedBy: " ").first ?? ""
                    let endDate = orderData.endDate.components(separatedBy: " ").first ?? ""
                    
                    Text("\(startDate.convertDateFormater(beforeFormat: "yyyy-MM-dd", afterFormat: "MMM dd -"))\(endDate.convertDateFormater(beforeFormat: "yyyy-MM-dd", afterFormat: "MMM dd yyyy"))")
                        .font(.custom(FontContent.plusRegular, size: 15))
                        .padding(.bottom,5)
                        .foregroundStyle(._7_C_7_C_80)
                    
                    HStack{
                        Text("$\(orderData.bookingPricingForCustomer.removeZerosFromEnd(num: 2))")
                            .font(.custom(FontContent.plusRegular, size: 15))
                            .padding(.bottom,5)
                            .foregroundStyle(._7_C_7_C_80)
                        Spacer()
                        if isSelected{
                            Image("chevron-up")
                                .resizable()
                                .frame(width: 30, height: 30)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.leading,5)
                
            }
            if isSelected{
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(.E_5_E_5_EA)
                    .padding(.vertical,5)
                let startTime = orderData.startTime.convertDateFormater(beforeFormat: "HH:mm:ss", afterFormat: "h:mm a")
                let endTime = orderData.endTime.convertDateFormater(beforeFormat: "HH:mm:ss", afterFormat: "h:mm a")
                HStack{
                    Text("Time:")
                    Spacer()
                    Text("\(startTime) - \(endTime)")
                        .foregroundStyle(._7_C_7_C_80)
                }
                .font(.custom(FontContent.plusRegular, size: 15))
                
                HStack{
                    Text("Type:")
                    Spacer()
                    Text(orderData.bookingType)
                        .foregroundStyle(._7_C_7_C_80)
                }
                .font(.custom(FontContent.plusRegular, size: 15))
                HStack{
                    Text("Service:")
                    Spacer()
                    Text(orderData.areaOfExperties)
                        .foregroundStyle(._7_C_7_C_80)
                }
                .font(.custom(FontContent.plusRegular, size: 15))
            }
        }
        .padding(.vertical,9)
        .padding(.horizontal,10)
        .background{
            RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 1.0)
                .foregroundStyle(.E_5_E_5_EA)
        }
        .padding(.horizontal,24)
    }
    
    private var BankView: some View{
        VStack (spacing: 15){
            TextField("Full Name", text: $viewModel.fullName)
                .frame(height: 48)
                .padding(.horizontal, 10)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .inset(by: 1)
                        .stroke(.D_1_D_1_D_6, lineWidth: 1)
                )
                .padding(.horizontal, 24)
                .keyboardType(.asciiCapable)
            
//            TextField("Bank Name", text: $viewModel.bankName)
//                .frame(height: 48)
//                .padding(.horizontal, 10)
//                .overlay(
//                    RoundedRectangle(cornerRadius: 8)
//                        .inset(by: 1)
//                        .stroke(.D_1_D_1_D_6, lineWidth: 1)
//                )
//                .padding(.horizontal, 24)
//                .keyboardType(.asciiCapable)
            
            DropDownView(
                selectedValue: viewModel.typeAccount,
                placeHolder: "Type",
                showDropDown: bankTypeShow,
                values: AppConstants.bankAccountType) { value in
                    viewModel.typeAccount = value
                }onShowValue: {
                    bankTypeShow = !bankTypeShow
                }
                .padding(.horizontal, 24)
            
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
                .onReceive(Just(viewModel.accountNumber)) { _ in
                    if viewModel.accountNumber.count > 12 {
                        viewModel.accountNumber = String(viewModel.accountNumber.prefix(12))
                    }
                }
            
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
                .onReceive(Just(viewModel.routingNumber)) { _ in
                    if viewModel.routingNumber.count > 9 {
                        viewModel.routingNumber = String(viewModel.routingNumber.prefix(9))
                    }
                }
            
            TextField("Last 4 digits of SSN Number", text: $viewModel.ssnNumber)
                .frame(height: 48)
                .padding(.horizontal, 10)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .inset(by: 1)
                        .stroke(.D_1_D_1_D_6, lineWidth: 1)
                )
                .padding(.horizontal, 24)
                .keyboardType(.numberPad)
                .onReceive(Just(viewModel.ssnNumber)) { _ in
                    if viewModel.ssnNumber.count > 4 {
                        viewModel.ssnNumber = String(viewModel.ssnNumber.prefix(4))
                    }
                }
            
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
                    viewModel.fullName = viewModel.fullName.removingWhitespaces()
                    if viewModel.fullName.isEmpty{
                        presentAlert(title: "Kryupa", subTitle: "Please Enter Full Name")
                    }else if !viewModel.fullName.isValidName{
                        presentAlert(title: "Kryupa", subTitle: "Please Enter Valid Name")
                    }else if viewModel.typeAccount.isEmpty{
                        presentAlert(title: "Kryupa", subTitle: "Please Select Account Type")
                    }else if viewModel.accountNumber.isEmpty{
                        presentAlert(title: "Kryupa", subTitle: "Please Enter Account Number")
                    }else if !viewModel.accountNumber.validateBankAccount(){
                        presentAlert(title: "Kryupa", subTitle: "Please Enter Valid Account Number")
                    }else if viewModel.routingNumber.isEmpty{
                        presentAlert(title: "Kryupa", subTitle: "Please Enter Routing Number")
                    }else if !viewModel.routingNumber.validateRoutingBankAccount(){
                        presentAlert(title: "Kryupa", subTitle: "Please Enter Valid Routing Number")
                    }else if viewModel.ssnNumber.isEmpty{
                        presentAlert(title: "Kryupa", subTitle: "Please Enter SSN Number")
                    }else if !viewModel.ssnNumber.validateSSN(){
                        presentAlert(title: "Kryupa", subTitle: "Please Enter Valid SSN Number")
                    }else{
                        self.viewModel.AddBankAccount { error in
                            presentAlert(title: "Kryupa", subTitle: error)
                        }
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
                    self.viewModel.fullName = ""
                    self.viewModel.ssnNumber = ""
                    self.viewModel.routingNumber = ""
                    self.viewModel.accountNumber = ""
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
            SegmentTextView(title: "Bank Account", select: viewModel.selectedSection == 1)
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
