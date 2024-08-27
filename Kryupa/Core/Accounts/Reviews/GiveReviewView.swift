//
//  GiveReviewView.swift
//  Kryupa
//
//  Created by Pooja Nenava on 17/06/24.
//

import SwiftUI
import SwiftfulUI

struct GiveReviewView: View {
    
    @StateObject var viewModel = ReviewsViewModel()
    
    var body: some View {
        ZStack{
            VStack(spacing:0){
                HeaderView(showBackButton: true)
                ScrollView {
                    UserView
                    DateTimeView
                    line
                    AddressView
                    line
                    if let reviewDetailData = viewModel.reviewDetailData {
                        ReviewHoursView(ratePerHr: reviewDetailData.ratePerHours, noOfHrs: reviewDetailData.totalHours, total: reviewDetailData.bookingPricingForCustomer)
                    }
                    line
                    WriteReview
                }
                .toolbar(.hidden, for: .navigationBar)
                .onAppear{
                    viewModel.cancelBookingData()
                    viewModel.getReview()
                }
            }
            
            if viewModel.isloading{
                LoadingView()
            }
        }
    }
    
    private var WriteReview: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                HStack {
                    Text("Review:")
                        .font(.custom(FontContent.plusRegular, size: 17))
                        .foregroundStyle(.appMain)
                    
                    Spacer()
                    
                    if !viewModel.isEditReview {
                        Image("edit-two")
                            .frame(width: 17, height: 17)
                        
                        Text("Edit")
                            .font(.custom(FontContent.plusRegular, size: 16))
                            .foregroundStyle(._7_C_7_C_80)
                    }
                    
                }
                .asButton(.press) {
                    viewModel.isEditReview = true
                }
            }
            
            RatingView(rating: viewModel.ratingValue,action: { rating in
                viewModel.ratingValue = (rating + 1)
            })
            .id(viewModel.ratingValue)
            
            TextEditor(text: $viewModel.txtReview)
            .frame(height: 120)
            .keyboardType(.asciiCapable)
            .font(.custom(FontContent.plusRegular, size: 15))
            .padding([.leading,.trailing],10)
            .disabled(viewModel.isEditReview ? false : true)
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(lineWidth: 1)
                    .foregroundStyle(.D_1_D_1_D_6)
                    .frame(height: 125)
            }
            
            if viewModel.isEditReview {
                Text("Submit")
                    .font(.custom(FontContent.plusRegular, size: 16))
                    .foregroundStyle(.white)
                    .frame(height: 35)
                    .frame(width: 96)
                    .background{
                        RoundedRectangle(cornerRadius: 48)
                    }
                    .asButton(.press) {
                        if viewModel.ratingValue == 0{
                            presentAlert(title: "Kryupa", subTitle: "Please Provide Serive Rating in Star")
                        }else if viewModel.txtReview.isEmpty{
                            presentAlert(title: "Kryupa", subTitle: "Please Provide Serive Rating in Description")
                        }else{
                            viewModel.addReview()
                        }
                    }
            }
            
        }
        .padding([.horizontal,.top], 24)
        
    }
    
    private var AddressView: some View{
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Address:")
                    .font(.custom(FontContent.plusRegular, size: 17))
                    .foregroundStyle(.appMain)
                    .disabled(viewModel.isEditAddress ? false : true)
                
                
                Spacer()
                
                //                HStack {
                //                    Image("edit-two")
                //                        .frame(width: 17, height: 17)
                //
                //                    Text("Edit")
                //                        .font(.custom(FontContent.plusRegular, size: 16))
                //                        .foregroundStyle(._7_C_7_C_80)
                //                }
                //                .asButton(.press) {
                //                    viewModel.isEditAddress = true
                //                }
            }
            
            Text((viewModel.cancelSeriveDetailData?.address ?? ""))
                .font(.custom(FontContent.plusRegular, size: 12))
                .foregroundStyle(.appMain)
            
        }
        .padding(.horizontal, 24)
        .padding(.top, 24)
        
    }
    
    private var DateTimeView: some View{
        VStack(alignment: .leading) {
            HStack {
                if let startDate = viewModel.bookingsListData?.startDate, let endDate = viewModel.bookingsListData?.endDate{
                    Text("\(startDate.convertDateFormater(beforeFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", afterFormat: "EEE, d MMMM")) - \(endDate.convertDateFormater(beforeFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", afterFormat: "d MMMM yyyy"))")
                        .font(.custom(FontContent.besMedium, size: 16))
                        .foregroundStyle(.appMain)
                        .padding(.horizontal, 24)
                }
                Spacer()
            }
            .padding(.top, 5)
            
            HStack {
                if let startTime = viewModel.bookingsListData?.startTime, let endTime = viewModel.bookingsListData?.endTime{
                    Text("\(startTime.convertDateFormater(beforeFormat: "HH:mm:ss", afterFormat: "h:mma")) - \(endTime.convertDateFormater(beforeFormat: "HH:mm:ss", afterFormat: "h:mma"))")
                        .font(.custom(FontContent.plusRegular, size: 11))
                        .foregroundStyle(._444446)
                        .padding(.horizontal, 24)
                }
                Spacer()
            }
            .padding(.bottom, 5)
            
        }
        .frame(height: 60)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .inset(by: 1)
                .stroke(.E_5_E_5_EA, lineWidth: 1)
        )
        .padding(.horizontal, 24)
        .padding(.top, 30)
        
    }
    
    private var line: some View {
        Divider()
            .background(.F_2_F_2_F_7)
            .padding(.top, 24)
            .padding(.trailing, 35)
            .frame(height: 2)
    }
    
    private var UserView: some View{
        VStack(spacing:2) {
            ZStack {
                
                Text("Profile")
                    .font(.custom(FontContent.besMedium, size: 20))
                    .foregroundStyle(.appMain)
                
                //                HStack {
                //                    Spacer()
                //                    Text("Download invoice")
                //                        .font(.custom(FontContent.plusRegular, size: 10))
                //                        .foregroundStyle(._7_C_7_C_80)
                //                        .underline()
                //                }
                //                .padding(.trailing, 24)
            }
            
            HStack {
                ImageLoadingView(imageURL: viewModel.bookingsListData?.profilePictureURL ?? "")
                    .frame(width: 126, height: 126)
                    .cornerRadius(63)
                    .clipped()
            }
            .frame(width: 138, height: 138)
            .cornerRadius(69)
            .overlay(
                RoundedRectangle(cornerRadius: 69)
                    .inset(by: 1)
                    .stroke(.E_5_E_5_EA, lineWidth: 1)
            )
            
            Text(viewModel.bookingsListData?.name ?? "")
                .font(.custom(FontContent.besMedium, size: 20))
                .foregroundStyle(.appMain)
            
            Text("$\((viewModel.bookingsListData?.price ?? 0).removeZerosFromEnd(num: 2))")
                .font(.custom(FontContent.plusRegular, size: 12))
                .foregroundStyle(._444446)
            
            HStack {
                
                StarsView(rating: (Double(viewModel.cancelSeriveDetailData?.rating ?? "") ?? 0), maxRating: 5, size: 12)
                Text("(0)")
                    .font(.custom(FontContent.plusRegular, size: 11))
                    .foregroundStyle(.appMain)
            }
            
            Spacer()
            Spacer()
            
            Text(((viewModel.bookingsListData?.status ?? "") != "Job Cancelled" ? "Completed" : "Cancelled"))
                .padding()
                .frame(height: 31)
                .font(.custom(FontContent.plusRegular, size: 16))
                .foregroundStyle((viewModel.bookingsListData?.status ?? "") != "Job Cancelled" ? ._23_C_16_B : .red)
                .background(
                    RoundedRectangle(cornerRadius: 12).fill((viewModel.bookingsListData?.status ?? "") != "Job Cancelled" ? Color.E_0_FFEE : .red.opacity(0.2))
                )
        }
    }
}

#Preview {
    GiveReviewView()
}
