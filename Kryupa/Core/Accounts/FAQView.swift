//
//  FAQView.swift
//  Kryupa
//
//  Created by Pooja Nenava on 13/06/24.
//

import SwiftUI

struct FAQView: View {
    @State var selectedSection = 0
    @State private var messages = [
        Message(content: "I wanted to know how much time will it take to clear my recent payment.", chatboxType: .currentUser),
        
        Message(content: "Thankyou for reaching us! Our Agent will get back to you ASAP.", chatboxType: .otherUser),
    ]
    @State var sendMsgText: String = ""
    
    var body: some View {
        VStack {
            HeaderView()
            SegmentView
            
            if selectedSection == 0 {
                ScrollView {
                    LazyVStack(spacing: 15) {
                        ForEach(0...20) {
                            msg in
                            
                            FAQExpandView()
                        }
                    }
                    .padding(.top, 20)
                }
                .scrollIndicators(.hidden)
                
                Spacer()
            }
            else {
                ScrollView {
                    LazyVStack(spacing: 20){
                        ForEach(messages.reversed(), id:\.self) {
                            msg in
                            
                            VStack {
                                ChatBoxView(msg: msg)
                                    .rotationEffect(Angle(degrees: 180)).scaleEffect(x: -1.0, y: 1.0, anchor: .center)
                                Text("Today 9:41")
                                    .foregroundStyle(._7_C_7_C_80)
                                    .font(.custom(FontContent.plusRegular, size: 11))
                                    .rotationEffect(Angle(degrees: 180)).scaleEffect(x: -1.0, y: 1.0, anchor: .center)
                            }
                            
                        }
                    }
                }
                
                .rotationEffect(Angle(degrees: 180)).scaleEffect(x: -1.0, y: 1.0, anchor: .center)
                .padding(.horizontal, 10)
                .scrollIndicators(.hidden)
                
                
                sendMessageView
                //                .toolbar(.hidden, for: .navigationBar)
            }
        }
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
                            messages.append(Message(content: sendMsgText, chatboxType: .currentUser))
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
    
    private var SegmentView: some View{
        
        Picker("Help", selection: $selectedSection) {
            Text("FAQ")
                .tag(0)
                .font(.custom(FontContent.plusRegular, size: 12))
            
            Text("Chat With Us")
                .tag(1)
                .font(.custom(FontContent.plusRegular, size: 12))
        }
        .pickerStyle(.segmented)
        .padding(.horizontal, 24)
        .padding(.top, 20)
        
    }
}

#Preview {
    FAQView()
}
