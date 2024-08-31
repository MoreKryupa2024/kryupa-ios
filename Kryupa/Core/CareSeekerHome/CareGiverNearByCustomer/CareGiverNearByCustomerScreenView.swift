//
//  CareGiverNearByCustomerScreenView.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 04/06/24.
//

import SwiftUI
import SwiftfulUI

struct CareGiverNearByCustomerScreenView: View {
    @Environment(\.router) var router
    
    var bookingID: String = "90279ed1-9347-4e3d-a9ae-49e69b6c143b"//String()
    
    @StateObject var viewModel = CareGiverNearByCustomerScreenViewModel()
    
    var body: some View {
        ZStack{
            VStack(spacing:15){
                HeaderView(showBackButton: true)
                ScrollView{
                    if viewModel.isloading{
                        FindingView
                    }else{
                        CaregiverNearYouView
                    }
                }
                .scrollIndicators(.hidden)
            }
        }
        .modifier(DismissingKeyboard())
        .toolbar(.hidden, for: .navigationBar)
        .task {
            viewModel.pageNumber = 1
            viewModel.getCareGiverNearByList(bookingID: bookingID) { alertStr in
//                presentAlert(title: "Kryupa", subTitle: alertStr)
            }
        }
    }
    
    private var CaregiverNearYouView: some View{
        VStack(spacing:0){
            Text("Caregiver Near You")
                .font(.custom(FontContent.besMedium, size: 20))
                .padding(.top,21)
            
            SearchView
            
            VStack(spacing:0){
                
                if viewModel.careGiverNearByList.count == 0 {
                        Image("NearyouEmpty")
                            .resizable()
                            .aspectRatio(283/225, contentMode: .fit)
                            .padding(.horizontal,40)
                            .padding(.top,130)
                            .padding(.bottom,30)
                        Text("Oops! Seems Like All Caregivers\nAre Currently Occupied")
                        .multilineTextAlignment(.center)
                }else{
                    ForEach(Array(viewModel.careGiverNearByList.enumerated()),id: \.element.id){ (index,giver) in
                        BookingCareGiverListView(careGiverNear: giver)
                            .padding(.top,15)
                            .asButton(.press) {
                                let RecommendedCareGiverDetailScreenViewModel = RecommendedCareGiverDetailScreenViewModel()
                                RecommendedCareGiverDetailScreenViewModel.isNormalBooking = true
                                router.showScreen(.push) { rout in
                                    RecommendedCareGiverDetailScreenView(careGiverDetail: giver,bookingID: self.bookingID,viewModel: RecommendedCareGiverDetailScreenViewModel)
                                }
                            }
                    }
                }
            }
            .padding(.vertical,30)
            .padding(.horizontal,24)
        }
    }
    
    
    private var SearchView: some View{
        HStack(spacing:12){
            Image("searchIcon")
                .padding(.leading,8)
            TextField("Search Caregiver", text: $viewModel.serachGiver)
                .onChange(of: viewModel.serachGiver) {
                    viewModel.getCareGiverNearByList(bookingID: bookingID, alert: nil)
                }
                .autocorrectionDisabled()
            
        }
        .background{
            RoundedRectangle(cornerRadius: 8)
                .foregroundStyle(.F_2_F_2_F_7)
                .frame(height: 36)
        }
        .padding(.horizontal,24)
        .padding(.top,30)
    }
    
    private var FindingView: some View{
        VStack(spacing:0){
            Image("finding")
                .resizable()
                .padding(.horizontal,20)
                .padding(.top,60)
                .aspectRatio(contentMode: .fill)
            
            Text("Finding caregiver near you")
                .font(.custom(FontContent.besMedium, size: 20))
                .padding(.top,50)
            
            Text("We are finding best caregivers near you!")
                .font(.custom(FontContent.plusRegular, size: 12))
        }
    }
}

#Preview {
    CareGiverNearByCustomerScreenView()
}
