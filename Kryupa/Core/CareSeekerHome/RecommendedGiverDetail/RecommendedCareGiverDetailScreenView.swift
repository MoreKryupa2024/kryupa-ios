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
    @Namespace private var namespace
    @StateObject var viewModel = RecommendedCareGiverDetailScreenViewModel()
    
    var body: some View {
        ZStack{
            VStack(spacing:0){
             HeaderView
                ScrollView{
                    ProfileView
                    SegmentView
                    if viewModel.selection == "Summary"{
                        Text("Lorem ipsum dolor sit amet consectetur. Convallis a lobortis lectus augue cursus in diam. Vitae non egestas sed nulla sem cras ut. Arcu tellus erat duis integer vitae orci. Faucibus lacus id enim lorem sit. Commodo sed neque neque montes ridiculus.\n\nAdipiscing laoreet volutpat dolor volutpat tempor facilisis. Diam gravida gravida consequat ligula nunc donec semper. A orci enim bibendum lobortis aliquam amet nulla facilisis neque.\n\nEu nisi donec lacinia mi netus. Odio egestas gravida at quis. Faucibus nibh sit.")
                            .font(.custom(FontContent.plusRegular, size: 12))
                            .foregroundStyle(._444446)
                            .padding(.horizontal,24)
                            .padding(.top,15)
                    }else{
                        ReviewListView()
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
        .onAppear{
            viewModel.getCareGiverDetails(giverId: careGiverDetail?.id ?? "")
        }
    }
    
    private var ReViewList:some View{
        ForEach(1...5){ index in
            
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
                .padding(.top,23)
                .padding(.bottom,15)
            
            
            RoundedRectangle(cornerRadius: 69)
                .stroke(lineWidth: 1)
                .foregroundStyle(.E_5_E_5_EA)
                .overlay(content: {
                    Image("profile")
                        .resizable()
                        .frame(width: 126,height: 126)
                        .clipShape(.rect(cornerRadius: 63))
                })
                .foregroundStyle(.white)
                .frame(width: 138,height: 138)
            
            VStack(alignment:.center, spacing:5){
                Text(viewModel.giverDetail?.name ?? "")
                    .font(.custom(FontContent.besMedium, size: 20))
                
                Text(viewModel.giverDetail?.yearOfExperience ?? "")
                    .font(.custom(FontContent.plusRegular, size: 12))
                    .foregroundStyle(._444446)
                Text("$252")
                    .font(.custom(FontContent.plusRegular, size: 12))
                    .foregroundStyle(._444446)
                HStack{
                    Image(systemName: "star.fill")
                        .resizable()
                        .frame(width: 12,height: 12)
                    
                    Text("(100)")
                        .font(.custom(FontContent.plusRegular, size: 11))
                        .foregroundStyle(._444446)
                }
            }
            .padding(.top,10)
            
            HStack(spacing:0){
                Text("Languages:")
                    .font(.custom(FontContent.plusMedium, size: 12))
                
                Text(" English, Korean, Hindi, Germany")
                    .font(.custom(FontContent.plusRegular, size: 12))
            }
            .padding(.vertical,30)
         
            MessageButton
                .asButton(.press){
                    router.showScreen(.push) { route in
                        ChatView()
                    }
                }
        }
    }
    
    private var MessageButton: some View {
        HStack{
            Text("Message")
                .font(.custom(FontContent.plusMedium, size: 16))
                .padding(.vertical, 8)
                .padding(.horizontal, 20)
        }
        .background(
            ZStack{
                Capsule(style: .circular)
                    .fill(.appMain)
            }
        )
        .foregroundColor(.white)
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
    RecommendedCareGiverDetailScreenView()
}
