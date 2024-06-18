//
//  RecommendedCareGiverDetailScreenViewModel.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 06/06/24.
//

import Foundation
@MainActor
class RecommendedCareGiverDetailScreenViewModel: ObservableObject{
    
    var options: [String] = ["Summary","Review"]
    @Published var selection: String = "Summary"
    @Published var isloading: Bool = true
    @Published var giverDetail: CareGiverDetailData?
    
    
    func getCareGiverDetails(giverId:String){
        isloading = true
        NetworkManager.shared.getCareGiverDetails(giverId: giverId) { [weak self] result in
            DispatchQueue.main.async {
                switch result{
                case .success(let data):
                    self?.giverDetail = data.data
                    self?.isloading = false
                case .failure(let error):
                    self?.isloading = false
                    print(error)
                }
            }
        }
    }
}
