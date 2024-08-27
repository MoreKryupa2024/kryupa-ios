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
            viewModel.getReviewDetail(reviewID: reviewID, careGiver: Defaults().userType == AppConstants.GiveCare ? true : false)
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
                StarsView(rating: Double(viewModel.reviewDetail?.rating ?? 0), maxRating: 5, size: 12)
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
                ImageLoadingView(imageURL: viewModel.reviewDetail?.profilePictureURL ?? "")
                    .frame(width: 126, height: 126)
                    .cornerRadius(63)
                    .clipped()
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
                StarsView(rating: Double(viewModel.reviewDetail?.averageRating.getFullRateVal() ?? 0), maxRating: 5, size: 12)
                
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
