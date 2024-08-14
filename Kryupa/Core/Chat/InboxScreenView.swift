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
    @StateObject var viewModel = InboxScreenViewModel()
    
    var body: some View {
        ZStack{
            VStack(spacing:20){
                HeaderView(title: "Messages")
                
                ScrollView{
                    ForEach(Array(viewModel.inboxList.enumerated()),id: \.element.id) { (index,profileData) in
                        SenderView(profile: profileData)
                            .asButton(.press) {
                                let viewModelChat = ChatScreenViewModel()
                                viewModelChat.selectedChat = profileData
                                router.showScreen(.push) { rout in
                                    ChatView(userName: profileData.name,viewModel: viewModelChat)
                                }
                            }
//                            .onAppear{
//                                if ((viewModel.inboxList.count-1) == index) && viewModel.pagination{
//                                    viewModel.pageNumber += 1
//                                    viewModel.getInboxList()
//                                }
//                            }
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
                    .lineLimit(1)
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .font(.custom(FontContent.plusRegular, size: 16))
                
                Text(profile.lastMessage)
                    .font(.custom(FontContent.plusRegular, size: 13))
                    .foregroundStyle(._7_C_7_C_80)
                
            }
            .frame(maxWidth: .infinity)
            .padding(.leading,12)
//            Text(\((profile.lastActionAt.components(separatedBy: " ").first ?? "").convertDateFormater(beforeFormat: "yyyy-MM-dd", afterFormat: "dd-MM"))
                 Text("\((profile.lastActionAt.components(separatedBy: " ").last ?? "").convertDateFormater(beforeFormat: "HH:mm:ss.SSS", afterFormat: "h:mm a"))")
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
