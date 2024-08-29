//
//  RecommendedCareGiverDetailScreenView.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 05/06/24.
//

import SwiftUI
import SwiftfulUI

struct RecommendedCareGiverDetailScreenView: View {
    
    @Environment(\.router) var router
    
    var careGiverDetail: CareGiverNearByCustomerScreenData?
    @State var bookingID: String = String()
    @Namespace private var namespace
    @StateObject var viewModel = RecommendedCareGiverDetailScreenViewModel()
    
    var body: some View {
        ZStack{
            VStack(spacing:15){
             HeaderView
                ScrollView{
                    ProfileView
                    SegmentView
                    if viewModel.selection == "Summary"{
                        Text(viewModel.giverDetail?.bio ?? "")
                            .font(.custom(FontContent.plusRegular, size: 12))
                            .foregroundStyle(._444446)
                            .frame(maxWidth: .infinity,alignment: .leading)
                            .padding(.horizontal,24)
                            .padding(.top,15)
                    }else{
                        ReviewListView(reviewList:viewModel.giverDetail?.reviewList ?? [])
                            .padding(.horizontal,24)
                    }
                }
                .scrollIndicators(.hidden)
            }
            if viewModel.isloading{
                LoadingView()
            }
        }
        .toolbar(.hidden, for: .navigationBar)
        .task{
            viewModel.getCareGiverDetails(giverId: careGiverDetail?.id ?? "", bookingId: bookingID)
        }
    }

   private var SegmentView: some View {
        HStack(alignment: .top,spacing: 0){
            ForEach(viewModel.options,id: \.self){ option in
                VStack(spacing: 8){
                    Text(option)
                        .font(.custom(FontContent.plusRegular, size: 15))
                        .frame(maxWidth: .infinity)
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 1)
                            .frame(height: 1)
                            .foregroundStyle(._7_C_7_C_80)
                        if viewModel.selection == option{
                            RoundedRectangle(cornerRadius: 1)
                                .frame(height: 1.5)
                                .foregroundStyle(.appMain)
                                .matchedGeometryEffect(id: "selection", in: namespace)
                        }
                    }
                }
                .padding(.top,8)
                .foregroundStyle(viewModel.selection == option ? .appMain : ._7_C_7_C_80)
                .onTapGesture {
                    viewModel.selection = option
                }
            }
        }
        .padding(.horizontal,24)
        .padding(.top,31)
        .animation(.smooth, value: viewModel.selection)
    }
    
    private var ProfileView: some View{
        VStack(spacing:0){
            Text("Profile")
                .font(.custom(FontContent.besMedium, size: 20))
                .padding(.top,13)
                .padding(.bottom,15)
            
            
            RoundedRectangle(cornerRadius: 69)
                .stroke(lineWidth: 1)
                .foregroundStyle(.E_5_E_5_EA)
                .overlay(content: {
                    ImageLoadingView(imageURL: viewModel.giverDetail?.profileURL ?? "")
                        .frame(width: 126,height: 126)
                        .clipShape(.rect(cornerRadius: 63))
                        .clipped()
                })
                .foregroundStyle(.white)
                .frame(width: 138,height: 138)
            
            VStack(alignment:.center, spacing:5){
                Text(viewModel.giverDetail?.name ?? "")
                    .font(.custom(FontContent.besMedium, size: 20))
                
                Text("\(viewModel.giverDetail?.yearOfExperience ?? 0) years experienced")
                    .font(.custom(FontContent.plusRegular, size: 12))
                    .foregroundStyle(._444446)
                Text("$\(viewModel.giverDetail?.pricePerHour ?? 0)")
                    .font(.custom(FontContent.plusRegular, size: 12))
                    .foregroundStyle(._444446)
                HStack{
                    StarsView(rating: (viewModel.giverDetail?.avgRating ?? 0.0), maxRating: 5,size: 12)
                    
                    Text("(\(viewModel.giverDetail?.totalReviewer ?? 0))")
                        .font(.custom(FontContent.plusRegular, size: 11))
                        .foregroundStyle(._444446)
                }
            }
            .padding(.top,10)
            .padding(.horizontal,24)
            
            HStack(spacing:0){
                Text("Languages:")
                    .font(.custom(FontContent.plusMedium, size: 12))
                
                Text(" \(viewModel.giverDetail?.language.joined(separator: ",") ?? "")")
                    .lineLimit(1)
                    .font(.custom(FontContent.plusRegular, size: 12))
            }
            .padding([.vertical,.horizontal],30)
            
            MessageButton
                .asButton(.press){
                    viewModel.createConversation(giverId: careGiverDetail?.id ?? "", bookingId: bookingID) {
                        let chatViewModel = ChatScreenViewModel()
                        chatViewModel.selectedChat = viewModel.chatData
                        chatViewModel.isRecommended = viewModel.isRecommended
                        chatViewModel.normalBooking = viewModel.isRecommended ? false : (viewModel.giverDetail?.showBookNow ?? false)
                        chatViewModel.bookingId = bookingID
                        router.showScreen(.push) { route in
                            ChatView(userName: careGiverDetail?.name ?? "",viewModel: chatViewModel)
                        }
                    } alert: { strMsg in
                        presentAlert(title: "Kryupa", subTitle: strMsg)
                    }
                    
                }
        }
    }
    
    private var MessageButton: some View {
        
        Text("Message")
            .font(.custom(FontContent.plusMedium, size: 16))
            .foregroundStyle(.appMain)
            .padding(.horizontal,20)
            .padding(.vertical,8)
            .background{
                RoundedRectangle(cornerRadius: 16)
                    .stroke(lineWidth: 1)
            }
            .padding(.top,5)
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
                        ChatScreenViewModel.shared.disconnect()
                        router.dismissScreen()
                    }
                Spacer()
//                Image("NotificationBellIcon")
//                    .frame(width: 25,height: 25)
            }
            .padding(.horizontal,24)
        }
    }
}

#Preview {
    RecommendedCareGiverDetailScreenView()
}
