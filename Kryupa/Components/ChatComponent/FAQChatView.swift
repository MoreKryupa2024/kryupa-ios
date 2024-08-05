//
//  FAQChatView.swift
//  Kryupa
//
//  Created by Hemant Singh Rajput on 02/08/24.
//

import SwiftUI

struct FAQChatView: View {
    
    let conversationData: AllConversationData
    var senderId = String()
    var body: some View {
        if conversationData.sender == senderId{
            senderMsg(msg: conversationData.message)
        }else{
            reciverMsg(msg: conversationData.message)
        }
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
