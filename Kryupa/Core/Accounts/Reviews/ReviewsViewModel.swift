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
    @Published var bookingsListData: BookingsListData?
    @Published var reviewDetailData: ReviewDetailData?
    @Published var isEditAddress = false
    @Published var isEditReview = false
    @Published var txtReview = ""
    var ratingValue = Int()

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
                    self?.txtReview = data.data.review
                case .failure(let error):
                    self?.isloading = false
                    print(error)
                }
            }
            
        }
    }
    
    func addReview(){
        
        let param: [String : Any] = ["approchId":bookingsListData?.id ?? "",
                     "review":txtReview,
                     "rating":ratingValue]
        
        isloading = true
        NetworkManager.shared.addReview(params: param) { [weak self] result in
            
            DispatchQueue.main.async() {
                self?.isEditReview = false
                switch result{
                case .success(_):
                    self?.isloading = false
                case .failure(let error):
                    self?.isloading = false
                    print(error)
                }
            }
            
        }
    }
    
    func getReview(){
        
        let param: [String : Any] = ["approchId":bookingsListData?.id ?? ""]
        
        isloading = true
        NetworkManager.shared.getBookingReview(params: param) { [weak self] result in
            
            DispatchQueue.main.async() {
                switch result{
                case .success(let data):
                    self?.isloading = false
                    self?.reviewDetailData = data.data
                case .failure(let error):
                    self?.isloading = false
                    print(error)
                }
            }
            
        }
    }
    
}
