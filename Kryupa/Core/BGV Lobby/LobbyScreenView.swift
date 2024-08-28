//
//  LobbyScreenView.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 28/05/24.
//

import SwiftUI
import SwiftfulUI
import ZoomVideoSDKUIToolkit

struct LobbyScreenView: View {
    @Environment(\.router) var router
    
    @State var isPresented = false
    @StateObject private var viewModel = LobbyScreenViewModel()
    
    var body: some View {
        
        ZStack{
            VStack(spacing:0) {
                HeaderView
                ScrollView {
                    ScheduleInterview
                    ReferView
                        .asButton(.press) {
                            router.showScreen(.push) { _ in
                                ReferAndEarnScreenView()
                            }
                        }
                    VerificationStatus
                        .padding(.horizontal,24)
                        .padding(.vertical,20)
                    BannerContentView
                }
            }
            if isPresented {
                ZoomScreenView(
                    jwt:viewModel.meetingTokenData?.sessionToken ?? "" ,
                    sessionName: viewModel.meetingTokenData?.topic ?? "",
                    sessionPassword:viewModel.meetingTokenData?.sessionKey ?? "",
                    username: viewModel.meetingTokenData?.userIdentity ?? ""
                ) { error in
                    print("error :- \(error.description)")
                    isPresented = false
                } onViewLoadedAction: {
                    print("loaded")
                } onViewDismissedAction: {
                    isPresented = false
                }
            }
            
            if viewModel.isloading{
                LoadingView()
            }
        }
        .scrollIndicators(.hidden)
        .toolbar(.hidden, for: .navigationBar)
        .onAppear(perform: {
            viewModel.getLobbyStatus()
//            viewModel.getBannerData(screenName: AppConstants.lobbyScreenBanner)
        })
    }
    
    private var BannerContentView: some View{
        VStack(alignment:.leading,spacing:10){
            Text("Feedback & Reviews")
                .font(.custom(FontContent.plusRegular, size: 13))
            
            BannerView(assetsImage: ["caregiver lobby","caregiver lobby 1", "caregiver lobby 2", "caregiver lobby 3"],
                       showIndecator: true,
                       fromAssets: true,
                       aspectRatio: 327/193)
        }
        .padding(.horizontal,24)
        .padding(.top,25)
    }
    private var sepratorView: some View{
        Image("referSepratorView")
            .frame(width: 2,height: 22)
            .padding(.leading,8)
    }
    
    private var VerificationStatus: some View{
        
        VStack(alignment:.leading,spacing:10){
            Text("Background Verification Status")
                .font(.custom(FontContent.plusRegular, size: 13))
            
            ZStack{
                
                VStack(alignment: .leading,spacing:0){
                    HStack(spacing:9){
                        RoundedRectangle(cornerRadius: 9)
                            .stroke(lineWidth: 1)
                            .frame(width: 18,height: 18)
                            .overlay {
                                Text("1")
                                    .font(.custom(FontContent.plusMedium, size: 12))
                            }

                        Text("Submitted your SSN to provider")
                            .font(.custom(FontContent.plusRegular, size: 12))
                    }
                    sepratorView
                    HStack(spacing:9){
                        Image("VerificationStatusIcon")
                        Text("Schedule & Complete Interview")
                            .font(.custom(FontContent.plusRegular, size: 12))
                            .foregroundColor(._7_C_7_C_80)
                    }
                    sepratorView
                    HStack(spacing:9){
                        Image("VerificationStatusIcon")
                        Text("Background check reviewed & completed")
                            .font(.custom(FontContent.plusRegular, size: 12))
                            .foregroundColor(._7_C_7_C_80)
                    }
                }
                .frame(maxWidth: .infinity,alignment: .leading)
                .padding([.vertical,.horizontal],20)
                
            }
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 1.0)
                    .foregroundColor(.E_5_E_5_EA)
            }
        }
    }
    
    private var HeaderView: some View{
        ZStack{
            Image("KryupaLobby")
                .resizable()
                .frame(width: 124,height: 20)
            
            HStack{
                Image("logout")
                    .resizable()
                    .frame(width: 25,height: 25)
                    .asButton(.press) {
                        
                        let primaryAction = UIAlertAction(title: "OK", style: .default) { action in
                            let domain = Bundle.main.bundleIdentifier!
                            UserDefaults.standard.removePersistentDomain(forName: domain)
                            UserDefaults.standard.synchronize()
                            NotificationCenter.default.post(name: .logout,
                                                            object: nil, userInfo: nil)
                        }
                        
                        let secondaryAction = UIAlertAction(title: "Cancel", style: .cancel)
                        
                        presentAlert(title: "Kryupa", subTitle: "Logout",primaryAction: primaryAction,secondaryAction: secondaryAction)
                    }
                Spacer()
//                Image("NotificationBellIcon")
//                    .frame(width: 25,height: 25)
            }
            .padding(.horizontal,24)
        }
    }
    
    private var ScheduleInterview: some View{
        HStack{
            VStack(alignment:.leading, spacing:5){
                
                Text(viewModel.slotTitle)
                    .font(.custom(FontContent.besMedium, size: 16))
                    .foregroundStyle(.appMain)
                
                Text(viewModel.slotTime)
                    .font(.custom(FontContent.plusRegular, size: 11))
                    .foregroundStyle(._7_C_7_C_80)
                
                Text(viewModel.slotButton)
                    .font(.custom(FontContent.plusMedium, size: 11))
                    .foregroundStyle(.white)
                    .padding(.vertical,8)
                    .padding(.horizontal,20)
                    .background(Capsule())
                    .asButton(.press) {
                        if viewModel.slotButton == "Join Now"{
                            viewModel.getMeetingToken { strError in
                                presentAlert(title: "Kryupa", subTitle: strError)
                            } next: {
                                isPresented = true
                            }

                        }else{
                            router.showScreen(.push) { router in
                                BGVTimeSlotScreenView()
                            }
                        }
                    }
            }
            Spacer()
            Image("ScheduleCalender")
                .resizable()
                .frame(width: 121,height: 110)
                .padding(.vertical,5)
                .padding(.trailing,18)
                
        }
        .padding(.vertical,10.5)
        .padding(.leading,17)
        .frame(maxWidth: .infinity)
        .background{
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.F_2_F_2_F_7)
        }
        .padding(.top,16)
        .padding(.horizontal,24)
        
    }
    
    private var ReferView: some View{
        HStack{
            VStack(alignment:.leading, spacing:5){
                HStack(spacing:2){
                    Text("Win Upto")
                    Text("$5")
                        .strikethrough()
                    Text("$25")
                }
                .font(.custom(FontContent.plusRegular, size: 20))
                .foregroundStyle(.appMain)
                
                Text("Refer your friends & families to Kryupa")
                    .font(.custom(FontContent.plusLight, size: 11))
                    .foregroundStyle(._7_C_7_C_80)
            }
            Spacer()
            VStack(alignment:.center, spacing:-5){
                Text("$25")
                    .font(.custom(FontContent.besSemiBold, size: 28))
                Text("03/10")
                    .font(.custom(FontContent.plusRegular, size: 11))
            }
                .font(.custom(FontContent.plusMedium, size: 11))
                .foregroundStyle(.white)
                .padding(.bottom,5)
                .padding(.horizontal,14)
                .background(.appMain)
                .cornerRadius(10)
        }
        .padding(.vertical,9)
        .padding([.leading,.trailing],13)
        .frame(maxWidth: .infinity)
        .background{
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.F_2_F_2_F_7)
        }
        .padding(.top,16)
        .padding(.horizontal,24)
        
    }
}

#Preview {
    LobbyScreenView()
}
