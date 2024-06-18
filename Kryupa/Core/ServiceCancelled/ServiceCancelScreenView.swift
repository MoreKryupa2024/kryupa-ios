//
//  ServiceCancelScreenView.swift
//  Kryupa
//
//  Created by Hemant Singh Rajput on 13/06/24.
//

import SwiftUI

struct ServiceCancelScreenView: View {
    @Environment(\.router) var router
    @State var selectedReason: String = String()
    @State var reasonDescription: String = String()
    
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
                    
                    DropDownView(
                        selectedValue: selectedReason,
                        placeHolder: "Select",
                        values: AppConstants.genderArray) { value in
                            selectedReason = value
                        }
                        .padding(.top,15)
                        .padding(.horizontal,24)
                    
                    DescriptionView
                        .padding(.top,15)
                        .padding(.horizontal,24)
                    
                    CancelButton
                        .padding(.top,60)
                    
                }
                .scrollIndicators(.hidden)
            }
//            if viewModel.isloading{
//                LoadingView()
//            }
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
    private var DescriptionView: some View{
        VStack(alignment: .leading, spacing:0,
               content: {
            Text("Description")
                .font(.custom(FontContent.plusMedium, size: 17))
            
            TextEditor(text: $reasonDescription)
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
                selectedValue: selectedReason,
                placeHolder: "Select",
                values: AppConstants.genderArray) { value in
                    selectedReason = value
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
