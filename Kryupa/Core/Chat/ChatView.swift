//
//  ChatView.swift
//  Kryupa
//
//  Created by Pooja Nenava on 05/06/24.
//

import SwiftUI

struct ChatView: View {

    @Environment(\.router) var router

    var body: some View {
        VStack(spacing:20){
            HeaderView
            usernameView
            requestView
            
            ScrollViewReader { proxy in
                ScrollView {
                    ForEach(DataSource.messages, id:\.self) {
                        msg in
                        
                        ChatBoxView(msg: msg)
                    }
                }
            }
            .padding(.horizontal, 22)
            
            
            sendMessageView
        }
    }
    
    private var sendMessageView: some View{
        
        @State var yourText: String = ""


        return HStack {
            Image("camera")
                .resizable()
                .frame(width: 39,height: 29)
                .asButton(.press) {
                }
            
            HStack {
                TextField("Hello!", text: $yourText)
                    .padding()
                    .foregroundStyle(.gray)
                    .font(.custom(FontContent.plusRegular, size: 17))
                    .frame(height: 36)
                    

                Spacer()
                
                Image("audio")
                    .dynamicTypeSize(.medium)
                    .frame(width: 44,height: 44)
                    .asButton(.press) {
                    }
            }
            .overlay(
                RoundedRectangle(cornerRadius: 18)
                    .inset(by: 1)
                    .stroke(.E_5_E_5_EA, lineWidth: 1)
            )

        }
        .frame(height: 44)
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
                    .foregroundStyle(.red)
                    .frame(height: 32)
                    .frame(width: 99)
                    .asButton(.press) {
                        
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 48)
                            .inset(by: 1)
                            .stroke(.red, lineWidth: 1)
                    )
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
        
        HStack(spacing: 20) {
            
            Text("Alexa Chatterjee")
                .font(.custom(FontContent.besRegular, size: 20))
                .frame(maxWidth: .infinity, alignment: .trailing)
            
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
    ChatView()
}
