//
//  CareGiverHomeScreenViewModel.swift
//  Kryupa
//
//  Created by Pooja Nenava on 12/06/24.
//

import Foundation

class CareGiverHomeScreenViewModel: ObservableObject
{
    @Published var jobsNearYou: [JobPost] = [JobPost]()
    @Published var isloading: Bool = Bool()

    func getJobsNearYouList(){
        
        let param = [
            "pageNumber":1,
            "pageSize":5
        ]
        isloading = true
        NetworkManager.shared.getJobsNearYouList(params: param) { [weak self] result in
            switch result{
            case .success(let data):
                self?.isloading = false
                self?.jobsNearYou = data.data.jobPost
            case .failure(let error):
                self?.isloading = false
                print(error)
            }
        }
    }
}
