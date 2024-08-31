//
//  AccountsViewModel.swift
//  Kryupa
//
//  Created by Pooja Nenava on 18/06/24.
//

import Foundation

class AccountsViewModel: ObservableObject {
    @Published var profile: ProfileData?
    @Published var isloading: Bool = Bool()
    @Published var profileGiver: ProfileGiverDataClass?

    func getProfile(){
        isloading = true
        NetworkManager.shared.getProfile() { [weak self] result in
            
            DispatchQueue.main.async() {
                switch result{
                case .success(let data):
                    self?.isloading = false
                    self?.profile = data.data
                case .failure(let error):
                    self?.isloading = false
                    print(error)
                }
            }
        }
    }
    
    func getProfileGiver(){
        isloading = true
        NetworkManager.shared.getProfileGiver() { [weak self] result in
            
            DispatchQueue.main.async() {
                switch result{
                case .success(let data):
                    self?.isloading = false
                    self?.profileGiver = data.data
                case .failure(let error):
                    self?.isloading = false
                    print(error)
                }
            }
        }
    }
}
