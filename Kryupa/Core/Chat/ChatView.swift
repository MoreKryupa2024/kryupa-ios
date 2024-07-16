//
//  ChatView.swift
//  Kryupa
//
//  Created by Pooja Nenava on 05/06/24.
//

import SwiftUI
import Combine

struct ChatView: View {
    @Environment(\.router) var router
    @State var userName: String = ""
    @State var sendMsgText: String = ""
    
    @StateObject var viewModel = ChatScreenViewModel()
    
    var body: some View {
        ZStack{
            
            VStack(spacing:20){
                //HeaderView
                usernameView
                if viewModel.showVideoCallView{
                    videoCallView
                }
                
                ScrollView(.vertical) {
                    LazyVStack {
                        ForEach(viewModel.messageList.reversed(), id:\.id) {
                            msg in
                            
                            ChatBoxView(msgData: msg, selectedChat: viewModel.selectedChat,onSelectedValue: { SpecialMessageData in
                                router.showScreen(.push) { rout in
                                    JobDetailView(jobID: SpecialMessageData.approchId)
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
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .toolbar(.hidden, for: .navigationBar)
            .onAppear{
                viewModel.connect()
                viewModel.receiveMessage { msgData, str in
                    DispatchQueue.main.async {
                        viewModel.messageList.append(msgData)
                        print(viewModel.messageList)
                    }
                }
                viewModel.getChatHistory()
            }
            
            if viewModel.isLoading{
                LoadingView()
            }
        }
    }
    
    private var videoCallView: some View{
        
        return ZStack(alignment:.top){
            
            Image("circle-x")
                .resizable()
                .frame(width: 18,height: 18)
                .offset(x: 130,y:3)
                .asButton(.press) {
                    viewModel.showVideoCallView = false
                }
                
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
                        
                    }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical,12)
        .overlay( /// apply a rounded border
            RoundedRectangle(cornerRadius: 10)
                .stroke(.E_5_E_5_EA, lineWidth: 1)
        )
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
                                viewModel.sendMessage(text)
                                sendMsgText = ""
                            }
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
                    router.dismissScreen()
                }
            
            Text(userName)
                .font(.custom(FontContent.besRegular, size: 20))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                Image("phone-call")
                    .resizable()
                    .frame(width: 24,height: 24)
                    .asButton(.press) {
                    }
                
                Image("video")
                    .resizable()
                    .frame(width: 24,height: 24)
                    .asButton(.press) {
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
