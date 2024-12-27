//
//  FAQChatView.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 02/08/24.
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
        VStack(spacing:-5){
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
            Text("\((conversationData.createdAt.components(separatedBy: " ").first ?? "").convertDateFormaterTimeZone(beforeFormat: "yyyy-MM-dd", afterFormat: "MMM d")), \((conversationData.createdAt.components(separatedBy: " ").last ?? "").convertDateFormaterTimeZone(beforeFormat: "HH:mm:ss.SSS", afterFormat: "h:mm a"))")
           .font(.custom(FontContent.plusRegular, size: 13))
           .padding(.top,10)
           .frame(maxWidth:.infinity,alignment: .trailing)
           .foregroundStyle(._7_C_7_C_80)
           .padding(.horizontal, 7)
        }
        .padding(.horizontal, 20)
    }
    
    func reciverMsg(msg: String)-> some View{
        VStack(spacing:-5){
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
            
            Text("\((conversationData.createdAt.components(separatedBy: " ").first ?? "").convertDateFormaterTimeZone(beforeFormat: "yyyy-MM-dd", afterFormat: "MMM d")), \((conversationData.createdAt.components(separatedBy: " ").last ?? "").convertDateFormaterTimeZone(beforeFormat: "HH:mm:ss.SSS", afterFormat: "h:mm a"))")
                .font(.custom(FontContent.plusRegular, size: 13))
                .padding(.top,10)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(._7_C_7_C_80)
                .padding(.horizontal, 7)
        }
    }
}
