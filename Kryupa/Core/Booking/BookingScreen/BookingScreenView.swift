//
//  BookingScreenView.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 14/06/24.
//

import SwiftUI
import SwiftfulUI

struct BookingScreenView: View {
    
    @StateObject private var viewModel = BookingViewModel()
    @Environment(\.router) var router
    
    var body: some View {
        ZStack{
            VStack{
                HeaderView()
                if Defaults().userType == AppConstants.SeekCare{
                    SegmentView
                        .padding(.bottom,20)
                    SeekerBookingView
                }else{
                    GiverSegmentView
                        .padding(.bottom,20)
                    GiverBookingView
                }
            }
            if viewModel.isLoading{
                LoadingView()
            }
        }
        .onAppear{
            viewModel.getBookings()
        }
    }
    private var SeekerBookingView: some View{
        ScrollView{
            switch viewModel.selectedSection{
            case 1:
                ForEach(viewModel.bookingList,id: \.bookingID) { data in
                    BookingView(status: "Active",bookingData: data)
                        
                }
            case 2:
                ForEach(viewModel.bookingList,id: \.bookingID) { data in
                    BookingView(status: "Completed",bookingData: data)
                        .asButton(.press) {
                            let viewModelReview = ReviewsViewModel()
                            viewModelReview.bookingsListData = data
                            router.showScreen(.push) { rout in
                                GiveReviewView(viewModel:viewModelReview)
                            }
                        }
                }
            case 3:
                ForEach(viewModel.bookingList,id: \.bookingID) { data in
                    BookingView(status: "Cancelled",bookingData: data)
                }
                
            case 0:
                ForEach(viewModel.bookingList,id: \.bookingID) { data in
                    BookingView(status: "Draft",bookingData: data)
                        .asButton(.press) {
                            Defaults().bookingId = data.bookingID
                            NotificationCenter.default.post(name: .showBookingScreen,
                                                                            object: nil, userInfo: nil)
                        }
                }
                
            default:
                EmptyView()
            }
        }
        .scrollIndicators(.hidden)
    }
    
    private var GiverBookingView: some View{
        ScrollView{
            switch viewModel.selectedSection{
            case 0:
                ForEach(viewModel.bookingList,id: \.bookingID) { data in
                    BookingView(status: "Active",bookingData: data)
                }
            case 1:
                ForEach(viewModel.bookingList,id: \.bookingID) { data in
                    BookingView(status: "Completed",bookingData: data)
                        .asButton(.press) {
                            let viewModelReview = ReviewsViewModel()
                            viewModelReview.bookingsListData = data
                            router.showScreen(.push) { rout in
                                GiveReviewView(viewModel:viewModelReview)
                            }
                        }
                }
            case 2:
                ForEach(viewModel.bookingList,id: \.bookingID) { data in
                    BookingView(status: "Cancelled",bookingData: data)
                }
                
            default:
                EmptyView()
            }
        }
        .scrollIndicators(.hidden)
    }
    
    private var SegmentView: some View{
        
        Picker("Booking", selection: $viewModel.selectedSection) {
            
            Text("Draft")
                .tag(0)
                .font(.custom(FontContent.plusRegular, size: 15))
            
            Text("Active")
                .tag(1)
                .font(.custom(FontContent.plusRegular, size: 15))

            Text("Completed")
                .tag(2)
                .font(.custom(FontContent.plusRegular, size: 15))
            
            Text("Cancelled")
                .tag(3)
                .font(.custom(FontContent.plusRegular, size: 15))
        }
        .pickerStyle(.segmented)
        .padding(.horizontal, 24)
        .padding(.top, 20)
        .onChange(of: viewModel.selectedSection, { oldValue, newValue in
            viewModel.getBookings()
        })
    }
    
    private var GiverSegmentView: some View{
        
        Picker("Booking", selection: $viewModel.selectedSection) {
            
            Text("Active")
                .tag(0)
                .font(.custom(FontContent.plusRegular, size: 15))

            Text("Completed")
                .tag(1)
                .font(.custom(FontContent.plusRegular, size: 15))
            
            Text("Cancelled")
                .tag(2)
                .font(.custom(FontContent.plusRegular, size: 15))
        }
        .pickerStyle(.segmented)
        .padding(.horizontal, 24)
        .padding(.top, 20)
        .onChange(of: viewModel.selectedSection, { oldValue, newValue in
            viewModel.getBookings()
        })
    }
}

#Preview {
    BookingScreenView()
}
