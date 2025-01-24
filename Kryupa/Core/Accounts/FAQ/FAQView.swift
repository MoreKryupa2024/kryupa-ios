//
//  FAQView.swift
//  Kryupa
//
//  Created by Pooja Nenava on 13/06/24.
//

import SwiftUI
import SwiftfulUI
import IQKeyboardManagerSwift
import Combine

struct FAQView: View {
   @StateObject var viewModel = FAQViewModel()
    @State private var keyboardHeight: CGFloat = 0
    
    var body: some View {
        ZStack{
            VStack(spacing:0){
                HeaderView(showBackButton: true) {
                    viewModel.disconnect()
                }
                .background(.white)
                
                SegmentView
                    .background(.white)
                
                if viewModel.selectedSection == 0 {
                    ScrollView {
                        VStack(spacing: 15) {
                            ForEach(viewModel.faq,id: \.title) {
                                msg in
                                FAQExpandView(data: msg)
                            }
                        }
                        .padding(.top, 20)
                    }
                    .scrollIndicators(.hidden)
                    Spacer()
                }
                else {
                    ScrollViewReader { value in
                        ScrollView {
                            VStack(spacing: 20){
                                if let faqModelData = viewModel.faqModelData{
                                    ForEach(faqModelData.allConversation.reversed(), id:\.id) { data in
                                        FAQChatView(conversationData: data,senderId: faqModelData.userId)
                                            .id(data.id)
                                            .rotationEffect(Angle(degrees: 180)).scaleEffect(x: -1.0, y: 1.0, anchor: .center)
                                    }
                                }
                            }
                            .rotationEffect(Angle(degrees: 180)).scaleEffect(x: -1.0, y: 1.0, anchor: .center)
                        }
//                        .defaultScrollAnchor(.bottom)
                        .padding(.horizontal, 10)
                        .scrollIndicators(.hidden)
                        .onChange(of: viewModel.faqModelData?.allConversation.count) { _,_ in
                            value.scrollTo(viewModel.faqModelData?.allConversation.last?.id)
                        }
                    }
                    
                    sendMessageView
                        .padding(.top,15)
                        .background(.white)
                        .padding(.bottom, keyboardHeight == 0 ? 0 : (keyboardHeight-32))
                        .onReceive(Publishers.keyboardHeight) { self.keyboardHeight = $0 }
                        .animation(.easeInOut, value: 0.6)
                }
            }
            .background(
                Image("ChatBackground").opacity(viewModel.selectedSection == 1 ? 1 : 0)
            )
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .toolbar(.hidden, for: .navigationBar)
            .modifier(DismissingKeyboard())
            .task{
                viewModel.pageNumber = 1
                viewModel.conversationWithAdmin()
                viewModel.receiveMessage()
            }
            if viewModel.isLoading{
                LoadingView()
            }
        }
        .task{
            IQKeyboardManager.shared.enable = false
        }
        .onDisappear(perform: {
            IQKeyboardManager.shared.enable = true
        })
    }
    
    private var sendMessageView: some View{
        
        return HStack {
            
            HStack {
                TextField("Hello!", text:$viewModel.sendMsgText, axis: .vertical)
                    .lineLimit(3)
                    .padding(.leading, 15)
                    .padding(.vertical, 4)
                    .foregroundStyle(.gray)
                    .font(.custom(FontContent.plusRegular, size: 17))
                    .frame(minHeight: 36)
                
                
                HStack(spacing:5) {
                    
                    Image("sendbutton")
                        .dynamicTypeSize(.medium)
                        .frame(width: 28,height: 28)
                        .asButton(.press) {
                            viewModel.sendMsgText = viewModel.sendMsgText.removingWhitespaces()
                            let text = viewModel.sendMsgText.removingWhitespaces()
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
        .padding(.top, 30)
        .onChange(of: viewModel.selectedSection) { oldValue, newValue in
            keyboardHeight = 0
            if viewModel.selectedSection == 1{
                viewModel.disconnect()
                viewModel.connect()
                viewModel.receiveMessage()
            }else{
                viewModel.disconnect()
            }
        }
    }
}

#Preview {
    FAQView()
}
