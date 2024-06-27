//
//  ReviewsListView.swift
//  Kryupa
//
//  Created by Pooja Nenava on 12/06/24.
//

import SwiftUI
import SwiftfulUI

struct ReviewsListView: View {
    @State var selectedSection = 0
    @Environment(\.router) var router
    @StateObject private var viewModel = ReviewsViewModel()

    var body: some View {
        
        ScrollView {
            HeaderView(showBackButton: true)
            SegmentView
            
            if selectedSection == 0 {
                LazyVStack(spacing: 15) {
                    ForEach(Array(viewModel.myReviewsSeekerList.enumerated()), id: \.offset) { index, model in
                        
                        ReviewCell(reviewData: model)
                            .asButton(.press) {
                                router.showScreen(.push) { rout in
                                    ReviewDetailView(reviewID: model.reviewid)
                                }
                            }
                    }
                }
                .padding(.top, 20)
            }
            else {
                LazyVStack(spacing: 15) {
                    ForEach(Array(viewModel.givenReviewsSeekerList.enumerated()), id: \.offset) { index, model in
                        
                        ReviewCell(reviewData: model)
                            .asButton(.press) {
                                router.showScreen(.push) { rout in
                                    ReviewDetailView(reviewID: model.reviewid)
                                }
                            }
                    }
                }
                .padding(.top, 20)
            }
        }
        .scrollIndicators(.hidden)
        .toolbar(.hidden, for: .navigationBar)
        .onAppear() {
            viewModel.getReviewsSeeker(myReviews: true)
        }
    }
    
    private var SegmentView: some View{
        
        Picker("Reviews", selection: $selectedSection) {
            Text("My Reviews")
                .tag(0)
                .font(.custom(FontContent.plusRegular, size: 12))
            
            Text("Reviews Given")
                .tag(1)
                .font(.custom(FontContent.plusRegular, size: 12))
        }
        .pickerStyle(.segmented)
        .padding(.horizontal, 24)
        .padding(.top, 20)
        .onChange(of: selectedSection, { oldValue, newValue in
            print("Old Value:\(oldValue)")
            print("New Value:\(newValue)")
            if newValue == 0 {
                viewModel.getReviewsSeeker(myReviews: true)
            }
            else {
                viewModel.getReviewsSeeker(myReviews: false)
            }
        })
        
    }
}

#Preview {
    ReviewsListView()
}
