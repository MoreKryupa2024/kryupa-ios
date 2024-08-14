//
//  ChatView.swift
//  Kryupa
//
//  Created by Pooja Nenava on 05/06/24.
//

import SwiftUI
import SwiftfulUI
import Combine

struct ChatView: View {
    @Environment(\.router) var router
    @State var userName: String = ""
    @State var sendMsgText: String = ""
    let notificatioSsetBookingId = NotificationCenter.default
    let notificatioSsetInboxId = NotificationCenter.default
    @StateObject var viewModel = ChatScreenViewModel()
    
    var body: some View {
        ZStack{
            
            VStack(spacing:20){
                //HeaderView
                usernameView
                if Defaults().userType == AppConstants.SeekCare{
//                    if viewModel.showVideoCallView{
//                        videoCallView
//                    }
//                    
//                    if viewModel.bookingDeclineView{
//                        bookingDeclineView
//                    }
                    if (viewModel.normalBooking || viewModel.isRecommended){
                        bookNowView
                    }
                    
//                    if viewModel.showPayViewView{
//                        acceptedRequestView
//                    }
                }
                
                ScrollView(.vertical) {
                    LazyVStack {
                        ForEach(Array(viewModel.messageList.enumerated()), id:\.element.id) {
                            (index,msg) in
                            
                            ChatBoxView(msgData: msg, selectedChat: viewModel.selectedChat,onSelectedValue: { SpecialMessageData in
                                let viewModelJob = JobsViewModel()
                                viewModelJob.isComingfromChat = true
                                router.showScreen(.push) { rout in
                                    JobDetailView(viewModel:viewModelJob,jobID: SpecialMessageData.approchId)
                                }
                            },onPaySelectedValue: { SpecialMessageData in
                                let paymentViewModel = PaymentViewModel()
                                paymentViewModel.paySpecialMessageData = SpecialMessageData
                                router.showScreen(.push) { rout in
                                    PaymentOrderScreenView(viewModel: paymentViewModel)
                                }
                            })
//                            .onAppear{
//                                if (viewModel.messageList.count - 1) == index  && viewModel.pagination{
//                                    viewModel.pageNumber += 1
//                                    viewModel.getChatHistory()
//                                }
//                            }
                            .rotationEffect(Angle(degrees: 180)).scaleEffect(x: -1.0, y: 1.0, anchor: .center)
                        }
                    }
                }
                .rotationEffect(Angle(degrees: 180)).scaleEffect(x: -1.0, y: 1.0, anchor: .center)
                .padding(.horizontal, 10)
                .scrollIndicators(.hidden)
                sendMessageView
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .toolbar(.hidden, for: .navigationBar)
            .task{
                viewModel.pageNumber = 1
                viewModel.connect()
                DispatchQueue.main.async {
                    viewModel.receiveMessage { msgData, str in
                        viewModel.messageList = [msgData] + viewModel.messageList
                    }
                }
                viewModel.getChatHistory()
                viewModel.VideoCallData()
                notificatioSsetBookingId.addObserver(forName: .setBookingId, object: nil, queue: nil,
                                                             using: self.setBookingIds)
            }
            
            
            if viewModel.isLoading{
                LoadingView()
            }
            
            if viewModel.isPresented {
                ZoomScreenView(
                    jwt:viewModel.meetingTokenData?.sessionToken ?? "" ,
                    sessionName: viewModel.meetingTokenData?.topic ?? "",
                    sessionPassword:viewModel.meetingTokenData?.sessionKey ?? "",
                    username: viewModel.meetingTokenData?.userIdentity ?? ""
                ) { error in
                    print("error :- \(error.description)")
                    viewModel.selectedChat?.videoCallId = ""
                    viewModel.isPresented = false
                } onViewLoadedAction: {
                    print("loaded")
                    viewModel.selectedChat?.videoCallId = ""
                } onViewDismissedAction: {
                    viewModel.selectedChat?.videoCallId = ""
                    viewModel.isPresented = false
                }
            }
        }
    }
    
    private func setBookingIds(_ notification: Notification){
        if let bookingid = notification.userInfo?["bookingId"] as? String {
            viewModel.bookingId = bookingid
            viewModel.isRecommended = false
            viewModel.sendRequestForBookCaregiver()
        }
    }
    
    private var videoCallView: some View{
        
        return ZStack(alignment:.top){
            VStack {
                Text("Why discuss it on messages?\nVideo Call Now!")
                    .multilineTextAlignment(.center)
                    .font(.custom(FontContent.plusRegular, size: 16))
                    .foregroundStyle(._7_C_7_C_80)
                
                
                Text("Start Video Call")
                    .font(.custom(FontContent.plusRegular, size: 16))
                    .foregroundStyle(.white)
                    .frame(height: 32)
                    .padding(.horizontal,15)
                    .background{
                        RoundedRectangle(cornerRadius: 48)
                    }
                    .asButton(.press) {
                        presentAlert(title: "Kryupa", subTitle: "This Feature Coming Soon!")
                    }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical,12)
            .overlay( /// apply a rounded border
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.E_5_E_5_EA, lineWidth: 1)
            )
            
            Image("circle-x")
                .resizable()
                .frame(width: 18,height: 18)
                .asButton(.press) {
//                    viewModel.showVideoCallView = false
                }
                .offset(x: 130,y:15)
        }
        .padding(.horizontal,25)
        
    }
    
    private var bookingDeclineView: some View{
        
        return ZStack(alignment:.top){
            VStack {
                Text("The caregiver has declined the\nrequest for service.")
                    .multilineTextAlignment(.center)
                    .font(.custom(FontContent.plusRegular, size: 16))
                    .foregroundStyle(._7_C_7_C_80)
                
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical,12)
            .overlay( /// apply a rounded border
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.E_5_E_5_EA, lineWidth: 1)
            )
            
            Image("circle-x")
                .resizable()
                .frame(width: 18,height: 18)
                .asButton(.press) {
//                    viewModel.bookingDeclineView = false
                }
                .offset(x: 130,y:15)
        }
        .padding(.horizontal,25)
        
    }
    
    private var acceptedRequestView: some View{
        
        return ZStack(alignment:.top){
            VStack {
                Text("Congratulations!\nThe caregiver has accepted the request")
                    .multilineTextAlignment(.center)
                    .font(.custom(FontContent.plusRegular, size: 16))
                    .foregroundStyle(._7_C_7_C_80)
                
                
                Text("Pay Now")
                    .font(.custom(FontContent.plusRegular, size: 16))
                    .foregroundStyle(.white)
                    .frame(height: 32)
                    .padding(.horizontal,15)
                    .background{
                        RoundedRectangle(cornerRadius: 48)
                    }
                    .asButton(.press) {
                        let paymentViewModel = PaymentViewModel()
                        paymentViewModel.paySpecialMessageData = viewModel.paySpecialMessageData
                        router.showScreen(.push) { rout in
                            PaymentOrderScreenView(viewModel: paymentViewModel)
                        }
                    }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical,12)
            .overlay( /// apply a rounded border
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.E_5_E_5_EA, lineWidth: 1)
            )
        }
        .padding(.horizontal,25)
        
    }
    
    private var bookNowView: some View{
        
        return ZStack(alignment:.top){
            VStack {
                Text("Found your ideal caregiver?")
                    .multilineTextAlignment(.center)
                    .font(.custom(FontContent.plusRegular, size: 16))
                    .foregroundStyle(._7_C_7_C_80)
                
                
                Text("Book Now")
                    .font(.custom(FontContent.plusRegular, size: 16))
                    .foregroundStyle(.white)
                    .frame(height: 32)
                    .padding(.horizontal,15)
                    .background{
                        RoundedRectangle(cornerRadius: 48)
                    }
                    .asButton(.press) {
                        if viewModel.isRecommended{
                            let bookingViewModel = BookingFormScreenViewModel()
                            bookingViewModel.isRecommended = true
                            bookingViewModel.giverId = viewModel.selectedChat?.giverId ?? ""
                            bookingViewModel.giverName = viewModel.selectedChat?.caregiverName ?? ""
                            
                            router.showScreen(.push) { route in
                                BookingFormScreenView(viewModel: bookingViewModel)
                            }
                        }else{
                            viewModel.normalBooking = false
                            viewModel.sendRequestForBookCaregiver()
                        }
                    }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical,12)
            .overlay( /// apply a rounded border
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.E_5_E_5_EA, lineWidth: 1)
            )
        }
        .padding(.horizontal,25)
    }
    
    private var sendMessageView: some View{
        
        return HStack {
            //            Image("camera")
            //                .resizable()
            //                .frame(width: 39,height: 29)
            //                .asButton(.press) {
            //                    print("Camera")
            //            }
            
            HStack {
                TextField("Hello!", text:$sendMsgText, axis: .vertical)
                    .lineLimit(3)
                    .padding(.leading, 15)
                    .padding(.vertical, 4)
                    .foregroundStyle(.gray)
                    .font(.custom(FontContent.plusRegular, size: 17))
                    .frame(minHeight: 36)
                
                
                HStack(spacing:5) {
                    
                    //Image("audio")
                    //.dynamicTypeSize(.medium)
                    //.frame(width: 28,height: 28)
                    //.asButton(.press) {
                    //}
                    
                    Image("sendbutton")
                        .dynamicTypeSize(.medium)
                        .frame(width: 28,height: 28)
                        .asButton(.press) {
                            let text = sendMsgText.trimmingCharacters(in: .whitespaces)
                            if !text.isEmpty{
                                DispatchQueue.main.async {
                                    viewModel.sendMessage(text)
                                }
                                sendMsgText = ""
                            }
                            sendMsgText = ""
                        }
                }
                .padding(.trailing, 5)
                
            }
            .overlay(
                RoundedRectangle(cornerRadius: 18)
                    .inset(by: 1)
                    .stroke(.E_5_E_5_EA, lineWidth: 1)
            )
            
        }
        .padding(.horizontal, 20)
    }
    
    private var requestView: some View{
        
        VStack(spacing: 10) {
            Text("Would you like to give service to Alexa?")
                .font(.custom(FontContent.besRegular, size: 15))
                .padding(.horizontal, 20)
            
            HStack(spacing: 10) {
                Text("Accept")
                    .font(.custom(FontContent.plusRegular, size: 16))
                    .foregroundStyle(.white)
                    .frame(height: 32)
                    .frame(width: 97)
                    .background{
                        RoundedRectangle(cornerRadius: 48)
                    }
                    .asButton(.press) {
                        
                    }
                
                Text("Decline")
                    .font(.custom(FontContent.plusRegular, size: 16))
                    .foregroundStyle(.appMain)
                    .frame(height: 32)
                    .frame(width: 99)
                    .overlay(
                        RoundedRectangle(cornerRadius: 48)
                            .inset(by: 1)
                            .stroke(.appMain, lineWidth: 1)
                    )
                    .asButton(.press) {
                        
                    }
            }
        }
        .frame(height: 86)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .inset(by: 1)
                .stroke(.E_5_E_5_EA, lineWidth: 1)
        )
    }
    
    private var usernameView: some View{
        
        HStack(spacing: 10) {
            
            Image("navBack")
                .resizable()
                .frame(width: 30,height: 30)
                .asButton(.press) {
                    viewModel.disconnect()
                    router.dismissScreenStack()
                    notificatioSsetInboxId.post(name: .showInboxScreen, object: nil)
                }
            
            Text(userName)
                .lineLimit(1)
                .font(.custom(FontContent.besRegular, size: 20))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                Image("video")
                    .resizable()
                    .frame(width: 24,height: 24)
                    .asButton(.press) {
                        viewModel.chatVideoCallData()
                    }
            }
        }
        .padding(.horizontal, 24)
        
        
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
    ChatView()
}
