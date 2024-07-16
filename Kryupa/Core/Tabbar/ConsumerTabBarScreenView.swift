//
//  ConsumerTabBarScreenView.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 13/06/24.
//

import SwiftUI
import SwiftfulUI

struct ConsumerTabBarScreenView: View {
    @State var selectedIndex: Int = 0
    
    var body: some View {
        VStack{
            switch selectedIndex{
            case 1: BookingScreenView()
            case 2: BookingFormScreenView()
            case 3: InboxScreenView()
            case 4: AccountView()
            default:
                CareSeekerHomeScreenView()
            }
            
            Spacer()
            TabView
        }
        .onAppear{
            NotificationCenter.default.addObserver(forName: .showBookingScreen, object: nil, queue: nil,
                                                   using: self.showBookingScreen)
        }
    }
    
    private var TabView: some View{
        HStack(){
            Spacer()
            
            tabbarItem(image: "Home", text: "Home", selected: selectedIndex == 0)
                .asButton(.press) {
                    ChatScreenViewModel.shared.disconnect()
                    Defaults().bookingId = ""
                    selectedIndex = 0
                }
            
            Spacer()
            tabbarItem(image: "Bookings", text: "Bookings", selected: selectedIndex == 1)
                .asButton(.press) {
                    ChatScreenViewModel.shared.disconnect()
                    Defaults().bookingId = ""
                    selectedIndex = 1
                }
            Spacer()
            
            tabbarItem(image: "Jobs", text: "Book now", selected: selectedIndex == 2)
                .asButton(.press) {
                    ChatScreenViewModel.shared.disconnect()
                    Defaults().bookingId = ""
                    selectedIndex = 2
                }
            Spacer()
            tabbarItem(image: "Inbox", text: "Inbox", selected: selectedIndex == 3)
                .asButton(.press) {
                    Defaults().bookingId = ""
                    selectedIndex = 3
                }
            
            Spacer()
            tabbarItem(image: "account", text: "Account", selected: selectedIndex == 4)
                .asButton(.press) {
                    ChatScreenViewModel.shared.disconnect()
                    Defaults().bookingId = ""
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
    }
    
    private func tabbarItem(image: String,text: String,selected: Bool)-> some View{
        return VStack{
            Image(image)
                .resizable()
                .renderingMode(.template)
                .frame(width: 24,height: 24)
            Text(text)
                .font(.custom(FontContent.plusRegular, size: 12))
        }
        .foregroundStyle(selected ? .appMain : ._7_C_7_C_80)
    }
    
    private func showBookingScreen(_ notification: Notification) {
        selectedIndex = 2
    }
}

#Preview {
    ConsumerTabBarScreenView()
}
