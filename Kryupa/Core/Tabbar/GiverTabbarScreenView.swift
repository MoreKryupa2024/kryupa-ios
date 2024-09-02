//
//  GiverTabbarScreenView.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 14/06/24.
//

import SwiftUI
import SwiftfulRouting
struct GiverTabbarScreenView: View {
    
    @Environment(\.router) var router
    @StateObject var viewModel = GiverTabbarScreenViewModel()
    
    var body: some View {
        ZStack{
            VStack{
                switch viewModel.selectedIndex{
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
            
            if viewModel.isLoading{
                LoadingView()
            }
            
        }
        .onChange(of: viewModel.isPresented) { oldValue, newValue in
            if viewModel.isPresented{
                viewModel.isPresented = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    NotificationCenter.default.post(name: .setChatScreen, object: nil,userInfo: viewModel.notObjext)
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
            tabbarItem(image: "Home", text: "Home", selected: viewModel.selectedIndex == 0)
                .asButton(.press) {
                    viewModel.selectedIndex = 0
                }
            
            Spacer()
            
            tabbarItem(image: "Bookings", text: "Bookings", selected: viewModel.selectedIndex == 1)
                .asButton(.press) {
                    viewModel.selectedIndex = 1
                }
            Spacer()
            
            tabbarItem(image: "Jobs", text: "Jobs", selected: viewModel.selectedIndex == 2)
                .asButton(.press) {
                    viewModel.selectedIndex = 2
                }
            Spacer()
            
            tabbarItem(image: "Inbox", text: "Inbox", selected: viewModel.selectedIndex == 3)
                .asButton(.press) {
                    viewModel.selectedIndex = 3
                }
            
            Spacer()
            
            tabbarItem(image: "Account", text: "Account", selected: viewModel.selectedIndex == 4)
                .asButton(.press) {
                    viewModel.selectedIndex = 4
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
}

#Preview {
    GiverTabbarScreenView()
}


class GiverTabbarScreenViewModel: ObservableObject{
    
    @Published var selectedIndex: Int = 0
    var showInboxScreen = NotificationCenter.default
    var showJobsScreen = NotificationCenter.default
    @Published var isLoading: Bool = false
    @Published var isPresented: Bool = false
    let chatScreenviewModel = ChatScreenViewModel()
    var meetingTokenData: BGVInterviewMeetingTokenData?
    @Published var notObjext = [String:Any]()
    
    init(){
        showJobsScreen.addObserver(forName: .showJobsScreen, object: nil, queue: nil,
                                               using: self.showJobsScreen)
        showInboxScreen.addObserver(forName: .showInboxScreen, object: nil, queue: nil,
                                               using: self.showInboxScreen)
    }
    
    private func showJobsScreen(_ notification: Notification) {
        selectedIndex = 2
    }
    
    private func showInboxScreen(_ notification: Notification) {
        selectedIndex = 3
        self.isPresented = true
        if let data = notification.userInfo, let dataDict = data as? [String:Any] {
            self.notObjext = dataDict
        }
    }
}
