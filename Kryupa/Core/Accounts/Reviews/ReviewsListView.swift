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
        VStack(spacing:0){
            HeaderView(showBackButton: true)
            SegmentView
            
            if selectedSection == 0 {
                if viewModel.myReviewsList.count == 0{
                    VStack{
                        Spacer()
                        Image("ReviewEmpty")
                            .resizable()
                            .aspectRatio(283/268, contentMode: .fit)
                            .padding(.horizontal,46)
                        Text("Your Review List Looks Empty")
                        Spacer()
                    }
                }else{
                    ScrollView {
                        VStack(spacing: 15) {
                            ForEach(Array(viewModel.myReviewsList.enumerated()), id: \.offset) { index, model in
                                
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
            }
            else {
                if viewModel.givenReviewsList.count == 0{
                    VStack{
                        Spacer()
                        Image("ReviewEmpty")
                            .resizable()
                            .aspectRatio(283/268, contentMode: .fit)
                            .padding(.horizontal,46)
                        Text("Your Review List Looks Empty")
                        Spacer()
                    }
                }else{
                    ScrollView {
                        VStack(spacing: 15) {
                            ForEach(Array(viewModel.givenReviewsList.enumerated()), id: \.offset) { index, model in
                                
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
            }
        }
        .scrollIndicators(.hidden)
        .toolbar(.hidden, for: .navigationBar)
        .onAppear() {
            viewModel.getReviews(myReviews: true, careGiver: Defaults().userType == AppConstants.GiveCare ? true : false)
            NotificationCenter.default.addObserver(forName: .showInboxScreen, object: nil, queue: nil,
                                                 using: self.setChatScreen)
            
        }
    }
    
    private func setChatScreen(_ notification: Notification){
        router.dismissScreenStack()
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
                viewModel.getReviews(myReviews: true, careGiver: Defaults().userType == AppConstants.GiveCare ? true : false)
            }
            else {
                viewModel.getReviews(myReviews: false, careGiver: Defaults().userType == AppConstants.GiveCare ? true : false)
            }
        })
        
    }
}

#Preview {
    ReviewsListView()
}
