//
//  FAQView.swift
//  Kryupa
//
//  Created by Pooja Nenava on 13/06/24.
//

import SwiftUI
import SwiftfulUI

struct FAQView: View {
   @StateObject var viewModel = FAQViewModel()
    
    var body: some View {
        ZStack{
            VStack {
                HeaderView(showBackButton: true) {
                    viewModel.disconnect()
                }
                SegmentView
                
                if viewModel.selectedSection == 0 {
                    ScrollView {
                        VStack(spacing: 15) {
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
                        VStack(spacing: 20){
                            if let faqModelData = viewModel.faqModelData{
                                ForEach(faqModelData.allConversation.reversed(), id:\.id) { data in
                                    FAQChatView(conversationData: data,senderId: faqModelData.userId)
                                        .rotationEffect(Angle(degrees: 180)).scaleEffect(x: -1.0, y: 1.0, anchor: .center)
//                                        .onAppear{
//                                            if (faqModelData.allConversation.count - 1) == index && viewModel.pagination{
//                                                viewModel.pageNumber += 1
//                                                viewModel.conversationWithAdmin()
//                                            }
//                                        }
                                 }
                            }
                        }
                    }
                    .rotationEffect(Angle(degrees: 180)).scaleEffect(x: -1.0, y: 1.0, anchor: .center)
                    .padding(.horizontal, 10)
                    .scrollIndicators(.hidden)
                    
                    sendMessageView
                }
            }
            .toolbar(.hidden, for: .navigationBar)
            .task{
                viewModel.pageNumber = 1
                viewModel.conversationWithAdmin()
                viewModel.receiveMessage()
            }
            
            if viewModel.isLoading{
                LoadingView()
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
                TextField("Hello!", text:$viewModel.sendMsgText, axis: .vertical)
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
                            let text = viewModel.sendMsgText.trimmingCharacters(in: .whitespaces)
                            if !text.isEmpty{
                                viewModel.sendMessage(text)
                            }
                            viewModel.sendMsgText = ""
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
        
        Picker("Help", selection: $viewModel.selectedSection) {
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
        .onChange(of: viewModel.selectedSection) { oldValue, newValue in
            if viewModel.selectedSection == 1{
                viewModel.connect()
            }else{
                viewModel.disconnect()
            }
            
        }
    }
}

#Preview {
    FAQView()
}
