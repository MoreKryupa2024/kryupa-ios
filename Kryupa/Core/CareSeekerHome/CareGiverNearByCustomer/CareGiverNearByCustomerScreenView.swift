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
            VStack(spacing:0){
                HeaderView
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
                presentAlert(title: "Kryupa", subTitle: alertStr)
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
                    
//                        .onAppear{
//                            if (viewModel.careGiverNearByList.count - 1) == index && viewModel.pagination{
//                                viewModel.pageNumber += 1
//                                viewModel.getCareGiverNearByList(bookingID: bookingID) { alertStr in
//                                    presentAlert(title: "Kryupa", subTitle: alertStr)
//                                }
//                            }
//                        }
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
//                Image("NotificationBellIcon")
//                    .frame(width: 25,height: 25)
            }
            .padding(.horizontal,24)
        }
    }
}

#Preview {
    CareGiverNearByCustomerScreenView()
}
