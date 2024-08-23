//
//  CareSeekerHomeScreenView.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 31/05/24.
//

import SwiftUI
import SwiftfulUI

struct CareSeekerHomeScreenView: View {
    
    @Environment(\.router) var router
    @StateObject private var viewModel = CareSeekerHomeScreenViewModel()
    var showBookingsHistoryScreen = NotificationCenter.default
    
    var body: some View {
        ZStack{
            VStack(spacing:0){
                HeaderView
                ScrollView {
                    if let serviceStartData = viewModel.serviceStartData{
                        if serviceStartData.serviceStatus == "active" {
                            serviceView()
                        }
                    }else{
                        BannerView(assetsImage: ["customer home top","customer home top 2"],
                                   showIndecator: true,
                                   fromAssets: true,
                                   bannerHeight: 58)
                        .padding(.horizontal,24)
                        .padding(.top,24)
                        .asButton(.press) {
                            NotificationCenter.default.post(name: .showBookingScreen,
                                                            object: nil, userInfo: nil)
                        }
                    }
                    
                    if viewModel.upcommingAppointments.count == 0 && viewModel.pastAppointments.count == 0{
                        BookFirstServiceView
                    }
                    if viewModel.upcommingAppointments.count != 0{
                        UpcomingAppointmentsView
                            .padding(.top,30)
                    }
                    if viewModel.pastAppointments.count != 0{
                        PastAppointmentsView
                            .padding(.top,30)
                    }
                    if viewModel.recommendedCaregiver.count != 0{
                        RecommendedGiverView
                            .padding(.top,30)
                    }
                }
                .scrollIndicators(.hidden)
                .toolbar(.hidden, for: .navigationBar)
            }
            if viewModel.isloading{
                LoadingView()
            }
            
        }
        .onAppear{
            viewModel.getBannerTopData(screenName: AppConstants.CUSTOMERHOMETOPScreenBanner)
            viewModel.pageNumber = 1
            viewModel.getRecommandationList()
            viewModel.customerSvcAct()
//            viewModel.getBannerBottomData(screenName: AppConstants.CUSTOMERHOMEBOTTOMScreenBanner)
        }
    }
    
    private func serviceView()-> some View{
        
        return ZStack(alignment:.top){
            VStack {
                Image("customer home top 1")
                    .resizable()
                    .frame(height: 59)
                    .asButton(.press) {
                        viewModel.customerConfirmStartService()
                    }
            }
            .frame(maxWidth: .infinity)
        }
        .padding(.horizontal,25)
        .padding(.vertical,25)
    }
    
    private var RecommendedGiverView:some View{
        VStack(spacing:10){
            HStack{
                Text("Recommended Caregiver")
                    .font(.custom(FontContent.plusMedium, size: 15))
                    .frame(maxWidth: .infinity,alignment: .leading)
                
                    Text("See All")
                        .font(.custom(FontContent.plusRegular, size: 15))
                        .foregroundStyle(._7_C_7_C_80)
                        .asButton(.press) {
                            router.showScreen(.push) { rout in
                                RecommandedListScreenView(recommendedCaregiver: viewModel.recommendedCaregiver)
                            }
                        }
            }
            .padding(.horizontal,24)
            RecommendedCaregiverView(recommendedCaregiver: viewModel.recommendedCaregiver) { giverData in
                let RecommendedCareGiverDetailScreenViewModel = RecommendedCareGiverDetailScreenViewModel()
                RecommendedCareGiverDetailScreenViewModel.isRecommended = true
                
                let careGiverDetails = CareGiverNearByCustomerScreenData(jsonData: [
                    "id":giverData.id,
                    "profile_picture_url":giverData.profileURL,
                    "name": giverData.name])
                
                router.showScreen(.push) { rout in
                    RecommendedCareGiverDetailScreenView(careGiverDetail: careGiverDetails,viewModel: RecommendedCareGiverDetailScreenViewModel)
                }
            }
        }
    }
    
    private var UpcomingAppointmentsView:some View{
        VStack(spacing:10){
            HStack{
                Text("Upcoming Appointments")
                    .font(.custom(FontContent.plusMedium, size: 15))
                    .frame(maxWidth: .infinity,alignment: .leading)
                
                    Text("See All")
                        .font(.custom(FontContent.plusRegular, size: 15))
                        .foregroundStyle(._7_C_7_C_80)
                        .asButton(.press) {
                            let selectedIndexBookingScreenDict:[String: Int] = ["selectedIndexBookingScreen": 1]
                            showBookingsHistoryScreen.post(name: .showBookingsHistoryScreen, object: nil, userInfo: selectedIndexBookingScreenDict)
                        }
            }
            .padding(.horizontal,24)
            AppointmentsView(appointmentList: viewModel.upcommingAppointments) { data in
                let viewModelReview = ServiceDetailScreenViewModel()
                viewModelReview.bookingsListData = data
                router.showScreen(.push) { rout in
                    ServiceDetailScreenView(viewModel:viewModelReview)
                }
            }
        }
    }
    
    private var PastAppointmentsView:some View{
        VStack(spacing:10){
            HStack{
                Text("Past Appointments")
                    .font(.custom(FontContent.plusMedium, size: 15))
                    .frame(maxWidth: .infinity,alignment: .leading)
                
                    Text("See All")
                        .font(.custom(FontContent.plusRegular, size: 15))
                        .foregroundStyle(._7_C_7_C_80)
                        .asButton(.press) {
                            let selectedIndexBookingScreenDict:[String: Int] = ["selectedIndexBookingScreen": 2]
                            showBookingsHistoryScreen.post(name: .showBookingsHistoryScreen, object: nil, userInfo: selectedIndexBookingScreenDict)
                        }
            }
            .padding(.horizontal,24)
            AppointmentsView(appointmentList: viewModel.pastAppointments) { data in
                let viewModelReview = ReviewsViewModel()
                viewModelReview.bookingsListData = data
                router.showScreen(.push) { rout in
                    GiveReviewView(viewModel:viewModelReview)
                }
            }
        }
    }
    
    private var BookFirstServiceView: some View{
        VStack(spacing:0){
            Image("bookingFirstIcone")
                .resizable()
                .scaledToFit()
                .padding(.horizontal,80)
                .padding(.top,30)
            
            Text("Your Booking list Looks Empty")
                .padding(.top,10)
            
            Text("Book A Service")
                .foregroundStyle(.white)
                .padding(.horizontal,20)
                .padding(.vertical,8)
                .background{
                    RoundedRectangle(cornerRadius: 16)
                }
                .padding(.top,5)
                .asButton(.press) {
                    NotificationCenter.default.post(name: .showBookingScreen,
                                                                    object: nil, userInfo: nil)
                }
        }
    }
    
    private var HeaderView: some View{
        ZStack{
            Image("KryupaLobby")
                .resizable()
                .frame(width: 124,height: 20)
            
            HStack{
                Spacer()
                Image("NotificationBellIcon")
                    .frame(width: 25,height: 25)
            }
            .padding(.horizontal,24)
        }
    }
}

#Preview {
    CareSeekerHomeScreenView()
}
