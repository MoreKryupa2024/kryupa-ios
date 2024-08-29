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
    @State var walletScreenShown: Bool = true
    @State var chatScreenShow: Bool = true
    @StateObject var bookingViewModel = BookingViewModel()
    let showBookingScreen = NotificationCenter.default
    let showInboxScreen = NotificationCenter.default
    let showBookingsHistoryScreen = NotificationCenter.default
    let notificatioSetChatScreen = NotificationCenter.default
    let notificatioShowWalletScreen = NotificationCenter.default
    @Environment(\.router) var router
    
    var body: some View {
        VStack{
            switch selectedIndex{
                
            case 1: 
//                let bookingViewModel = BookingViewModel()
//                bookingViewModel.selectedSection = selectedIndexBooking
                BookingScreenView(viewModel: bookingViewModel)
            case 2: BookingFormScreenView()
            case 3: InboxScreenView()
            case 4: AccountView()
            default:
                CareSeekerHomeScreenView()
            }
            
            Spacer()
            TabView
        }
        .task{
            walletScreenShown = true
            notificatioShowWalletScreen.addObserver(forName: .showWalletScreen, object: nil, queue: nil,
                                                                    using: self.showWalletScreen)
            
            showBookingScreen.addObserver(forName: .showBookingScreen, object: nil, queue: nil,
                                                   using: self.showBookingScreen)
            
            showInboxScreen.addObserver(forName: .showInboxScreen, object: nil, queue: nil,
                                                   using: self.showInboxScreen)
            
            showBookingsHistoryScreen.addObserver(forName: .showBookingsHistoryScreen, object: nil, queue: nil,
                                                   using: self.showBookingsHistoryScreen)
            
            notificatioSetChatScreen.addObserver(forName: .setChatScreen, object: nil, queue: nil,
                                                         using: self.setChatScreen)
        }
    }
    
    private func showWalletScreen(_ notification: Notification){
        if walletScreenShown{
            walletScreenShown = false
            router.showScreen(.push) { rout in
                WalletScreenView()
            }
        }
    }
    
    private func setChatScreen(_ notification: Notification){
        if chatScreenShow{
            chatScreenShow = false
            if let data = notification.userInfo, let dataDict = data as? [String:Any] {
                let chatScreenviewModel = ChatScreenViewModel()
                chatScreenviewModel.selectedChat = ChatListData(jsonData: dataDict)
                router.showScreen(.push) { rout in
                    ChatView(userName: data["name"] as? String ?? "",viewModel: chatScreenviewModel)
                }
            }
        }
    }
    
    private var TabView: some View{
        HStack(){
            Spacer()
            
            tabbarItem(image: "Home", text: "Home", selected: selectedIndex == 0)
                .asButton(.press) {
                    bookingViewModel.selectedSection = 0
                    ChatScreenViewModel.shared.disconnect()
                    Defaults().bookingId = ""
                    selectedIndex = 0
                }
            
            Spacer()
            tabbarItem(image: "Bookings", text: "Bookings", selected: selectedIndex == 1)
                .asButton(.press) {
                    bookingViewModel.selectedSection = 0
                    ChatScreenViewModel.shared.disconnect()
                    Defaults().bookingId = ""
                    selectedIndex = 1
                }
            Spacer()
            
            tabbarItem(image: "Jobs", text: "Book now", selected: selectedIndex == 2)
                .asButton(.press) {
                    bookingViewModel.selectedSection = 0
                    ChatScreenViewModel.shared.disconnect()
                    Defaults().bookingId = ""
                    selectedIndex = 2
                }
            Spacer()
            tabbarItem(image: "Inbox", text: "Inbox", selected: selectedIndex == 3)
                .asButton(.press) {
                    bookingViewModel.selectedSection = 0
                    Defaults().bookingId = ""
                    selectedIndex = 3
                }
            
            Spacer()
            tabbarItem(image: "account", text: "Account", selected: selectedIndex == 4)
                .asButton(.press) {
                    bookingViewModel.selectedSection = 0
                    ChatScreenViewModel.shared.disconnect()
                    Defaults().bookingId = ""
                    selectedIndex = 4
                    
                }
            Spacer()
        }
        .padding(.top,10)
        .background(
            Rectangle()
                .foregroundStyle(._444446.opacity(0.2))
                .frame(height: 1)
                .offset(y:-34)
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
    
    private func showInboxScreen(_ notification: Notification) {
        selectedIndex = 3
    }
    
    private func showBookingsHistoryScreen(_ notification: Notification) {
        if let selectedIndexBooking = notification.userInfo?["selectedIndexBookingScreen"] as? Int {
            self.bookingViewModel.selectedSection = selectedIndexBooking
        }
        selectedIndex = 1
    }
}

#Preview {
    ConsumerTabBarScreenView()
}
