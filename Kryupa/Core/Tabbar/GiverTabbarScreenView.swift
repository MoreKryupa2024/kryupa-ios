//
//  GiverTabbarScreenView.swift
//  Kryupa
//
//  Created by Hemant Singh Rajput on 14/06/24.
//

import SwiftUI

struct GiverTabbarScreenView: View {
    @State var selectedIndex: Int = 0
    
    var body: some View {
        VStack{
            switch selectedIndex{
            case 1: BookingScreenView()
            case 2: EmptyView()
            case 3: InboxScreenView()
            case 4: AccountView()
            default:
                CareGiverHomeScreenView()
            }
            
            Spacer()
            TabView
        }
    }
    
    private var TabView: some View{
        HStack(){
            Spacer()
            VStack(){
                Image("Home")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 24,height: 24)
                Text("Home")
                    .font(.custom(FontContent.plusRegular, size: 12))
            }
            .foregroundStyle(selectedIndex == 0 ? .appMain : ._7_C_7_C_80)
            .asButton(.press) {
                selectedIndex = 0
            }
            
            Spacer()
            VStack{
                Image("Bookings")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 24,height: 24)
                Text("Bookings")
                    .font(.custom(FontContent.plusRegular, size: 12))
            }
            .foregroundStyle(selectedIndex == 1 ? .appMain : ._7_C_7_C_80)
            .asButton(.press) {
                selectedIndex = 1
            }
            Spacer()
            VStack{
                Image("Jobs")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 24,height: 24)
                Text("Jobs")
                    .font(.custom(FontContent.plusRegular, size: 12))
            }
            .foregroundStyle(selectedIndex == 2 ? .appMain : ._7_C_7_C_80)
            .asButton(.press) {
                selectedIndex = 2
            }
            Spacer()
            VStack{
                Image("Inbox")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 24,height: 24)
                Text("Inbox")
                    .font(.custom(FontContent.plusRegular, size: 12))
            }
            .foregroundStyle(selectedIndex == 3 ? .appMain : ._7_C_7_C_80)
            .asButton(.press) {
                selectedIndex = 3
            }
            
            Spacer()
            VStack{
                Image("Account")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 24,height: 24)
                Text("Account")
                    .font(.custom(FontContent.plusRegular, size: 12))
            }
            .foregroundStyle(selectedIndex == 4 ? .appMain : ._7_C_7_C_80)
            .asButton(.press) {
                selectedIndex = 4
            }
            Spacer()
        }
        .padding(.top,10)
        .background(
            Color.white // any non-transparent background
                .shadow(color: ._444446.opacity(0.2), radius: 10, x: 0, y: 0)
                .mask(Rectangle().padding(.top, -20)) /// here!
        )
//        .ignoresSafeArea()
    }
}

#Preview {
    GiverTabbarScreenView()
}
