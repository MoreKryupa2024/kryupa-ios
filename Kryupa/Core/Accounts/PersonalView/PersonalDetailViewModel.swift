//
//  PersonalDetailViewModel.swift
//  Kryupa
//
//  Created by Pooja Nenava on 10/06/24.
//

import Foundation

@MainActor
class PersonalDetailViewModel: ObservableObject{
    
    @Published var additionalInfoSelected: [String] = [String]()
    @Published var education: String = String()
    @Published var educationList = ["Degree 1", "Degree 2", "Degree 3"]
    @Published var languageDropDownSelected: [String] = [String]()
    @Published var languageList = ["Hindi", "English", "French", "Spanish"]
    @Published var isloading: Bool = Bool()
    @Published var personalDetail: PersonalGiverData?

    func uploadProfilePic(file:Data, fileName: String, imageUrl: @escaping(()->Void)){
        isloading = true
        NetworkManager.shared.uploadProfilePicGiver(file: file, fileName: fileName) {[weak self] result in
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
    
    func getPersonalDetails(completion: @escaping(()->Void)){
                
        isloading = true
        NetworkManager.shared.getPersonalDetailsGiver() { [weak self] result in
            
            DispatchQueue.main.async() {
                switch result{
                case .success(let data):
                    self?.isloading = false
                    self?.personalDetail = data.data
                    self?.languageDropDownSelected = self?.personalDetail?.preferredLanguages ?? []
                    completion()
                case .failure(let error):
                    self?.isloading = false
                    print(error)
                }
            }
            
        }
    }
    
    
    func validateData(alert:((String)->Void),next:(([String:Any])->Void)){
        
        if languageDropDownSelected.count == 0 {
            return alert("Please Select Language.")
        }

        var param = [String:Any]()
        
        let expParam = [
            "bio": personalDetail?.expertise.bio ?? "",
            "exprience": personalDetail?.expertise.exprience ?? 0
        ] as [String : Any]
        
        param = ["expertise": expParam,
                 "additional_requirements": additionalInfoSelected,
                 "preferred_languages": languageDropDownSelected]
        
        next(param)
    }
    
    func updateProfile(param: [String:Any], next: @escaping (()->Void)){
        
        isloading = true
        NetworkManager.shared.updateProfile(params: param) { [weak self] result in
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
}
