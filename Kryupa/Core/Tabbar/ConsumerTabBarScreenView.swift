//
//  ConsumerTabBarScreenView.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 13/06/24.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting
struct ConsumerTabBarScreenView: View {
    
    
    @StateObject var consumerTabBarScreenViewModel = ConsumerTabBarScreenViewModel()
    let notificatioShowWalletScreen = NotificationCenter.default
    @Environment(\.router) var router
    @State var navWallet:Bool = true

    var body: some View {
        ZStack{
            VStack{
                switch consumerTabBarScreenViewModel.selectedIndex{
                    
                case 1:
                    //                let bookingViewModel = BookingViewModel()
                    //                bookingViewModel.selectedSection = selectedIndexBooking
                    BookingScreenView(viewModel: consumerTabBarScreenViewModel.bookingViewModel)
                case 2: BookingFormScreenView()
                case 3: InboxScreenView()
                case 4: AccountView()
                default:
                    CareSeekerHomeScreenView()
                }
                
                Spacer()
                TabView
            }
            
            if consumerTabBarScreenViewModel.isLoading{
                LoadingView()
            }
        }
        .task {
            notificatioShowWalletScreen.addObserver(forName: .showWalletScreen, object: nil, queue: nil,
                                                    using: self.showWalletScreen)
        }
        .onChange(of: consumerTabBarScreenViewModel.isPresented) { oldValue, newValue in
            if consumerTabBarScreenViewModel.isPresented{
                consumerTabBarScreenViewModel.isPresented = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    NotificationCenter.default.post(name: .setChatScreen, object: nil,userInfo: consumerTabBarScreenViewModel.notObjext)
                }
            }
        }
    }
    
    private func showWalletScreen(_ notification: Notification){
        if navWallet{
            navWallet = false
            router.showScreen(.push) { rout in
                WalletScreenView()
            }
        }
    }
    
    private var TabView: some View{
        HStack(){
            Spacer()
            
            tabbarItem(image: "Home", text: "Home", selected: consumerTabBarScreenViewModel.selectedIndex == 0)
                .asButton(.press) {
                    consumerTabBarScreenViewModel.bookingViewModel.selectedSection = 0
                    Defaults().bookingId = ""
                    consumerTabBarScreenViewModel.selectedIndex = 0
                }
            
            Spacer()
            tabbarItem(image: "Bookings", text: "Bookings", selected: consumerTabBarScreenViewModel.selectedIndex == 1)
                .asButton(.press) {
                    consumerTabBarScreenViewModel.bookingViewModel.selectedSection = 0
                    Defaults().bookingId = ""
                    consumerTabBarScreenViewModel.selectedIndex = 1
                }
            Spacer()
            
            tabbarItem(image: "Jobs", text: "Book now", selected: consumerTabBarScreenViewModel.selectedIndex == 2)
                .asButton(.press) {
                    consumerTabBarScreenViewModel.bookingViewModel.selectedSection = 0
                    Defaults().bookingId = ""
                    consumerTabBarScreenViewModel.selectedIndex = 2
                }
            Spacer()
            tabbarItem(image: "Inbox", text: "Inbox", selected: consumerTabBarScreenViewModel.selectedIndex == 3)
                .asButton(.press) {
                    consumerTabBarScreenViewModel.bookingViewModel.selectedSection = 0
                    Defaults().bookingId = ""
                    consumerTabBarScreenViewModel.selectedIndex = 3
                }
            
            Spacer()
            tabbarItem(image: "account", text: "Account", selected: consumerTabBarScreenViewModel.selectedIndex == 4)
                .asButton(.press) {
                    consumerTabBarScreenViewModel.bookingViewModel.selectedSection = 0
                    Defaults().bookingId = ""
                    consumerTabBarScreenViewModel.selectedIndex = 4
                    
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
    
}

#Preview {
    ConsumerTabBarScreenView()
}

class ConsumerTabBarScreenViewModel: ObservableObject{
    let showBookingScreen = NotificationCenter.default
    let showInboxScreen = NotificationCenter.default
    let showBookingsHistoryScreen = NotificationCenter.default
    
    @Published var bookingViewModel = BookingViewModel()
    @Published var notObjext = [String:Any]()
    @Published var selectedIndex: Int = 0
    @Published var chatScreenShow: Bool = false
    
    @Published var isLoading: Bool = false
    @Published var isPresented: Bool = false
    var meetingTokenData: BGVInterviewMeetingTokenData?
    
    init(){
        showBookingScreen.addObserver(forName: .showBookingScreen, object: nil, queue: nil,
                                      using: self.showBookingScreen)
        
        showInboxScreen.addObserver(forName: .showInboxScreen, object: nil, queue: nil,
                                    using: self.showInboxScreen)
        
        showBookingsHistoryScreen.addObserver(forName: .showBookingsHistoryScreen, object: nil, queue: nil,
                                              using: self.showBookingsHistoryScreen)
    }
    
    private func showBookingScreen(_ notification: Notification) {
        selectedIndex = 2
    }
    
    private func showInboxScreen(_ notification: Notification) {
        selectedIndex = 3
        self.isPresented = true
        if let data = notification.userInfo, let dataDict = data as? [String:Any] {
            self.notObjext = dataDict
        }
    }
    
    private func showBookingsHistoryScreen(_ notification: Notification) {
        if let selectedIndexBooking = notification.userInfo?["selectedIndexBookingScreen"] as? Int {
            self.bookingViewModel.selectedSection = selectedIndexBooking
        }
        selectedIndex = 1
    }
}
