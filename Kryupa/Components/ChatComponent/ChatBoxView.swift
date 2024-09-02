//
//  ChatBoxView.swift
//  Kryupa
//
//  Created by Pooja Nenava on 06/06/24.
//

import SwiftUI

struct ChatBoxView: View {
    
    var msgData: MessageData?
    var selectedChat: ChatListData?
    var onSelectedValue: ((SpecialMessageData)->Void)? = nil
    var onPaySelectedValue: ((SpecialMessageData)->Void)? = nil
    
    var body: some View {
        if let msgData {
            
            if Defaults().userType == AppConstants.GiveCare && selectedChat?.giverId == msgData.sender{
                
                if msgData.isActionBtn{
//                    senderUserViewService(message: msgData.message)
                }else{
                    senderMsg(msg: msgData.message)
                }
            }else if Defaults().userType == AppConstants.SeekCare && selectedChat?.seekerId == msgData.sender{
                if msgData.isActionBtn{
                    senderUserViewService(message: msgData.message)
                }else{
                    senderMsg(msg: msgData.message)
                }
            }else{
                if msgData.isActionBtn{
                    let SpecialMessageData = SpecialMessageData(jsonData: (msgData.message.toJSON() as? [String : Any] ?? [String : Any]()))
                    if SpecialMessageData.type == "view_service"{
//                        otherUserViewService(message: SpecialMessageData)
                    }else if SpecialMessageData.type == "pay_now"{
                        otherUserViewService(message: SpecialMessageData)
                    }
                }else{
                    reciverMsg(msg: msgData.message)
                }
            }
        }else{
            EmptyView()
        }
    }
    
    func otherUserViewService(message:SpecialMessageData)-> some View{
        
        return HStack {
            VStack(alignment: .leading) {
                Text(message.content)
                    .font(.custom(FontContent.plusRegular, size: 13))
                    .foregroundStyle(.appMain)
                    .padding(.horizontal, 20)
                Text(message.btnTitle)
                    .font(.custom(FontContent.plusRegular, size: 16))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background{
                        RoundedRectangle(cornerRadius: 24)
                    }
                    .padding(.horizontal, 20)
                    .asButton(.press) {
                        
                        if message.type == "view_service"{
                            onSelectedValue?(message)
                        }else if message.type == "pay_now"{
                            onPaySelectedValue?(message)
                        }else{
                            presentAlert(title: "Kryupa", subTitle: "This Feature Coming Soon!")
                        }
                    }
            }
            
            .padding(.vertical, 15)
            .background {
                ZStack(alignment:.topLeading){
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundColor(.E_5_E_5_EA)
                    
                    Image("revicerIcon")
                        .resizable()
                        .frame(width: 9,height: 15)
                        .offset(x: -7,y: 12)
                }
            }
            Spacer()
            
        }
        .padding(.horizontal, 20)
    }
    
    
    func senderUserViewService(message:String)-> some View{
        
        let SpecialMessageData = SpecialMessageData(jsonData: (message.toJSON() as? [String : Any] ?? [String : Any]()))
        return HStack {
            Spacer()
            VStack(alignment: .leading) {
                Text(SpecialMessageData.content)
                    .font(.custom(FontContent.plusRegular, size: 13))
                    .foregroundStyle(Color.white)
                    .padding(.horizontal, 20)
                
                /*Text(SpecialMessageData.btnTitle)
                    .font(.custom(FontContent.plusRegular, size: 16))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background{
                        RoundedRectangle(cornerRadius: 24)
                    }
                    .padding(.horizontal, 20)
                    .asButton(.press) {
                        if SpecialMessageData.type == "view_service"{
                            onSelectedValue?(SpecialMessageData)
                        }else{
                            presentAlert(title: "Kryupa", subTitle: "This Feature Coming Soon!")
                        }
                    }*/
            }
            
            .padding(.vertical, 15)
            .background {
                ZStack(alignment:.topTrailing){
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundColor(.AEAEB_2)
                    
                    Image("senderIcon")
                        .resizable()
                        .frame(width: 9,height: 15)
                        .offset(x: 7,y: 12)
                }
            }
        }
        .padding(.horizontal, 20)
    }
    
    func senderMsg(msg:String)-> some View{
        HStack {
            Spacer()
            
            Text("\(msg)")
                .frame(alignment: .trailing)
                .font(.custom(FontContent.plusRegular, size: 13))
                .foregroundColor(Color.white)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background {
                    ZStack(alignment:.topTrailing){
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(.AEAEB_2)
                        
                        Image("senderIcon")
                            .resizable()
                            .frame(width: 9,height: 15)
                            .offset(x: 7,y: 12)
                    }
                }
        }
        .padding(.horizontal, 20)
    }
    
    func reciverMsg(msg: String)-> some View{
        HStack {
            Text("\(msg)")
                .font(.custom(FontContent.plusRegular, size: 13))
                .foregroundStyle(.appMain)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background {
                    ZStack(alignment:.topLeading){
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(.E_5_E_5_EA)
                        
                        Image("revicerIcon")
                            .resizable()
                            .frame(width: 9,height: 15)
                            .offset(x: -7,y: 12)
                    }
                }
            
            Spacer()
            
        }
        .padding(.horizontal, 20)
    }
}


#Preview {
    ChatBoxView(msgData: MessageData(jsonData: [
        "id": "a3e0f943-3abc-4a29-b3bb-cecd63ce591a",
        "contact_list_id": "a0a0174f-2352-48ca-bd77-ed7db7aaf325",
        "sender": "9ef06372-9292-439f-aff3-5648cf6fc54a",
        "recipient": "b63914e3-a02a-4956-8b01-8cbcd13f5a3e",
        "message": "hi",
        "status": "delivered",
        "created_at": "2024-07-11 14:28:26.549131",
        "updated_at": "2024-07-11 14:28:26.549131",
        "is_action_btn": false
    ]))
}
