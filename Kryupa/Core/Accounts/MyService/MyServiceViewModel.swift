//
//  MyServiceViewModel.swift
//  Kryupa
//
//  Created by Pooja Nenava on 11/06/24.
//

import Foundation

@MainActor
class MyServiceViewModel: ObservableObject{
    @Published var selectedSection: Int = 0
    @Published var areaOfExpertiseSelected: [String] = [String]()
    @Published var languageSpeakingSelected: [String] = ["English"]
    @Published var mobilityLevel: String = ""
    @Published var distance: String = "Within 1 mile"
    var areaOfExpertiseList = AppConstants.needServiceInArray
    @Published var mySkillsSelected: [String] = [String]()
    @Published var additionalInfoSelected: [String] = []
    var mySkillsList = AppConstants.additionalSkillsAraay
    @Published var isLoading: Bool = false
    
    func getMyService(){
        isLoading = true
        DispatchQueue.main.async {
            NetworkManager.shared.getMyServices { [weak self] result in
                self?.isLoading = false
                switch result{
                case .success(let data):
                    self?.areaOfExpertiseSelected = data.data.areaOfExperties
                    self?.mySkillsSelected = data.data.skilles
                    
                    self?.distance = data.data.preferences.distance
                    self?.mobilityLevel = data.data.preferences.mobilityLevel
                    self?.additionalInfoSelected = data.data.additionalrequirement
                    self?.languageSpeakingSelected = data.data.preferences.language
                case .failure(let error):
                    print(error.getMessage())
                }
            }
        }
    }
    
    func updateMyService(error: @escaping (String)-> Void){
        DispatchQueue.main.async {
            if self.areaOfExpertiseSelected.count == 0 {
                error("Please select at list one area of Expertise")
                return
            }
            
            let param:[String:Any] = ["skilles":self.mySkillsSelected,
                                      "additional_requirements": self.additionalInfoSelected,
                                      "areaOfExperties":self.areaOfExpertiseSelected]
            self.isLoading = true
            NetworkManager.shared.updateMyService(params: param) { [weak self] result in
                self?.isLoading = false
                switch result{
                case .success(_):
                    error("Your Service Updated Successfully")
                case .failure(let errors):
                    error(errors.getMessage())
                }
            }
        }
    }
}
