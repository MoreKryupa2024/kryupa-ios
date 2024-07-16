//
//  InboxScreenView.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 14/06/24.
//

import SwiftUI
import SwiftfulUI

struct InboxScreenView: View {
    
    var arrayCount: Int = 6
    @Environment(\.router) var router
    @StateObject var viewModel = ChatScreenViewModel()
    
    var body: some View {
        ZStack{
            VStack(spacing:20){
                HeaderView(title: "Messages")
                
                ScrollView{
                    ForEach(viewModel.inboxList,id: \.id) { profileData in
                        SenderView(profile: profileData)
                            .asButton(.press) {
                                viewModel.selectedChat = profileData
                                router.showScreen(.push) { rout in
                                    ChatView(userName: profileData.name,viewModel: viewModel)
                                }
                            }
                            SepratorView
                    }
                }
                .scrollIndicators(.hidden)
            }
            
            if viewModel.isLoading{
                LoadingView()
            }
        }
        .toolbar(.hidden, for: .navigationBar)
        .onAppear{
            viewModel.getInboxList()
        }
    }
    
    private var SepratorView: some View{
        Rectangle()
            .frame(height: 1)
            .foregroundStyle(.F_2_F_2_F_7)
            .padding(.vertical,7)
            .padding(.horizontal,24)
        
    }
    
    private func SenderView(profile:ChatListData)-> some View{
        HStack(spacing:0){
            
            ImageLoadingView(imageURL: profile.profilePictureURL)
                .clipShape(Circle())
                .frame(width: 45,height: 45)
            
            VStack(alignment:.leading, spacing:0){
                Text(profile.name)
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .font(.custom(FontContent.plusRegular, size: 16))
                
                Text("New Service Request!")
                    .font(.custom(FontContent.plusRegular, size: 13))
                    .foregroundStyle(._7_C_7_C_80)
                
            }
            .frame(maxWidth: .infinity)
            .padding(.leading,12)
            
            Text("9:41 AM")
                .font(.custom(FontContent.plusRegular, size: 13))
                .padding(.top,10)
                .frame(maxHeight: .infinity,alignment: .top)
                .foregroundStyle(._7_C_7_C_80)
            
            Image("chevron-right")
                .resizable()
                .frame(width:17,height: 17)
                .padding(.top,11.5)
                .padding(.leading,11)
                .frame(maxHeight: .infinity,alignment: .top)
            
        }
        .padding(.vertical,9)
        .padding(.horizontal,24)
        
    }
    
}

#Preview {
    InboxScreenView()
}
