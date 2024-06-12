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
                    
                    BookFirstServiceView
                    
                    UpcomingAppointmentsView
                        .padding(.top,30)
                    
                    PastAppointmentsView
                        .padding(.top,30)
                    
                    RecommendedGiverView
                        .padding(.top,30)
                        
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
            AppointmentsView()
            
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
            AppointmentsView()
            
        }
    }
    
    private var BookFirstServiceView: some View{
        VStack(spacing:0){
            Image("bookingFirstIcone")
                .resizable()
                .frame(width: 180,height: 147)
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
                    router.showScreen(.push) { router in
                        BookingFormScreenView()
                    }
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
                    .asButton {
                        
                        let primaryAction = UIAlertAction(title: "OK", style: .default) { action in
                            let domain = Bundle.main.bundleIdentifier!
                            UserDefaults.standard.removePersistentDomain(forName: domain)
                            UserDefaults.standard.synchronize()
                            NotificationCenter.default.post(name: .logout,
                                                                            object: nil, userInfo: nil)
                        }
                        
                        let secondaryAction = UIAlertAction(title: "Cancel", style: .cancel)
                        
                        presentAlert(title: "Kryupa", subTitle: "Log Out",primaryAction: primaryAction,secondaryAction: secondaryAction)
                    }
            }
            .padding(.horizontal,24)
        }
    }
}

#Preview {
    CareSeekerHomeScreenView()
}
