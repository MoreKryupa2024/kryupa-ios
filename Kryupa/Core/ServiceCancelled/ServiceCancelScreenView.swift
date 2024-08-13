//
//  ServiceCancelScreenView.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 13/06/24.
//

import SwiftUI
import SwiftfulUI

struct ServiceCancelScreenView: View {
    @Environment(\.router) var router
    @StateObject var viewModel = ServiceDetailScreenViewModel()
    
    var body: some View {
        ZStack{
            VStack(spacing:0){
             HeaderView
                ScrollView{
                    
                    Text("Personal Information")
                        .font(.custom(FontContent.besMedium, size: 22))
                        .frame(height: 28)
                        .padding(.top,30)
                    
                    ReasonDropdownView
                        .padding(.horizontal,24)
                        .padding(.top,30)
                    
                    if viewModel.selectedReason == "Other"{
                        otherFieldView
                            .padding(.horizontal,24)
                            .padding(.top,15)
                    }
                    
                    DescriptionView
                        .padding(.top,15)
                        .padding(.horizontal,24)
                    
                    CancelButton
                        .padding(.top,60)
                        .asButton(.press) {
                            viewModel.bookingCancel { error in
                                presentAlert(title: "Kryupa", subTitle: error)
                            } action: {
                                router.showScreen(.push) { route in
                                    CancelSuccessScreen()
                                }
                            }
                        }
                }
                .scrollIndicators(.hidden)
            }
            if viewModel.isloading{
                LoadingView()
            }
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
    private var otherFieldView: some View{
        
        TextField(text: $viewModel.selectedReasonTwo) {
            Text("Other Reason")
                .foregroundStyle(._7_C_7_C_80)
        }
        .keyboardType(.asciiCapable)
        .font(.custom(FontContent.plusRegular, size: 15))
        .padding([.leading,.trailing],10)
        .background {
            RoundedRectangle(cornerRadius: 8)
                .stroke(lineWidth: 1)
                .foregroundStyle(.D_1_D_1_D_6)
                .frame(height: 48)
        }
        .padding(.top,10)
    }
    
    private var DescriptionView: some View{
        VStack(alignment: .leading, spacing:0,
               content: {
            Text("Description")
                .font(.custom(FontContent.plusMedium, size: 17))
            
            TextEditor(text: $viewModel.reasonDescription)
                .frame(height: 120)
                .keyboardType(.asciiCapable)
                .font(.custom(FontContent.plusRegular, size: 15))
                .padding([.leading,.trailing],10)
                .background {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(lineWidth: 1)
                        .foregroundStyle(.D_1_D_1_D_6)
                        .frame(height: 125)
                }
                .padding(.top,15)
        })
    }
    
    private var ReasonDropdownView: some View{
        VStack(alignment: .leading, spacing:0,
               content: {
            HStack(spacing:0){
                Text("Reason Of Cancellation")
                Text("*")
                    .foregroundStyle(.red)
            }
            .frame(height: 21)
            .font(.custom(FontContent.plusMedium, size: 17))
            .padding(.bottom,15)
            
            DropDownView(
                selectedValue: viewModel.selectedReason,
                placeHolder: "Select",
                values: Defaults().userType == AppConstants.GiveCare ? AppConstants.cancelGiverReasons : AppConstants.cancelSeekerReasons) { value in
                    viewModel.selectedReason = value
                }
        })
        .padding(.bottom,-10)
    }
    
    private var CancelButton: some View {
        HStack{
            Text("Cancel Booking")
                .font(.custom(FontContent.plusMedium, size: 16))
                .padding(.vertical, 16)
                .padding(.horizontal, 40)
        }
        .background(
            ZStack{
                Capsule(style: .circular)
                    .fill(.appMain)
            }
        )
        .foregroundColor(.white)
    }
    
    private var HeaderView: some View{
        ZStack{
            Image("KryupaLobby")
                .resizable()
                .frame(width: 124,height: 20)
            
            HStack{
                Image("navBack")
                    .resizable()
                    .frame(width: 30,height: 30)
                    .asButton(.press) {
                        router.dismissScreen()
                    }
                Spacer()
                Image("NotificationBellIcon")
                    .frame(width: 25,height: 25)
            }
            .padding(.horizontal,24)
        }
    }
}

#Preview {
    ServiceCancelScreenView()
}
