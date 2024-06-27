//
//  ReviewsViewModel.swift
//  Kryupa
//
//  Created by Pooja Nenava on 25/06/24.
//

import Foundation

class ReviewsViewModel: ObservableObject{
    @Published var isloading: Bool = Bool()
    @Published var myReviewsSeekerList = [ReviewSeekerData]()
    @Published var givenReviewsSeekerList = [ReviewSeekerData]()
    @Published var reviewDetail: ReviewDetailData?

    func getReviewsSeeker(myReviews: Bool){
        isloading = true
        NetworkManager.shared.getMyReviewsSeeker(myReviews: myReviews) { [weak self] result in
            
            DispatchQueue.main.async() {
                switch result{
                case .success(let data):
                    self?.isloading = false
                    if myReviews {
                        self?.myReviewsSeekerList = data.data
                    }
                    else{
                        self?.givenReviewsSeekerList = data.data
                    }
                case .failure(let error):
                    self?.isloading = false
                    print(error)
                }
            }
            
        }
    }
    
    func getReviewDetailSeeker(reviewID: String){
        
        let param = ["reviewId": reviewID]
        
        isloading = true
        NetworkManager.shared.viewReviewsSeeker(params: param) { [weak self] result in
            
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
