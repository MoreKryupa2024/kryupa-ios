//
//  ReviewDetailView.swift
//  Kryupa
//
//  Created by Pooja Nenava on 13/06/24.
//

import SwiftUI

struct ReviewDetailView: View {
    
    @StateObject private var viewModel = ReviewsViewModel()
    @State var reviewID = ""
    
    var body: some View {
        ScrollView {
            HeaderView(showBackButton: true)
            VStack {
                
                UserView
                line
                ReviewHoursView(ratePerHr: viewModel.reviewDetail?.ratePerHours ?? "0", noOfHrs: viewModel.reviewDetail?.totalHours ?? 0, total: viewModel.reviewDetail?.bookingPricingForCustomer ?? 0)
                line
                ReviewView
            }
        }
        .toolbar(.hidden, for: .navigationBar)
        .onAppear() {
            viewModel.getReviewDetailSeeker(reviewID: reviewID)
        }
    }
    
    private var ReviewView: some View{
        //        HStack {
        VStack(alignment: .leading, spacing: 10) {
            Text("Review:")
                .font(.custom(FontContent.plusMedium, size: 13))
                .foregroundStyle(._7_C_7_C_80)
            
//            HStack(spacing: 1) {
//                ForEach (0...3) {_ in
//                    Image("star")
//                        .resizable()
//                        .frame(width: 20, height: 20)
//                }
//            }
  
            HStack {
                
                ForEach (0...(viewModel.reviewDetail?.rating.getFullRateVal() ?? 0)) {_ in
                    Image("star")
                        .frame(width: 12, height: 12)
                }
                
                if ((viewModel.reviewDetail?.rating.addHalfRateVal()) != nil) {
                    Image("star_half")
                        .frame(width: 12, height: 12)
                }
                
                if viewModel.reviewDetail?.rating.getNoRateValue() ?? 0 > 0 {
                    ForEach (0...(viewModel.reviewDetail?.rating.getNoRateValue() ?? 0)) {_ in
                        Image("star_unselected")
                            .frame(width: 12, height: 12)
                    }
                }
                
            }
            
            
            HStack {
                Text(viewModel.reviewDetail?.review ?? "")
                    .multilineTextAlignment(.leading)
                
                    .font(.custom(FontContent.plusRegular, size: 12))
                    .foregroundStyle(._444446)
                
                Spacer()
            }
        }
        .padding([.top, .horizontal], 24)
    }
    
    private var UserView: some View{
        VStack(spacing: 5) {
            HStack{
                
                AsyncImage(url: URL(string: viewModel.reviewDetail?.profilePictureURL ?? ""),content: { image in
                    image
                        .resizable()
                },placeholder: {
                    if viewModel.reviewDetail?.profilePictureURL != "" && viewModel.reviewDetail?.profilePictureURL != nil{
                        ProgressView()
                    }
                    else {
                        Image("reviewUser")
                            .resizable()
                    }
                })
                .frame(width: 126, height: 126)
                .cornerRadius(63)
                
            }
            .frame(width: 138, height: 138)
            .overlay(
                RoundedRectangle(cornerRadius: 69)
                    .inset(by: 1)
                    .stroke(.E_5_E_5_EA, lineWidth: 1)
            )
            
            Text(viewModel.reviewDetail?.name ?? "Alex")
                .font(.custom(FontContent.besMedium, size: 20))
                .foregroundStyle(.appMain)
            
            HStack {
//                ForEach (0...3) {_ in
//                    Image("star")
//                        .resizable()
//                        .frame(width: 12, height: 12)
//                }
                
                    
                    ForEach (0...(viewModel.reviewDetail?.averageRating.getFullRateVal() ?? 0)) {_ in
                        Image("star")
                            .frame(width: 12, height: 12)
                    }
                    
                    if ((viewModel.reviewDetail?.averageRating.addHalfRateVal()) != nil) {
                        Image("star_half")
                            .frame(width: 12, height: 12)
                    }
                    
                    if viewModel.reviewDetail?.averageRating.getNoRateValue() ?? 0 > 0 {
                        ForEach (0...(viewModel.reviewDetail?.averageRating.getNoRateValue() ?? 0)) {_ in
                            Image("star_unselected")
                                .frame(width: 12, height: 12)
                        }
                    }
                    
                
                
                Text("(\(viewModel.reviewDetail?.averageRating ?? "0"))")
                    .font(.custom(FontContent.plusRegular, size: 11))
                    .foregroundStyle(.appMain)
            }
        }
        .padding(.top, 20)
    }
    
    private var line: some View {
        Divider()
            .background(.F_2_F_2_F_7)
            .padding(.top, 24)
            .padding(.horizontal, 24)
            .frame(height: 2)
    }
}

#Preview {
    ReviewDetailView()
}
