//
//  ReviewsViewModel.swift
//  Kryupa
//
//  Created by Pooja Nenava on 25/06/24.
//

import Foundation

class ReviewsViewModel: ObservableObject{
    @Published var isloading: Bool = Bool()
    @Published var myReviewsList = [ReviewData]()
    @Published var givenReviewsList = [ReviewData]()
    @Published var reviewDetail: ReviewDetailData?

    func getReviews(myReviews: Bool, careGiver: Bool){
        isloading = true
        NetworkManager.shared.getMyReviews(myReviews: myReviews, careGiver: careGiver) { [weak self] result in
            
            DispatchQueue.main.async() {
                switch result{
                case .success(let data):
                    self?.isloading = false
                    if myReviews {
                        self?.myReviewsList = data.data
                    }
                    else{
                        self?.givenReviewsList = data.data
                    }
                case .failure(let error):
                    self?.isloading = false
                    print(error)
                }
            }
            
        }
    }
    
    func getReviewDetail(reviewID: String, careGiver: Bool){
        
        let param = ["reviewId": reviewID]
        
        isloading = true
        NetworkManager.shared.viewReviews(careGiver: careGiver, params: param) { [weak self] result in
            
            DispatchQueue.main.async() {
                switch result{
                case .success(let data):
                    self?.isloading = false
                    self?.reviewDetail = data.data
                case .failure(let error):
                    self?.isloading = false
                    print(error)
                }
            }
            
        }
    }
    
}
