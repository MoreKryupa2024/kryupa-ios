//
//  BookingScreenView.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 14/06/24.
//

import SwiftUI
import SwiftfulUI

struct BookingScreenView: View {
    
    @StateObject var viewModel = BookingViewModel()
    @Environment(\.router) var router
    
    var body: some View {
        ZStack{
            VStack(){
                HeaderView()
                if Defaults().userType == AppConstants.SeekCare{
                    SegmentView
                        .padding(.bottom,20)
                    if viewModel.bookingList.isEmpty{
                        VStack{
                            Spacer()
                            Image("BookingEmpty")
                                .resizable()
                                .aspectRatio(283/250, contentMode: .fit)
                                .padding(.horizontal,46)
                            switch viewModel.selectedSection{
                            case 1:
                                Text("Your Active List Looks Empty")
                            case 2:
                                Text("Your Closed List Looks Empty")
                            default:
                                Text("Your Draft List Looks Empty")
                            }
                            Spacer()
                        }
                    }else{
                        SeekerBookingView
                    }
                }else{
                    GiverSegmentView
                        .padding(.bottom,20)
                    if viewModel.bookingList.isEmpty{
                        VStack{
                            Spacer()
                            Image("BookingEmpty")
                                .resizable()
                                .aspectRatio(283/250, contentMode: .fit)
                                .padding(.horizontal,46)
                            switch viewModel.selectedSection{
                            case 1:
                                Text("Your Complete List Looks Empty")
                            case 2:
                                Text("Your Cancelled List Looks Empty")
                            default:
                                Text("Your Active List Looks Empty")
                            }
                            Spacer()
                        }
                            
                        }else{
                        GiverBookingView
                    }
                }
            }
            if viewModel.isLoading{
                LoadingView()
            }
        }
        .task{
//            viewModel.pageNumber = 1
            viewModel.getBookings()
        }
    }
    private var SeekerBookingView: some View{
        ScrollView{
            switch viewModel.selectedSection{
            case 1:
                ForEach(Array(viewModel.bookingList.enumerated()),id: \.element.bookingID) { (index,data) in
                    BookingView(status: "Pending",bookingData: data,payNowAction: { data in
                        print("")
                    })
                        .asButton(.press) {
                            
                        }
                }
            case 2:
                ForEach(Array(viewModel.bookingList.enumerated()),id: \.element.bookingID) { (index,data) in
                    BookingView(status: data.status == "Job Schedule" ? "Schedule" : "Active",bookingData: data)
                        .asButton(.press) {
                            let viewModelReview = ServiceDetailScreenViewModel()
                            viewModelReview.bookingsListData = data
                            router.showScreen(.push) { rout in
                                ServiceDetailScreenView(viewModel:viewModelReview)
                            }
                        }

                }
            case 3:
                ForEach(Array(viewModel.bookingList.enumerated()),id: \.element.bookingID) { (index,data) in
                    BookingView(status: (data.status != "Job Cancelled" ? "Completed" : "Cancelled"),bookingData: data)
                        .asButton(.press) {
                            let viewModelReview = ReviewsViewModel()
                            viewModelReview.bookingsListData = data
                            router.showScreen(.push) { rout in
                                GiveReviewView(viewModel:viewModelReview)
                            }
                        }
                }
            case 0:
                ForEach(Array(viewModel.bookingList.enumerated()),id: \.element.bookingID) { (index,data) in
                    BookingView(status: "Draft",bookingData: data,deleteAction: { data in
                        
                    })
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
                ForEach(Array(viewModel.bookingList.enumerated()),id: \.element.bookingID) { (index,data) in
                    BookingView(status: data.status == "Job Schedule" ? "Schedule" : "Active",bookingData: data)
                        .asButton(.press) {
                            let viewModelReview = ServiceDetailScreenViewModel()
                            viewModelReview.bookingsListData = data
                            router.showScreen(.push) { rout in
                                ServiceDetailScreenView(viewModel:viewModelReview)
                            }
                        }
                }
            case 1:
                ForEach(Array(viewModel.bookingList.enumerated()),id: \.element.bookingID) { (index,data) in
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
                ForEach(Array(viewModel.bookingList.enumerated()),id: \.element.bookingID) { (index,data) in
                    BookingView(status: "Cancelled",bookingData: data)
                        .asButton(.press) {
                            let viewModelReview = ReviewsViewModel()
                            viewModelReview.bookingsListData = data
                            router.showScreen(.push) { rout in
                                GiveReviewView(viewModel:viewModelReview)
                            }
                        }
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
            
            Text("Pending")
                .tag(1)
                .font(.custom(FontContent.plusRegular, size: 15))
            
            Text("Active")
                .tag(2)
                .font(.custom(FontContent.plusRegular, size: 15))

            Text("Closed")
                .tag(3)
                .font(.custom(FontContent.plusRegular, size: 15))
        }
        .pickerStyle(.segmented)
        .padding(.horizontal, 24)
        .padding(.top, 20)
        .onChange(of: viewModel.selectedSection, { oldValue, newValue in
            viewModel.bookingList = []
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
            viewModel.bookingList = []
            viewModel.getBookings()
        })
    }
}

#Preview {
    BookingScreenView()
}
