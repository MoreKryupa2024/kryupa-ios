//
//  CareSeekerHomeScreenViewModel.swift
//  Kryupa
//
//  Created by Hemant Singh Rajput on 04/06/24.
//

import Foundation

class CareSeekerHomeScreenViewModel: ObservableObject{
    @Published var isloading: Bool = Bool()
    
    @Published var recommendedCaregiver: [RecommendedCaregiver] = [RecommendedCaregiver]()
    
    func getRecommandationList(){
        
        let param = [
            "pageNumber":1,
            "pageSize":10
        ]
        isloading = true
        NetworkManager.shared.getRecommandationList(params: param) { [weak self] result in
            switch result{
            case .success(let data):
                self?.isloading = false
                self?.recommendedCaregiver = data.data.recommendedCaregiver
            case .failure(let error):
                self?.isloading = false
                print(error)
            }
        }
    }
    
}
