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
    
    var body: some View {
        ZStack{
            VStack(spacing:0){
                HeaderView
                ScrollView {
                    Image("careSeekerHomeBannerSmall")
                        .resizable()
                        .frame(height: 58)
                        .padding(.horizontal,24)
                        .padding(.top,15)
                        .asButton(.press) {
                            NotificationCenter.default.post(name: .showBookingScreen,
                                                                            object: nil, userInfo: nil)
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
            viewModel.getRecommandationList()
        }
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
            }
            .padding(.horizontal,24)
            RecommendedCaregiverView(recommendedCaregiver: viewModel.recommendedCaregiver)
            
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
            }
            .padding(.horizontal,24)
            AppointmentsView(appointmentList: viewModel.upcommingAppointments)
            
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
            }
            .padding(.horizontal,24)
            AppointmentsView(appointmentList: viewModel.pastAppointments)
            
        }
    }
    
    private var BookFirstServiceView: some View{
        VStack(spacing:0){
            Image("bookingFirstIcone")
                .resizable()
                .padding(.horizontal,40)
                .aspectRatio(contentMode: .fit)
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
