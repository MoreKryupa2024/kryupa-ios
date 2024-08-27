//
//  GiverTabbarScreenView.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 14/06/24.
//

import SwiftUI

struct GiverTabbarScreenView: View {
    
    @State var selectedIndex: Int = 0
    var showInboxScreen = NotificationCenter.default
    var notificatioSetChatScreen = NotificationCenter.default
    var showJobsScreen = NotificationCenter.default
    @Environment(\.router) var router
    @State var chatScreenShow: Bool = true
    
    var body: some View {
        VStack{
            switch selectedIndex{
            case 1: BookingScreenView()
            case 2: JobListView()
            case 3: InboxScreenView()
            case 4: AccountView()
            default:
                CareGiverHomeScreenView()
            }
            
            Spacer()
            TabView
        }
        .task{
            showJobsScreen.addObserver(forName: .showJobsScreen, object: nil, queue: nil,
                                                   using: self.showJobsScreen)
            showInboxScreen.addObserver(forName: .showInboxScreen, object: nil, queue: nil,
                                                   using: self.showInboxScreen)
            notificatioSetChatScreen.addObserver(forName: .setChatScreen, object: nil, queue: nil,
                                                   using: self.setChatScreen)
        }
    }
    
    private func showInboxScreen(_ notification: Notification) {
        selectedIndex = 3
    }
    
    private func setChatScreen(_ notification: Notification){
        if chatScreenShow{
            chatScreenShow = false
            if let data = notification.userInfo, let dataDict = data as? [String:Any] {
                if let actionType = dataDict["action_type"] {
                    let chatScreenviewModel = ChatScreenViewModel()
                    chatScreenviewModel.selectedChat = ChatListData(jsonData: dataDict)
                    router.showScreen(.push) { rout in
                        ChatView(userName: data["name"] as? String ?? "",viewModel: chatScreenviewModel)
                    }
                }
            }
        }
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
    
    private var TabView: some View{
        HStack(){
            Spacer()
            tabbarItem(image: "Home", text: "Home", selected: selectedIndex == 0)
                .asButton(.press) {
                    ChatScreenViewModel.shared.disconnect()
                    selectedIndex = 0
                }
            
            Spacer()
            
            tabbarItem(image: "Bookings", text: "Bookings", selected: selectedIndex == 1)
                .asButton(.press) {
                    ChatScreenViewModel.shared.disconnect()
                    selectedIndex = 1
                }
            Spacer()
            
            tabbarItem(image: "Jobs", text: "Jobs", selected: selectedIndex == 2)
                .asButton(.press) {
                    ChatScreenViewModel.shared.disconnect()
                    selectedIndex = 2
                }
            Spacer()
            
            tabbarItem(image: "Inbox", text: "Inbox", selected: selectedIndex == 3)
                .asButton(.press) {
                    selectedIndex = 3
                }
            
            Spacer()
            
            tabbarItem(image: "Account", text: "Account", selected: selectedIndex == 4)
                .asButton(.press) {
                    ChatScreenViewModel.shared.disconnect()
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
    
    private func showJobsScreen(_ notification: Notification) {
        selectedIndex = 2
    }
}

#Preview {
    GiverTabbarScreenView()
}
