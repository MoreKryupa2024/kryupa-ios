//
//  ProfileDetailScreenViewModel.swift
//  Kryupa
//
//  Created by Pooja Nenava on 18/06/24.
//

import Foundation
import SwiftUI

class ProfileDetailScreenViewModel: ObservableObject {
    
    @Published var isloading: Bool = Bool()
    @Published var email: String = String()
    @Published var profileList: ProfileListData?
    @Published var personalDetail: PersonalData?
    @Published var profilePicture: UIImage? = nil
    @Published var selecedProfile = ""

    func getProfileList(){
        isloading = true
        NetworkManager.shared.getProfileList() { [weak self] result in
            
            DispatchQueue.main.async() {
                switch result{
                case .success(let data):
                    guard let self else{return}
                    self.isloading = false
                    self.profileList = data.data
                    guard let profileList = self.profileList else{return}
                    if profileList.profiles.contains(self.selecedProfile){
                        self.getPersonalDetails(profileName: self.selecedProfile)
                    }else{
                        self.selecedProfile = profileList.profiles.first ?? ""
                        self.getPersonalDetails(profileName: profileList.profiles.first ?? "")
                    }
                case .failure(let error):
                    self?.isloading = false
                    print(error)
                }
            }
            
        }
    }
    
    func deleteProfile(next: @escaping (()->Void)){
        isloading = true
        NetworkManager.shared.deleteProfile(params: ["profileId": personalDetail?.profileid ?? ""]) { [weak self] result in
            DispatchQueue.main.async() {
                switch result{
                case .success(_):
                    self?.isloading = false
                    next()
                case .failure(let error):
                    self?.isloading = false
                    print(error)
                }
            }
        }
    }
    
    func getPersonalDetails(profileName: String){
                
        isloading = true
        NetworkManager.shared.getPersonalDetails(params: ["profileName": profileName]) { [weak self] result in
            
            DispatchQueue.main.async() {
                switch result{
                case .success(let data):
                    self?.isloading = false
                    self?.personalDetail = data.data
                case .failure(let error):
                    self?.isloading = false
                    print(error)
                }
            }
            
        }
    }
    
    func uploadProfilePic(profileID: String,file:Data, fileName: String, imageUrl: @escaping(()->Void)){
        isloading = true
        NetworkManager.shared.uploadProfilePicSeeker(profileID: profileID, file: file, fileName: fileName) {[weak self] result in
            DispatchQueue.main.async() {
                switch result{
                case .success(_):
                    self?.isloading = false
                    imageUrl()
                case .failure(let error):
                    self?.isloading = false
                    print(error)
                }
            }
        }
    }
}
