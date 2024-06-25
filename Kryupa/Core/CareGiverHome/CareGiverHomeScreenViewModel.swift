//
//  CareGiverHomeScreenViewModel.swift
//  Kryupa
//
//  Created by Pooja Nenava on 12/06/24.
//

import Foundation
import Combine

@MainActor
class CareGiverHomeScreenViewModel: ObservableObject
{
    @Published var jobsNearYou: [JobPost] = [JobPost]()
    @Published var isloading: Bool = Bool()

    func getJobsNearYouList(completion: @escaping (()->Void)){
        
        let param = [
            "pageNumber":1,
            "pageSize":5
        ]
        isloading = true
        NetworkManager.shared.getJobsNearYouList(params: param) { [weak self] result in
            
            DispatchQueue.main.async() {
                switch result{
                case .success(let data):
                    self?.isloading = false
                    self?.jobsNearYou = data.data.jobPost
                    completion()
                case .failure(let error):
                    self?.isloading = false
                    print(error)
                }
            }
            
        }
    }
}
