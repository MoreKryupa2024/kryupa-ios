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
    @State var bookingCalled: Bool = true
    let notificatioSsetBookingId = NotificationCenter.default

    @StateObject var viewModel = ChatScreenViewModel()
    
    var body: some View {
        ZStack{
            VStack(spacing:0){
                UserNameView(backAction: {
                    viewModel.disconnect()
                    router.dismissScreen()
                }, videoAction: {
                    viewModel.chatVideoCallData()
                }, nameStr: userName)
                if Defaults().userType == AppConstants.SeekCare{
//                    if (viewModel.normalBooking || viewModel.isRecommended){
//                        bookNowView
//                    }

                }
                
                ScrollView(.vertical) {
                    VStack {
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
                            .rotationEffect(Angle(degrees: 180)).scaleEffect(x: -1.0, y: 1.0, anchor: .center)
                        }
                    }
                }
                .rotationEffect(Angle(degrees: 180)).scaleEffect(x: -1.0, y: 1.0, anchor: .center)
                .padding(.horizontal, 10)
                .scrollIndicators(.hidden)
                sendMessageView
            }
            .background(
                Image("ChatBackground")
            )
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .toolbar(.hidden, for: .navigationBar)
            
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
        .onAppear{
            viewModel.pageNumber = 1
            viewModel.getChatHistory()
            viewModel.VideoCallData()
            viewModel.disconnect()
            viewModel.connect()
            viewModel.receiveMessage { msgData, str in
                self.viewModel.messageList = [msgData] + self.viewModel.messageList
            }
            NotificationCenter.default.addObserver(forName: .showInboxScreen, object: nil, queue: nil,
                                                 using: self.setChatScreen)
        }
        .onDisappear(perform: {
            viewModel.selectedChat?.videoCallId = ""
            viewModel.isPresented = false
            viewModel.disconnect()
        })
        .modifier(DismissingKeyboard())
    }
    
    private func setChatScreen(_ notification: Notification){
        router.dismissScreenStack()
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
        .background(.white)
        .padding(.horizontal,25)
        .padding(.top,10)
        
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
                    .padding(.vertical, 10)
                    .foregroundStyle(.gray)
                    .font(.custom(FontContent.plusRegular, size: 20))
                    .frame(minHeight: 44)
                
                
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
                .padding(.trailing, 10)
                
            }
            .overlay(
                RoundedRectangle(cornerRadius: 18)
                    .inset(by: 1)
                    .stroke(.E_5_E_5_EA, lineWidth: 1)
            )
            
        }
        .padding(.horizontal, 20)
        .padding(.top, 10)
        .background(.white)
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
}

#Preview {
    ChatView()
}
